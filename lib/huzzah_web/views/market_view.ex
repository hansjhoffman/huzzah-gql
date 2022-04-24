defmodule HuzzahWeb.MarketView do
  use HuzzahWeb, :view

  def render("index.json", %{assets: assets}) do
    %{
      data:
        List.foldl(assets, [], fn asset, acc ->
          [
            %{
              logo_url: asset["logo_url"],
              market_cap:
                case Float.parse(asset["market_cap"]) do
                  :error ->
                    Float.to_string(0.00)

                  {val, _} ->
                    short_form(val)
                end,
              name: asset["name"],
              price_change_pct: asset["1d"]["price_change_pct"],
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
        |> Enum.reverse()
    }
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
