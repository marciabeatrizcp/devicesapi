defmodule DevicesApi.Signin.Commands.UserSignin do
  @moduledoc """
  Executes `User` signin by email and password
  """

  alias DevicesApi.Signin.Steps.CheckPassword
  alias DevicesApi.Signin.Steps.IdentifyUser
  alias DevicesApi.Signin.Steps.TokenCreate
  alias DevicesApi.Users.Inputs.SignupRequestInput
  alias DevicesApi.Users.Schemas.User

  @spec execute(input :: SignupRequestInput.t()) ::
          {:error, :forbidden} | atom() | {:ok, struct()}
  def execute(input) do
    with {:ok, %User{} = user} <- IdentifyUser.execute(input.email),
         :ok <- CheckPassword.execute(input.password, user.password_hash) do
      TokenCreate.execute(user)
    else
      {:error, :not_found} -> {:error, :forbidden}
      :error -> {:error, :forbidden}
      _ -> :error
    end
  end
end
