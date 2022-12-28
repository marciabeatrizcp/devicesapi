defmodule DevicesApi.Signin do
  @moduledoc """
  Sign in domain.

  Sign in is the process of exchanging credentials for a session. Current approach is to have JWT compact tokens in their JWS variant.

  A token contains information like subject, issuer, etc. See `https://jwt.io/introduction` for more information.

  Sign ins generate audit records. Many consecutive failed attempts will lock the user.
  """
  alias DevicesApi.Signin.Commands.UserSignin
  alias DevicesApi.Signin.Inputs.SigninRequestInput

  @doc """
  Executes `User` signin by email and password

  ## Examples

    iex> {:ok, token} = execute(%SigninRequestInput{email: valid_email, password: valid_passord})

    iex> {:error, :unauthenticated} = execute(%SigninRequestInput{email: valid_email, password: invalid_passord})

    iex> {:error, :unauthenticated} = execute(%SigninRequestInput{email: invalid_email, password: invalid_passord})


  """
  @spec execute(SigninRequestInput.t()) ::
          {:ok, String.t()} | {:error, :not_found | :unauthenticated}
  defdelegate execute(input), to: UserSignin, as: :execute
end
