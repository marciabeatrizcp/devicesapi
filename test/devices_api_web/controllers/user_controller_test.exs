defmodule DevicesApiWeb.UserControllerTest do
  use DevicesAPIWeb.ConnCase

  describe "POST /users/signup" do
    test "successfully create account when input is valid", %{conn: conn} do
      user_params = %{
        name: "Beatriz Domingues",
        email: "beatriz@gmail.com",
        password: "123456"
      }

      assert %{
               "email" => "beatriz@gmail.com",
               "name" => "Beatriz Domingues"
             } =
               conn
               |> post("/users/signup", user_params)
               |> json_response(201)
    end

    test "fails on creating user when name is invalid", %{conn: conn} do
      user_params = %{
        name: "Be",
        email: "beatriz@gmail.com",
        password: "123456"
      }

      assert %{
               "error" => [
                 %{
                   "error_message" => "should be at least %{count} character(s)",
                   "field" => "name"
                 }
               ]
             } =
               conn
               |> post("/users/signup", user_params)
               |> json_response(422)
    end

    test "fails on creating user when email is invalid", %{conn: conn} do
      user_params = %{
        name: "Beatriz Domingues",
        email: "beatriz@gmail",
        password: "123456"
      }

      assert %{
               "error" => [
                 %{
                   "error_message" => "has invalid format",
                   "field" => "email"
                 }
               ]
             } =
               conn
               |> post("/users/signup", user_params)
               |> json_response(422)
    end

    test "fails on creating user when password lenght is less than six", %{conn: conn} do
      user_params = %{
        name: "Beatriz Domingues",
        email: "beatriz@gmail.com",
        password: "123"
      }

      assert %{
               "error" => [
                 %{
                   "error_message" => "should be at least %{count} character(s)",
                   "field" => "password"
                 }
               ]
             } =
               conn
               |> post("/users/signup", user_params)
               |> json_response(422)
    end

    test "fails on creating user when params are invalid", %{conn: conn} do
      user_params = %{}

      assert %{
               "error" => [
                 %{"error_message" => "can't be blank", "field" => "name"},
                 %{"error_message" => "can't be blank", "field" => "email"},
                 %{"error_message" => "can't be blank", "field" => "password"}
               ]
             } =
               conn
               |> post("/users/signup", user_params)
               |> json_response(422)
    end
  end
end
