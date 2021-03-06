defmodule HuzzahWeb.Schema.MarketTypes do
  @moduledoc """
  Provides GraphQL types for the crypto market.
  """

  use Absinthe.Schema.Notation

  enum :fiat do
    value(:eur, as: "EUR")
    value(:usd, as: "USD")
  end

  @desc "Summary of a cryptocurrency asset"
  object(:summary) do
    @desc "Custom scaler id of the asset"
    field(:id, non_null(:asset_id))

    @desc "The amount of coins that are circulating in the market and are in public hands"
    field(:circulating_supply, non_null(:string))

    @desc "Image url"
    field(:logo_url, non_null(:string))

    @desc "Total market cap"
    field(:market_cap, non_null(:string))

    @desc "The maximum amount of coins that will ever exist in the lifetime of the cryptocurrency"
    field(:max_supply, :string)

    @desc "Display name"
    field(:name, non_null(:string))

    @desc "1D price change in percent"
    field(:percent_change, non_null(:float))

    @desc "Current price"
    field(:price, non_null(:string))

    @desc "Rank by market cap"
    field(:rank, non_null(:string))

    @desc "Symbol"
    field(:symbol, non_null(:string))
  end
end
