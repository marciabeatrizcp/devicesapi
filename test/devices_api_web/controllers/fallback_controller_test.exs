defmodule DevicesApiWeb.FallbackControllerTest do
  use DevicesAPIWeb.ConnCase, async: true

  alias DevicesApiWeb.FallbackControler

  test "renders error when name is invalid", %{conn: conn} do
    assigns =
      {:error,
       %Ecto.Changeset{
         errors: [
           name:
             {"should be at least 3 character(s)",
              [count: 6, validation: :length, kind: :min, type: :string]}
         ],
         valid?: false
       }}

    conn = Map.put(conn, :params, %{"_format" => "json"})
    conn = FallbackControler.call(conn, assigns)

    assert json_response(conn, :unprocessable_entity) == %{
             "error" => [
               %{
                 "error_message" => "should be at least 3 character(s)",
                 "field" => "name"
               }
             ]
           }
  end

  test "renders error when password is invalid", %{conn: conn} do
    assigns =
      {:error,
       {:invalid_params,
        %Ecto.Changeset{
          errors: [
            password:
              {"should be at least 6 character(s)",
               [count: 6, validation: :length, kind: :min, type: :string]}
          ],
          valid?: false
        }}}

    conn = Map.put(conn, :params, %{"_format" => "json"})
    conn = FallbackControler.call(conn, assigns)

    assert json_response(conn, :bad_request) == %{
             "error" => [
               %{
                 "error_message" => "should be at least 6 character(s)",
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
    assigns = {:error, :not_found}

    conn = Map.put(conn, :params, %{"_format" => "json"})
    conn = FallbackControler.call(conn, assigns)

    assert json_response(conn, :not_found) == %{"error" => "Not found"}
  end

  test "renders a not authorized error", %{conn: conn} do
    assigns = {:error, :unauthenticated}

    conn = Map.put(conn, :params, %{"_format" => "json"})
    conn = FallbackControler.call(conn, assigns)

    assert json_response(conn, :unauthorized) == %{"error" => "Unauthorized"}
  end
end
