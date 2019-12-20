# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
use Mix.Config

# This configuration is loaded before any dependency and is restricted
# to this project. If another project depends on this project, this
# file won't be loaded nor affect the parent project. For this reason,
# if you want to provide default values for your application for
# 3rd-party users, it should be done in your "mix.exs" file.

# You can configure your application as:
#
#     config :crawly, key: :value
#
# and access this configuration in your application as:
#
#     Application.get_env(:crawly, :key)
#
# You can also configure a 3rd-party app:
#
#     config :logger, level: :info
#

# It is also possible to import configuration files, relative to this
# directory. For example, you can emulate configuration per environment
# by uncommenting the line below and defining dev.exs, test.exs and such.
# Configuration from the imported file will override the ones defined
# here (which is why it is important to import them last).
#
#     import_config "#{Mix.env}.exs"

config :crawly, Crawly.Worker, client: HTTPoison

config :crawly,
  fetcher: {Crawly.Fetchers.HTTPoisonFetcher, []},
  max_retries: 3,
  # User agents which are going to be used with requests
  user_agents: [
    "Mozilla/5.0 (Macintosh; Intel Mac OS X x.y; rv:42.0) Gecko/20100101 Firefox/42.0",
    "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/51.0.2704.103 Safari/537.36",
    "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/51.0.2704.106 Safari/537.36 OPR/38.0.2220.41"
  ],
  # Item definition
  item: [:title, :author, :time, :url],
  # Identifier which is used to filter out duplicates
  item_id: :title,
  # Stop spider after scraping certain amount of items
  closespider_itemcount: 500,
  # Stop spider if it does crawl fast enough
  closespider_timeout: 20,
  concurrent_requests_per_domain: 5,
  follow_redirects: true,
  # Request middlewares
  middlewares: [
    Crawly.Middlewares.DomainFilter,
    Crawly.Middlewares.UniqueRequest,
    Crawly.Middlewares.RobotsTxt,
    Crawly.Middlewares.UserAgent
  ],
  pipelines: [
    Crawly.Pipelines.Validate,
    Crawly.Pipelines.DuplicatesFilter,
    Crawly.Pipelines.JSONEncoder
  ]

config :crawly, Crawly.Pipelines.WriteToFile,
  folder: "/tmp",
  extension: "jl"

 import_config "#{Mix.env}.exs"
