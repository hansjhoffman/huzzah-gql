# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :huzzah,
  ecto_repos: [Huzzah.Repo],
  generators: [binary_id: true]

# Configures the endpoint
config :huzzah, HuzzahWeb.Endpoint,
  url: [host: "localhost"],
  render_errors: [view: HuzzahWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: Huzzah.PubSub,
  live_view: [signing_salt: "T9gfCIm9"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Configures tesla adapters
config :tesla, adapter: Tesla.Adapter.Hackney

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
