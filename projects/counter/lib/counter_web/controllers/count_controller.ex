defmodule CounterWeb.CountController do
  use CounterWeb, :controller

  def count(conn, %{"count" => count}) do
    render(conn, :count, count: String.to_integer(count))
  end

  def count(conn, _params) do
    render(conn, :count, count: 0)
  end

  def increment(conn, %{"count" => count, "increment" => increment}) do
    render(conn, :count, count: String.to_integer(count) + String.to_integer(increment))
  end

  def increment(conn, _params) do
    render(conn, :count, count: 0)
  end
end
