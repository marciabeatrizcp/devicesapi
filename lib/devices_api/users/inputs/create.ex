defmodule DevicesApi.Users.Inputs.Create do
  @moduledoc """
  Create input type.
  """

  use DevicesApi.ValueObjectSchema

  @required [:name, :email, :password]

  embedded_schema do
    field :name, :string
    field :email, :string

    # Virtuals
    field :password, :string, virtual: true, redact: true
  end

  @doc false
  @spec changeset(params :: map()) :: Ecto.Changeset.t()
  def changeset(params) do
    %__MODULE__{}
    |> cast(params, @required)
    |> validate_required(@required)
  end
end
