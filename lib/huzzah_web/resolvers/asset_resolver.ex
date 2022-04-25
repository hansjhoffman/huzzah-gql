defmodule HuzzahWeb.Resolvers.AssetResolver do
  @moduledoc """
  Provides resolver functions for Asset queries.
  """

  alias Huzzah.NomicsClient

  def candles(_parent, %{id: id}, _resolution) do
    response = NomicsClient.candles(id)

    {:ok, response}
  end

  def get_asset(_parent, %{id: id}, _resolution) do
    response = NomicsClient.get_asset(id)

    {:ok, response}
  end
end
