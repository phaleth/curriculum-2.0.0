defmodule TrafficLights.LightTest do
  use ExUnit.Case
  doctest TrafficLights.Light
  alias TrafficLights.Light, as: L

  describe "traffic light state" do
    test "initial light should be green" do
      {:ok, traffic_light} = L.start_link([])
      assert L.current_light(traffic_light) === :green
    end

    test "after green comes yellow" do
      {:ok, traffic_light} = L.start_link([])
      L.transition(traffic_light)
      assert L.current_light(traffic_light) === :yellow
    end

    test "after yellow comes red" do
      {:ok, traffic_light} = L.start_link([])
      L.transition(traffic_light)
      L.transition(traffic_light)
      assert L.current_light(traffic_light) === :red
    end

    test "after red recycle to green" do
      {:ok, traffic_light} = L.start_link([])
      L.transition(traffic_light)
      L.transition(traffic_light)
      L.transition(traffic_light)
      assert L.current_light(traffic_light) === :green
    end
  end
end
