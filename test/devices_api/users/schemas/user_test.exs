defmodule DevicesApi.Users.Schemas.UserTest do
  use DevicesAPI.DataCase

  alias DevicesApi.Users.Schemas.User

  describe "changeset/2" do
    test "when all params are valid, returns a valid changeset" do
      user_params = %{
        "name" => "Beatriz",
        "email" => "beatriz@mail.com",
        "password" => "123456"
      }

      response = User.changeset(user_params)

      assert %Ecto.Changeset{
               changes: %{
                 name: "Beatriz",
                 email: "beatriz@mail.com",
                 password: "123456"
               },
               errors: [],
               data: %User{},
               valid?: true
             } = response
    end

    test "when there are invalid params, returns an invalid changeset" do
      params = %{password: "123456"}

      response = User.changeset(params)

      assert %Ecto.Changeset{
               changes: %{
                 password: "123456"
               },
               data: %User{},
               valid?: false
             } = response

      assert errors_on(response) == %{name: ["can't be blank"], email: ["can't be blank"]}
    end
  end
end
