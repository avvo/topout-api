defmodule ScoringApi.Repo.Migrations.AddUserScoreTable do
  use Ecto.Migration

  def change do
    create table(:user_scores) do
      add :github_id,       :string, size: 80
      add :display_name,    :string, size: 40
      add :count,           :integer
      timestamps()
    end
  end
end
