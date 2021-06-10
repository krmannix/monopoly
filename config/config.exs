# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :monopoly,
  ecto_repos: [Monopoly.Repo]

# Configures the endpoint
config :monopoly, MonopolyWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "5yGroFPB04xfJHQZGV2NcmTP6P5Jj/La/yFx1T6bhbcAkarY8UE+Im44rxZeMmEN",
  render_errors: [view: MonopolyWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: Monopoly.PubSub,
  live_view: [signing_salt: "JkfsUxAN"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
