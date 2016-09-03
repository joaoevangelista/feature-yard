# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :featureyard,
  ecto_repos: [Featureyard.Repo]

# Configures the endpoint
config :featureyard, Featureyard.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "PPCbxEWNmtnUf97mk9ZjGLao6ZG6gVePWqRRYbMasEv+cYxbREZNfXOGUIW2jpn9",
  render_errors: [view: Featureyard.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Featureyard.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :guardian, Guardian,
  issuer: "Featureyard.#{Mix.env}",
  ttl: { 30, :days },
  secret_key: System.get_env("SECRET_KEY_BASE"),
  serializer: Featureyard.GuardianSerializer

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
