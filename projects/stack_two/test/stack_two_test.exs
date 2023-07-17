defmodule StackTwoTest do
  use ExUnit.Case
  doctest StackTwo

  @tag skip
  test "greets the world" do
    assert StackTwo.hello() == :world
  end
end
