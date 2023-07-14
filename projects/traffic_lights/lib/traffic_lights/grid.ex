defmodule TrafficLights.Grid do
  use GenServer

  def start_link(_opts) do
    GenServer.start_link(__MODULE__, [])
  end

  def current_lights(traffic_grid) do
    GenServer.call(traffic_grid, :current_lights)
  end

  def transition(traffic_grid) do
    GenServer.cast(traffic_grid, :transition)
  end

  @impl true
  def init(_opts) do
    traffic_lights =
      Enum.map(1..5, fn _ ->
        {:ok, traffic_light} = TrafficLights.Light.start_link([])
        traffic_light
      end)

    {:ok, [light_pids: traffic_lights, light_index: 0]}
  end

  @impl true
  def handle_call(:current_lights, _from, state) do
    traffic_lights = Keyword.get(state, :light_pids)
    response = Enum.map(traffic_lights, &TrafficLights.Light.current_light(&1))
    {:reply, response, state}
  end

  @impl true
  def handle_cast(:transition, state) do
    traffic_lights = Keyword.get(state, :light_pids)

    {current_index, new_state} =
      Keyword.get_and_update(state, :light_index, fn current ->
        {current, if(current === 4, do: 0, else: current + 1)}
      end)

    TrafficLights.Light.transition(Enum.at(traffic_lights, current_index))

    {:noreply, new_state}
  end
end
