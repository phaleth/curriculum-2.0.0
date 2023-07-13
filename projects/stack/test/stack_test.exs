defmodule StackTest do
  use ExUnit.Case
  alias Stack, as: S
  doctest Stack

  #   start_link/1 - default state
  # start_link/1 - default configuration
  # pop/1 - remove one element from stack
  # pop/1 - remove multiple elements from stack
  # pop/1 - remove element from empty stack
  # push/2 - add element to empty stack
  # push/2 - add element to stack with multiple elements

  describe "start_link/1" do
    test "start returns ok pid with arg" do
      assert match?({:ok, stack}, S.start_link(state: [1, 2, 3]))
    end

    test "start returns ok pid with no arg" do
      assert match?({:ok, stack}, S.start_link())
    end
  end

  describe "pop/2" do
    test "remove one element from stack" do
      {:ok, stack} = S.start_link([])
      S.push(stack, 2)
      amount = 1
      assert S.pop(stack, amount) === {:ok, [2]}
    end

    test "remove multiple elements from stack" do
      {:ok, stack} = S.start_link([])
      S.push(stack, 2)
      S.push(stack, 3)
      amount = 2
      assert S.pop(stack, amount) === {:ok, [3, 2]}
    end

    test "remove multiple elements from stack without enough elements" do
      {:ok, stack} = S.start_link([])
      S.push(stack, 2)
      S.push(stack, 3)
      amount = 3
      assert S.pop(stack, amount) === {:error, :not_enough_elements}
    end

    test "remove element from empty stack" do
      {:ok, stack} = S.start_link([])
      assert S.pop(stack, 1) === {:error, :empty}
    end
  end

  describe "push/2" do
    test "push a single element to empty stack" do
      {:ok, stack} = S.start_link([])
      assert S.push(stack, 1) == :ok
      assert S.pop(stack) == {:ok, [1]}
    end

    test "push a single element to a non-empty stack" do
      {:ok, stack} = S.start_link(state: [2, 3])
      assert S.push(stack, 1) == :ok
      assert S.pop(stack) == {:ok, [1]}
    end
  end
end
