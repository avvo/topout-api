defmodule ScoringApi.UserScores do
  use ScoringApi.Web, :model

  schema "user_scores" do
    field :github_id, :string

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:github_id])
    |> validate_required([:github_id])
  end
end
