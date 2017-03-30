defmodule ScoringApi.GithubCommitView do
  use ScoringApi.Web, :view

  def render("index.json", %{github_commits: github_commits}) do
    %{data: render_many(github_commits, ScoringApi.GithubCommitView, "github_commit.json")}
  end

  def render("show.json", %{github_commit: github_commit}) do
    %{data: render_one(github_commit, ScoringApi.GithubCommitView, "github_commit.json")}
  end

  def render("github_commit.json", %{github_commit: github_commit}) do
    %{id: github_commit.id,
      github_id: github_commit.github_id,
      email: github_commit.email,
      display_name: github_commit.display_name,
      commit_id: github_commit.commit_id,
      repo: github_commit.repo}
  end
end
