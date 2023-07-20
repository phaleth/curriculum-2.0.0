defmodule CounterWeb.CountHTML do
  use CounterWeb, :html

  def count(assigns) do
    ~H"""
    <p>Count is <%= @count %></p>
    <.link navigate={~p"/count?count=#{@count + 1}"}>Increment count</.link>
    <.form :let={f} for={%{}} action={~p"/count"}>
      <.input type="number" field={f[:increment]} />
      <.input type="hidden" field={f[:count]} value={@count} />
      <.button type="submit">Submit</.button>
    </.form>
    <%= for num <- 1..10 do %>
      <p><%= num %></p>
    <% end %>
    """
  end
end
