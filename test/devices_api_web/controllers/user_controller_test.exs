defmodule DevicesApiWeb.UserControllerTest do
  use DevicesAPIWeb.ConnCase

  describe "POST /users/signup" do
    setup %{conn: conn} do
      {:ok, conn: conn}
    end

    test "successfully create account when input is valid", setup do
      user_params = %{
        name: "Beatriz Domingues",
        email: "beatriz@gmail.com",
        password: "123456"
      }

      assert %{
               "email" => "Beatriz Domingues",
               "name" => "Beatriz Domingues"
             } =
               setup.conn
               |> post("/users/signup", user_params)
               |> json_response(201)
    end

    test "fails on creating user when name is invalid", setup do
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
               setup.conn
               |> post("/users/signup", user_params)
               |> json_response(422)
    end

    test "fails on creating user when email is invalid", setup do
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
               setup.conn
               |> post("/users/signup", user_params)
               |> json_response(422)
    end

    test "fails on creating user when password lenght is less than six", setup do
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
               setup.conn
               |> post("/users/signup", user_params)
               |> json_response(422)
    end

    test "fails on creating user when params are invalid", setup do
      user_params = %{}

      assert %{
               "error" => [
                 %{"error_message" => "can't be blank", "field" => "name"},
                 %{"error_message" => "can't be blank", "field" => "email"},
                 %{"error_message" => "can't be blank", "field" => "password"}
               ]
             } =
               setup.conn
               |> post("/users/signup", user_params)
               |> json_response(422)
    end
  end
end
