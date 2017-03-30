defmodule GithubScraper.Mixfile do
  use Mix.Project

  def project do
    [app: :github_scraper,
     version: "0.1.0",
     build_path: "../../_build",
     config_path: "../../config/config.exs",
     deps_path: "../../deps",
     lockfile: "../../mix.lock",
     elixir: "~> 1.4",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps()]
  end

  def application do
    [
      extra_applications: [:logger],
      applications: [
        :httpoison,
        :quantum
      ]
    ]
  end

  defp deps do
    [
      {:quantum, ">= 1.9.1"},
      {:httpoison, "~>0.11"},
      {:poison, "~>2.0"},
      {:scoring_api, in_umbrella: true}
    ]
  end
end
