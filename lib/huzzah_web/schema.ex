defmodule HuzzahWeb.Schema do
  @moduledoc """
  GraphQL schema
  """

  use Absinthe.Schema

  alias HuzzahWeb.Resolvers

  import_types(__MODULE__.AssetTypes)
  import_types(__MODULE__.MarketTypes)

  scalar :asset_id do
    description("""
    The `AssetId` custom scalar type represents a unique node identifier. The AssetId appears
    in a JSON response as a string (the same as a normal ID scalar type).
    """)

    parse(&parse_string/1)
    serialize(& &1)
  end

  defp parse_string(%Absinthe.Blueprint.Input.String{value: value}), do: {:ok, value}
  defp parse_string(_), do: :error

  query do
    @desc "Get details about an asset"
    field :asset, type: :asset do
      arg(:id, non_null(:asset_id))

      resolve(&Resolvers.AssetResolver.get_asset/3)
    end

    @desc "Get market summary data"
    field :market, list_of(non_null(:summary)) do
      arg(:fiat, non_null(:fiat))

      resolve(&Resolvers.MarketResolver.market/3)
    end
  end
end
