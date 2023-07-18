defmodule CommonComponentsWeb.PageController do
  use CommonComponentsWeb, :controller

  def home(conn, _params) do
    # The home page is often custom made,
    # so skip the default app layout.
    render(conn, :home, layout: false)
  end

  def button(conn, _params) do
    render(conn, :button, layout: false)
  end

  def rainbow(conn, _params) do
    render(conn, :rainbow, layout: false)
  end

  def card(conn, _params) do
    render(conn, :card, layout: false)
  end
end
