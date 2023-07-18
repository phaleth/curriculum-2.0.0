defmodule NinetyNineBottlesTest do
  use ExUnit.Case
  doctest NinetyNineBottles

  test "greets the world" do
    assert NinetyNineBottles.hello() == :world
  end
end
