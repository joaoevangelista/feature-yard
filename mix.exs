defmodule Featureyard.Mixfile do
  use Mix.Project

  def project do
    [app: :featureyard,
    version: "0.0.1",
    elixir: "~> 1.2",
    elixirc_paths: elixirc_paths(Mix.env),
    compilers: [:phoenix, :gettext] ++ Mix.compilers,
    build_embedded: Mix.env == :prod,
    start_permanent: Mix.env == :prod,
    aliases: aliases(),
    deps: deps()]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [mod: {Featureyard, []},
    applications: [:phoenix, :phoenix_pubsub, :phoenix_html, :cowboy, :logger, :gettext,
    :phoenix_ecto, :postgrex, :comeonin]]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "web", "test/support"]
  defp elixirc_paths(_),     do: ["lib", "web"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [{:phoenix, "~> 1.2.1"},
    {:ecto, "~> 2.0.4", override: true},
    {:ex_machina, "~> 1.0", only: :test},
    {:poison, "~> 2.2.0", override: true},
    {:phoenix_pubsub, "~> 1.0"},
    {:phoenix_ecto, "~> 3.0"},
    {:postgrex, ">= 0.0.0"},
    {:phoenix_html, "~> 2.6"},
    {:phoenix_live_reload, "~> 1.0", only: :dev},
    {:gettext, "~> 0.11"},
    {:cowboy, "~> 1.0"},
    { :uuid, "~> 1.1" },
    {:credo, "~> 0.4", only: [:dev, :test]},
    {:comeonin, "~> 2.5"},
    {:guardian, "~> 0.12.0"},
    {:gen_guardian, git: "https://github.com/victorlcampos/gen_guardian", only: :dev},
    # monitoring stack
    {:exometer_core, github: "PSPDFKit-labs/exometer_core", override: true},
    {:exometer, github: "PSPDFKit-labs/exometer"},
    {:edown, github: "uwiger/edown", tag: "0.7", override: true}
  ]
end

# Aliases are shortcuts or tasks specific to the current project.
# For example, to create, migrate and run the seeds file at once:
#
#     $ mix ecto.setup
#
# See the documentation for `Mix` for more info on aliases.
defp aliases do
  ["ecto.setup": ["ecto.create", "ecto.migrate", "run priv/repo/seeds.exs"],
  "ecto.reset": ["ecto.drop", "ecto.setup"],
  "test": ["ecto.create --quiet", "ecto.migrate", "test"]]
end
end
