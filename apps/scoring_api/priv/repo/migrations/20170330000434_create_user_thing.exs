defmodule ScoringApi.Repo.Migrations.CreateUserThing do
  use Ecto.Migration

  def change do
    create table(:user_things) do
      add :name, :string

      timestamps()
    end

  end
end
