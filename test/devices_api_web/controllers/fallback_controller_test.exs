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

    assert json_response(conn, 422) == %{
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

    assert json_response(conn, 400) == %{"error" => "bad_request"}
  end
end
