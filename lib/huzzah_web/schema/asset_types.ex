defmodule HuzzahWeb.Schema.AssetTypes do
  @moduledoc """
  Provides GraphQL types for a crypto asset.
  """

  use Absinthe.Schema.Notation

  @desc "A cryptocurrency digital asset"
  object(:asset) do
    @desc "Custom scaler id of the asset"
    field(:id, non_null(:asset_id))

    @desc "Display name"
    field(:name, non_null(:string))
  end
end
