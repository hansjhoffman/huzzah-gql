defmodule HuzzahWeb.HealthCheckView do
  use HuzzahWeb, :view

  def render("index.json", %{response: response}) do
    %{status: response.status, version: response.version}
  end
end
