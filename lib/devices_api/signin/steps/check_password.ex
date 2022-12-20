defmodule DevicesApi.Signin.Steps.CheckPassword do
  @moduledoc """
  Checks input password
  """

  @doc "Checks email and password input."
  @spec execute(password :: String.t(), stored_hash :: String.t()) ::
          :error | :ok
  def execute(password, stored_hash) do
    case Argon2.verify_pass(password, stored_hash) do
      true -> :ok
      false -> :error
    end
  end
end
