use Mix.Config

config :quantum, :github_scraper,
  cron: [
    "* * * * *": {"GithubScraper", :scrape}
  ]

config :ex_github, access_token: System.get_env("GITHUB_ACCESS_TOKEN")

import_config "#{Mix.env}.exs"
