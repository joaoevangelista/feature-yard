defmodule Featureyard.PageControllerTest do
  use Featureyard.ConnCase

  test "GET /", %{conn: conn} do
    conn = get conn, "/"
    assert html_response(conn, 200) =~ "Feature Yard"
  end
end
