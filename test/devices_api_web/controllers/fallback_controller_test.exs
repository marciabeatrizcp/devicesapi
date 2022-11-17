defmodule DevicesApiWeb.FallbackControllerTest do
  use DevicesAPIWeb.ConnCase, async: true

  alias DevicesApiWeb.FallbackControler

  test "renders error when password is invalid", %{conn: conn} do
    assigns =
      {:error,
       %Ecto.Changeset{
         errors: [
           password:
             {"should be at least %{count} character(s)",
              [count: 6, validation: :length, kind: :min, type: :string]}
         ],
         valid?: false
       }}

    conn = Map.put(conn, :params, %{"_format" => "json"})
    conn = FallbackControler.call(conn, assigns)

    assert json_response(conn, :unprocessable_entity) == %{
             "error" => [
               %{
                 "error_message" => "should be at least %{count} character(s)",
                 "field" => "password"
               }
             ]
           }
  end

  test "renders an unexpected error", %{conn: conn} do
    assigns = {:error, :bad_request}

    conn = Map.put(conn, :params, %{"_format" => "json"})
    conn = FallbackControler.call(conn, assigns)

    assert json_response(conn, :bad_request) == %{"error" => "bad_request"}
  end

  test "renders a not found error", %{conn: conn} do
    assigns = {:error, :not_found, "not_found"}

    conn = Map.put(conn, :params, %{"_format" => "json"})
    conn = FallbackControler.call(conn, assigns)

    assert json_response(conn, :not_found) == %{"error" => "not_found"}
  end
end
