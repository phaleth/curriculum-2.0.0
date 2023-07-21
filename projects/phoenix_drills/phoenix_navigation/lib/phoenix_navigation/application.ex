defmodule PhoenixNavigation.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      PhoenixNavigationWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: PhoenixNavigation.PubSub},
      # Start Finch
      {Finch, name: PhoenixNavigation.Finch},
      # Start the Endpoint (http/https)
      PhoenixNavigationWeb.Endpoint
      # Start a worker by calling: PhoenixNavigation.Worker.start_link(arg)
      # {PhoenixNavigation.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: PhoenixNavigation.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    PhoenixNavigationWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
