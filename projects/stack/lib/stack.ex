defmodule Stack do
  use GenServer

  @moduledoc """
  Documentation for `Stack`.
  """

  # client
  def start_link(opts \\ []) do
    opts = Keyword.put_new(opts, :state, [])
    GenServer.start_link(__MODULE__, opts)
  end

  def push(stack, item) do
    GenServer.call(stack, {:push, item})
  end

  def pop(stack, num_to_pop \\ 1) do
    GenServer.call(stack, {:pop, num_to_pop})
  end

  # server
  @impl true
  def init(opts) do
    {:ok, opts[:state]}
  end

  @impl true
  def handle_call({:push, new_item}, _from, state) do
    response = :ok
    {:reply, response, [new_item | state]}
  end

  @impl true
  def handle_call({:pop, _}, _from, []), do: {:reply, {:error, :empty}, []}

  def handle_call({:pop, amount}, _from, state) when amount > length(state),
    do: {:reply, {:error, :not_enough_elements}, state}

  def handle_call({:pop, amount}, _from, state) do
    {response, new_state} = Enum.split(state, amount)
    {:reply, {:ok, response}, new_state}
  end
end
