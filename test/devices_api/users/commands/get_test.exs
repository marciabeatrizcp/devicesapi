defmodule DevicesApi.Users.Commands.GetTest do
  use DevicesAPI.DataCase

  alias DevicesApi.Users
  alias DevicesApi.Users.Commands.Get
  alias DevicesApi.Users.Schemas.User

  describe "execute/1" do
    test "successfully gets a user given a valid UUID" do
      new_user = user_insert()

      {:ok, response} = Get.execute(new_user.id)

      assert %User{name: "Beatriz Domingues", email: "beatriz@gmail.com"} = response
    end

    test "fails when given an invalid UUID" do
      id = "1234"

      {:error, response} = Get.execute(id)

      assert "Invalid ID format!" = response
    end

    test "returns not found when user doesn't exist" do
      id = "45dc768d-9e35-4d06-a7c0-64377cf71906"

      {:error, :not_found, response} = Get.execute(id)

      assert "User not found!" = response
    end
  end

  defp user_insert do
    user_params = %{
      name: "Beatriz Domingues",
      email: "beatriz@gmail.com",
      password: "123456"
    }

    {:ok, user} = Users.create(user_params)

    user
  end
end
