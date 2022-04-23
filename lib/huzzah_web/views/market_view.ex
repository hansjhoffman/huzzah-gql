defmodule HuzzahWeb.MarketView do
  use HuzzahWeb, :view

  def render("index.json", %{assets: assets}) do
    %{data: assets}
  end
end
