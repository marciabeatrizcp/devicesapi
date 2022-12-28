defmodule DevicesApi.Signin.Commands.UserSignin do
  @moduledoc """
  Executes User signin by email and password
  """

  alias DevicesApi.Signin.Commands.CheckPassword
  alias DevicesApi.Signin.Commands.IdentifyUser
  alias DevicesApi.Signin.Commands.TokenCreate
  alias DevicesApi.Signin.Inputs.SigninRequestInput
  alias DevicesApi.Users.Schemas.User

  @doc false
  @spec execute(input :: SigninRequestInput.t()) ::
          {:error, {:forbidden, String.t()}} | {:ok, String.t()}
  def execute(%SigninRequestInput{} = input) do
    with {:ok, %User{} = user} <- IdentifyUser.execute(input.email),
         :ok <- CheckPassword.execute(input.password, user.password_hash) do
      TokenCreate.execute(user)
    else
      {:error, _} -> {:error, {:forbidden, "Invalid Credentials!"}}
    end
  end
end
