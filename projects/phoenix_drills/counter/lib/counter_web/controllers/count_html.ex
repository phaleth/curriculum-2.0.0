defmodule CounterWeb.CountHTML do
  use CounterWeb, :html

  def count(assigns) do
    ~H"""
    <p>Count is <%= @count %></p>
    <.link navigate={~p"/count?count=#{@count + 1}"}>Increment the count</.link>
    <.form :let={f} for={%{}} action={~p"/count"}>
      <.input type="hidden" field={f[:count]} value={@count} />
      <.input type="number" field={f[:increment]} />
      <.button type="submit">Submit</.button>
    </.form>
    """
  end
end
