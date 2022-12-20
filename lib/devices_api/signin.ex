defmodule DevicesApi.Signin do
  @moduledoc """
  Delegate functions to handle Signin context
  """
  alias DevicesApi.Signin.Commands.UserSignin
  alias DevicesApi.Users.Inputs.SignupRequestInput

  @doc """
  Executes `User` signin by email and password

  ## Examples

    iex> {:ok, token} = execute(%{email: valid_email, password: valid_passord})

    iex> {:error, :forbidden} = execute(%{email: valid_email, password: invalid_passord})

    iex> {:error, :forbidden} = execute(%{email: invalid_email, password: invalid_passord})


  """
  @spec execute(SignupRequestInput.t()) :: {:error, :forbidden}
  defdelegate execute(input), to: UserSignin, as: :execute
end
