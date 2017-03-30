defmodule ScoringApi.GithubCommit do
  use ScoringApi.Web, :model

  schema "github_commits" do
    field :github_id, :string
    field :email, :string
    field :display_name, :string
    field :commit_id, :string
    field :repo, :string

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:github_id, :email, :display_name, :commit_id, :repo])
    |> validate_required([:github_id, :commit_id, :repo])
    |> unique_constraint(:commit_id)
  end
end
