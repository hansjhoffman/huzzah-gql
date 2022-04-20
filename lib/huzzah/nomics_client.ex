defmodule Huzzah.NomicsClient do
  @moduledoc """
  Implements a wrapper around the Nomics crypto API.

  https://nomics.com/docs
  """

  use Tesla, only: [:get]

  plug Tesla.Middleware.BaseUrl, "https://api.nomics.com/v1"
  plug Tesla.Middleware.JSON
  plug Tesla.Middleware.Query, key: System.get_env("NOMICS_API_KEY")
  plug Tesla.Middleware.Telemetry

  def market_cap(count \\ 10, page \\ 1) do
    url =
      Tesla.build_url("/currencies/ticker",
        interval: "1d",
        convert: "USD",
        sort: "rank",
        "per-page": count,
        page: page
      )

    get(url)
  end
end
