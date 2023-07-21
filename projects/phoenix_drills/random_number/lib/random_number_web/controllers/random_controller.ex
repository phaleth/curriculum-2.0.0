defmodule RandomNumberWeb.RandomController do
  use RandomNumberWeb, :controller

  def random(conn, _params) do
    render(conn, :random, layout: false, random_number: Enum.random(1..100))
  end
end
