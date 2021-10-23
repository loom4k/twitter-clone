defmodule Twitterclone.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      Twitterclone.Repo,
      # Start the Telemetry supervisor
      TwittercloneWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Twitterclone.PubSub},
      # Start the Endpoint (http/https)
      TwittercloneWeb.Endpoint
      # Start a worker by calling: Twitterclone.Worker.start_link(arg)
      # {Twitterclone.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Twitterclone.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    TwittercloneWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
