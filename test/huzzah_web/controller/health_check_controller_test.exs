defmodule HuzzahWeb.HealthCheckControllerTest do
  use HuzzahWeb.ConnCase, async: true

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "positive heartbeat", %{conn: conn} do
    response = get(conn, Routes.health_check_path(conn, :index))

    expected = %{
      "status" => "pass",
      "version" => Application.spec(:huzzah, :vsn) |> to_string()
    }

    assert expected == json_response(response, 200)
  end
end
