defmodule PhoenixNavigationWeb.PageController do
  use PhoenixNavigationWeb, :controller

  def home(conn, _params) do
    # The home page is often custom made,
    # so skip the default app layout.
    render(conn, :home, layout: false)
  end

  def about(conn, _params) do
    render(conn, :about, layout: false)
  end

  def projects(conn, _params) do
    render(conn, :projects, layout: false)
  end
end
