defmodule RandomNumberWeb.RandomHTML do
  use RandomNumberWeb, :html

  def random(assigns) do
    ~H"""
    <p>Random number: <%= @random_number %></p>
    """
  end
end
