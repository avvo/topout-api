defmodule Release.Tasks do
  @moduledoc false
  
  def migrate(echo) do
    {:ok, _} = Application.ensure_all_started(:scoring_api)

    path = Application.app_dir(:scoring_api, "priv/repo/migrations")

    IO.puts("The migration path is: #{path}")

    Ecto.Migrator.run(ScoringApi.Repo, path, :up, all: true)

    { :ok, echo }
  end

  def help(echo) do
    IO.puts("About to run migrations: #{echo}")
    { :ok, echo }
  end
end