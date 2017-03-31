use Mix.Config

config :quantum, :github_scraper,
  cron: [
    "*/39 * * * *": {"GithubScraper", :scrape}
  ]

import_config "#{Mix.env}.exs"
