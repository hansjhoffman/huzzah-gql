defmodule HuzzahWeb.Resolvers.MarketResolver do
  @moduledoc """
  Provides resolver functions for Market queries.
  """

  alias Huzzah.NomicsClient

  # headers: [
  #     {"x-pagination-total-items", "51118"},
  #   ],
  def market(_parent, args, _resolution) do
    {:ok, %Tesla.Env{} = response} = NomicsClient.market(args)

    {:ok,
     List.foldl(response.body, [], fn asset, acc ->
       [
         %{
           id:
             (asset["symbol"] <> " " <> asset["name"])
             |> String.replace(" ", "-")
             |> String.downcase(),
           circulating_supply: asset["circulating_supply"],
           logo_url: asset["logo_url"],
           market_cap:
             case Float.parse(asset["market_cap"]) do
               :error ->
                 Float.to_string(0.00)

               {val, _} ->
                 short_form(val)
             end,
           max_supply: asset["max_supply"],
           name: asset["name"],
           percent_change:
             case Float.parse(asset["1d"]["price_change_pct"]) do
               :error ->
                 0.00

               {val, _} ->
                 Float.round(val, 2)
             end,
           price:
             case Float.parse(asset["price"]) do
               :error ->
                 0.00

               {val, _} ->
                 round_price(val)
             end
             |> Float.to_string(),
           rank: asset["rank"],
           symbol: asset["symbol"]
         }
         | acc
       ]
     end)
     |> Enum.reverse()}
  end

  defp round_price(price) when is_float(price) do
    cond do
      price < 1 -> Float.round(price, 6)
      price > 1 and price < 2 -> Float.round(price, 4)
      price > 2 -> Float.round(price, 2)
    end
  end

  defp short_form(val) when is_float(val) do
    cond do
      val >= 1_000_000_000_000 and val <= 999_999_999_999_999 ->
        Float.round(val / 1_000_000_000_000, 2)
        |> (&(Float.to_string(&1) <> "T")).()

      val >= 1_000_000_000 and val <= 999_999_999_999 ->
        Float.round(val / 1_000_000_000, 2)
        |> (&(Float.to_string(&1) <> "B")).()

      val >= 1_000_000 and val <= 999_999_999 ->
        Float.round(val / 1_000_000, 2)
        |> (&(Float.to_string(&1) <> "M")).()

      val >= 1_000 and val <= 999_999 ->
        Float.round(val / 1_000, 2)
        |> (&(Float.to_string(&1) <> "K")).()

      true ->
        Float.to_string(val)
    end
  end
end

# type PageInfo =
#   page
#   totalCount
#   hasNextPage
#   hasPreviousPage
