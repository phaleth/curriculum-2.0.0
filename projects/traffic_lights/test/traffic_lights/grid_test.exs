defmodule TrafficLights.GridTest do
  use ExUnit.Case
  doctest TrafficLights.Grid
  alias TrafficLights.Grid, as: G

  describe "traffic grid state" do
    test "initially all lights should be green" do
      {:ok, traffic_grid} = G.start_link([])
      assert G.current_lights(traffic_grid) === [:green, :green, :green, :green, :green]
    end

    test "single transition call should transition light at current index" do
      {:ok, traffic_grid} = G.start_link([])
      G.transition(traffic_grid)
      assert G.current_lights(traffic_grid) === [:yellow, :green, :green, :green, :green]
    end

    test "many transition calls should transition lights one after another" do
      {:ok, traffic_grid} = G.start_link([])
      G.transition(traffic_grid)
      G.transition(traffic_grid)
      G.transition(traffic_grid)
      G.transition(traffic_grid)
      G.transition(traffic_grid)
      G.transition(traffic_grid)
      G.transition(traffic_grid)
      G.transition(traffic_grid)
      G.transition(traffic_grid)
      G.transition(traffic_grid)
      G.transition(traffic_grid)
      assert G.current_lights(traffic_grid) === [:green, :red, :red, :red, :red]
    end
  end
end
