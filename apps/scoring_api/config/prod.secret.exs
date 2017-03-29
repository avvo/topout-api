use Mix.Config

# In this file, we keep production configuration that
# you likely want to automate and keep it away from
# your version control system.
#
# You should document the content of this
# file or create a script for recreating it, since it's
# kept out of version control and might be hard to recover
# or recreate for your teammates (or you later on).
config :scoring_api, ScoringApi.Endpoint,
  secret_key_base: "pICjJA8zLwheNPviT6ny/bJbR7xk2/Xf/Re2EviiS1X4qQm9wLauJoEqg6azLwGD"

# Configure your database
config :scoring_api, ScoringApi.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "scoring_api_prod",
  pool_size: 20
