defmodule GreetingTest do
  use ExUnit.Case
  doctest Greeting

  @tag :skip
  test "greets the world" do
    assert Greeting.hello() == :world
  end
end
