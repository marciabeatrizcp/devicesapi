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
          {:error, {:forbidden, String.t()}} | atom() | {:ok, struct()}
  def execute(input) do
    with {:ok, %User{} = user} <- IdentifyUser.execute(input.email),
         :ok <- CheckPassword.execute(input.password, user.password_hash) do
      TokenCreate.execute(user)
    else
      {:error, :not_found} -> {:error, {:forbidden, "Invalid Credentials!"}}
      :error -> {:error, {:forbidden, "Invalid Credentials!"}}
      _ -> :error
    end
  end
end
