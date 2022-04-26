defmodule HuzzahWeb.Schema.Query.MarketTest do
  use HuzzahWeb.ConnCase, async: true

  describe "market" do
    @market_query """
    query getMarketData($fiat: Fiat!) {
      market(fiat: $fiat) {
        id
        name
      }
    }
    """

    test "success", %{conn: conn} do
      Tesla.Mock.mock(fn %{method: :get} ->
        %Tesla.Env{
          status: 200,
          body: [
            %{
              "1d" => %{
                "market_cap_change" => "6227514980.81",
                "market_cap_change_pct" => "0.0071",
                "price_change" => "325.86151000",
                "price_change_pct" => "0.0070",
                "volume" => "35574333684.93",
                "volume_change" => "-11260252270.04",
                "volume_change_pct" => "-0.2404"
              },
              "circulating_supply" => "19001687",
              "currency" => "BTC",
              "first_candle" => "2011-08-18T00:00:00Z",
              "first_order_book" => "2017-01-06T00:00:00Z",
              "first_trade" => "2011-08-18T00:00:00Z",
              "high" => "67598.21719591",
              "high_timestamp" => "2021-11-08T00:00:00Z",
              "id" => "BTC",
              "logo_url" =>
                "https://s3.us-east-2.amazonaws.com/nomics-api/static/images/currencies/btc.svg",
              "market_cap" => "885768951973",
              "market_cap_dominance" => "0.3962",
              "max_supply" => "21000000",
              "name" => "Bitcoin",
              "num_exchanges" => "414",
              "num_pairs" => "86655",
              "num_pairs_unmapped" => "7658",
              "price" => "46615.27957876",
              "price_date" => "2022-04-03T00:00:00Z",
              "price_timestamp" => "2022-04-03T19:44:00Z",
              "rank" => "1",
              "rank_delta" => "1",
              "status" => "active",
              "symbol" => "BTC"
            },
            %{
              "1d" => %{
                "market_cap_change" => "2839749206.13",
                "market_cap_change_pct" => "0.0068",
                "price_change" => "23.22780687",
                "price_change_pct" => "0.0067",
                "volume" => "19374216286.33",
                "volume_change" => "-6557038778.81",
                "volume_change_pct" => "-0.2529"
              },
              "circulating_supply" => "120230565",
              "currency" => "ETH",
              "first_candle" => "2015-08-07T00:00:00Z",
              "first_order_book" => "2018-08-29T00:00:00Z",
              "first_trade" => "2015-08-07T00:00:00Z",
              "high" => "4810.66608581",
              "high_timestamp" => "2021-11-08T00:00:00Z",
              "id" => "ETH",
              "logo_url" =>
                "https://s3.us-east-2.amazonaws.com/nomics-api/static/images/currencies/eth.svg",
              "market_cap" => "421159006794",
              "market_cap_dominance" => "0.1884",
              "name" => "Ethereum",
              "num_exchanges" => "464",
              "num_pairs" => "83075",
              "num_pairs_unmapped" => "62955",
              "platform_currency" => "ETH",
              "price" => "3502.92794268",
              "price_date" => "2022-04-03T00:00:00Z",
              "price_timestamp" => "2022-04-03T19:44:00Z",
              "rank" => "2",
              "rank_delta" => "1",
              "status" => "active",
              "symbol" => "ETH"
            }
          ]
        }
      end)

      response =
        post(conn, "/graphql", %{
          "query" => @market_query,
          "variables" => %{fiat: "USD"}
        })

      expected = %{
        "data" => %{
          "market" => [
            %{"id" => "btc-bitcoin", "name" => "Bitcoin"},
            %{"id" => "eth-ethereum", "name" => "Ethereum"}
          ]
        }
      }

      assert expected == json_response(response, 200)
    end
  end
end
