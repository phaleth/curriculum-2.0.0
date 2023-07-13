defmodule TrafficLights.Light do
  use GenServer

  def start_link(opts) do
    GenServer.start_link(__MODULE__, opts)
  end

  def current_light(traffic_light) do
    GenServer.call(traffic_light, :current_light)
  end

  def transition(traffic_light) do
    GenServer.cast(traffic_light, :transition)
  end

  @impl true
  def init(_opts) do
    {:ok, :green}
  end

  @impl true
  def handle_call(:current_light, _from, state) do
    response = state
    {:reply, response, state}
  end

  @impl true
  def handle_cast(:transition, state) do
    case state do
      :green -> {:noreply, :yellow}
      :yellow -> {:noreply, :red}
      :red -> {:noreply, :green}
    end
  end
end
