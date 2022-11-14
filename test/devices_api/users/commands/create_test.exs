defmodule DevicesApi.Users.Commands.CreateTest do
  use DevicesAPI.DataCase

  alias DevicesAPI.Repo
  alias DevicesApi.Users.Schemas.User
  alias DevicesApi.Users.Commands.Create

  describe "execute/1" do
    test "successfully creates an user when params are valid" do
      user_params = %{
        "name" => "Beatriz",
        "email" => "beatriz@mail.com",
        "password" => "123456"
      }

      count_before = Repo.aggregate(User, :count)

      {:ok, response} = Create.execute(user_params)

      count_after = Repo.aggregate(User, :count)

      assert %User{name: "Beatriz", email: "beatriz@mail.com"} = response

      assert count_after > count_before
    end

    test "fails to create an user when name is invalid" do
      user_params = %{
        "name" => "bi",
        "email" => "beatriz@mail.com",
        "password" => "123456"
      }

      {:error, response} = Create.execute(user_params)

      assert errors_on(response) == %{name: ["should be at least 3 character(s)"]}
    end

    test "fails to create an user when email is invalid" do
      user_params = %{
        "name" => "Marcia Beatriz",
        "email" => "beatriz@mail",
        "password" => "123456"
      }

      {:error, response} = Create.execute(user_params)

      assert errors_on(response) == %{email: ["has invalid format"]}
    end

    test "fails to create an user without required fields" do
      user_params = %{}

      {:error, response} = Create.execute(user_params)

      assert errors_on(response) == %{
               email: ["can't be blank"],
               name: ["can't be blank"],
               password: ["can't be blank"]
             }
    end

    test "fails to create an user when email has already been taken" do
      user_params = %{
        "name" => "Marcia Beatriz",
        "email" => "beatriz@mail.com",
        "password" => "123456"
      }

      Create.execute(user_params)

      user2_params = %{
        "name" => "Marcia Beatriz",
        "email" => "beatriz@mail.com",
        "password" => "123456"
      }

      {:error, response} = Create.execute(user2_params)

      assert errors_on(response) == %{email: ["has already been taken"]}
    end

    test "fails to create an user when password lenght is less than 6" do
      user_params = %{
        "name" => "Marcia Beatriz",
        "email" => "beatriz@mail.com",
        "password" => "1234"
      }

      {:error, response} = Create.execute(user_params)

      assert errors_on(response) == %{password: ["should be at least 6 character(s)"]}
    end
  end
end
