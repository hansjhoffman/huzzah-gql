defmodule HuzzahWeb.HealthCheckController do
  @moduledoc """
  This module is specific only to deployment infra
  """

  use HuzzahWeb, :controller

  def index(conn, _params) do
    response = %{
      status: "pass",
      version: to_string(Application.spec(:huzzah, :vsn))
    }

    render(conn, "index.json", response: response)
  end
end
