defmodule DevicesApi.Signin.Commands.CheckPassword do
  @moduledoc """
  Compares input password with stored hash password
  """

  @doc "Checks password input."
  @spec execute(password :: String.t(), stored_hash :: String.t()) ::
          :error | :ok
  def execute(password, stored_hash) do
    case Argon2.verify_pass(password, stored_hash) do
      true -> :ok
      false -> {:error, :unauthenticated}
    end
  end
end
