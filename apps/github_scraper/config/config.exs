use Mix.Config

config :quantum, :github_scraper,
  cron: [
    "* * * * *": {"GithubScraper", :scrape}
  ]

import_config "#{Mix.env}.exs"
