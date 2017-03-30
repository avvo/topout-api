defmodule ScoringApi.Repo.Migrations.CreateGithubCommit do
  use Ecto.Migration

  def change do
    create table(:github_commits) do
      add :github_id, :string
      add :email, :string
      add :display_name, :string
      add :commit_id, :string, null: false
      add :repo, :string

      timestamps()
    end

    create unique_index(:github_commits, [:commit_id])
  end
end
