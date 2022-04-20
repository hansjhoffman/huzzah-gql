defmodule HuzzahWeb.AssetsController do
  use HuzzahWeb, :controller

  alias Huzzah.NomicsClient

  def index(conn, _params) do
    {:ok, %Tesla.Env{:body => response}} = NomicsClient.market_cap()

    conn
    |> render("index.json", assets: response)
  end
end
