defmodule DevicesApi.Users.Inputs.SigninRequestInput do
  @moduledoc """
  Create sigin input type.
  """
  use DevicesApi.ValueObject

  @required [:email, :password]

  embedded_schema do
    field :email, :string
    field :password, :string
  end

  @doc false
  @spec changeset(params :: map()) :: Ecto.Changeset.t()
  def changeset(model \\ %__MODULE__{}, params) do
    model
    |> cast(params, @required)
    |> validate_required(@required)
  end
end
