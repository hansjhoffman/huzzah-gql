defmodule HuzzahWeb.AssetView do
  use HuzzahWeb, :view

  def render("index.json", %{ohlc: ohlc}) do
    %{data: ohlc}
  end
end
