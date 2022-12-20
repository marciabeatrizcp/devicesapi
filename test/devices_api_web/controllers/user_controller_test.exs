defmodule DevicesApiWeb.UserControllerTest do
  use DevicesAPIWeb.ConnCase

  alias DevicesApi.Signin
  alias DevicesApi.Users
  alias DevicesApi.Users.Inputs.SignupRequestInput
  alias DevicesApiWeb.Auth.JwtToken

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
               |> json_response(:created)
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
               |> json_response(:bad_request)
    end

    test "fails on creating user when email is invalid", %{conn: conn} do
      user_params = %{
        name: "Beatriz Domingues",
        email: "beatrizgmail",
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
               |> json_response(:bad_request)
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
               |> json_response(:bad_request)
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
               |> json_response(:bad_request)
    end
  end

  describe "GET /users/signup:id" do
    setup %{conn: conn} do
      new_user = user_insert()

      token = user_sign_in("beatriz@gmail.com", "123456")

      conn = put_req_header(conn, "authorization", "Bearer #{token}")
      {:ok, conn: conn, user: new_user, token: token}
    end

    test "successfully gets a user given a valid UUID", %{conn: conn, user: user} do
      assert %{
               "email" => "beatriz@gmail.com",
               "name" => "Beatriz Domingues"
             } =
               conn
               |> get("/users/#{user.id}")
               |> json_response(:ok)
    end

    test "fails when given an invalid UUID", %{conn: conn} do
      id = "1234"

      assert %{"error" => "Invalid ID format!"} =
               conn
               |> get("/users/#{id}")
               |> json_response(:bad_request)
    end

    test "returns not found when user doesn't exist ", %{conn: conn} do
      id = "45dc768d-9e35-4d06-a7c0-64377cf71906"

      assert %{"error" => "User not found!"} =
               conn
               |> get("/users/#{id}")
               |> json_response(:not_found)
    end

    test "fails when no authorization token found", %{conn: conn, user: user} do
      conn = delete_req_header(conn, "authorization")

      assert %{"error" => "No authorization token found!"} =
               conn
               |> get("/users/#{user.id}")
               |> json_response(:unauthorized)
    end

    test "fails when token signed fails", %{conn: conn, user: user, token: token} do
      conn = put_req_header(conn, "authorization", "Bearer #{token <> "invalid"}")

      assert %{"error" => "Token signature verification failed!"} =
               conn
               |> get("/users/#{user.id}")
               |> json_response(:unauthorized)
    end

    test "fails when token is expired", %{conn: conn, user: user} do
      token = generate_token()
      conn = put_req_header(conn, "authorization", "Bearer #{token}")

      assert %{"error" => "Token is expired!"} =
               conn
               |> get("/users/#{user.id}")
               |> json_response(:unauthorized)
    end
  end

  describe "POST /users/signin" do
    test "successfully user signin when input is valid", %{conn: conn} do
      user_insert()

      request = %{
        email: "beatriz@gmail.com",
        password: "123456"
      }

      assert %{"token" => _} =
               conn
               |> post("/users/signin", request)
               |> json_response(:ok)
    end

    test "fail user signin when password is wrong", %{conn: conn} do
      user_insert()

      request = %{
        email: "beatriz@gmail.com",
        password: "123455"
      }

      assert %{"error" => "Invalid Credentials!"} =
               conn
               |> post("/users/signin", request)
               |> json_response(:forbidden)
    end

    test "fail user signin when email was not found", %{conn: conn} do
      user_insert()

      request = %{
        email: "beatriz1@gmail.com",
        password: "123456"
      }

      assert %{"error" => "Invalid Credentials!"} =
               conn
               |> post("/users/signin", request)
               |> json_response(:forbidden)
    end
  end

  defp user_insert do
    user_params = %SignupRequestInput{
      name: "Beatriz Domingues",
      email: "beatriz@gmail.com",
      password: "123456"
    }

    {:ok, user} = Users.create(user_params)

    user
  end

  defp user_sign_in(email, password) do
    {:ok, token} = Signin.execute(%{email: email, password: password})
    token
  end

  defp generate_token() do
    {:ok, token} = JwtToken.create("aaaf1f3f-4576-42f2-b3f1-55ca8241e0aa", "beatriz@gmail.com", -10)
    token
  end
end
