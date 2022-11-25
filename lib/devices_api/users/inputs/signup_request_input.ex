defmodule DevicesApi.Users.Inputs.SignupRequestInput do
  @moduledoc """
  Create input type.
  """
  use DevicesApi.ValueObjectSchema

  import DevicesApi.ChangesetValidation, only: [validate_email: 2]

  @required [:name, :email, :password]

  embedded_schema do
    field :name, :string
    field :email, :string

    # Virtuals
    field :password, :string, virtual: true, redact: true
  end

  @doc false
  @spec changeset(params :: map()) :: Ecto.Changeset.t()
  def changeset(model \\ %__MODULE__{}, params) do
    model
    |> cast(params, @required)
    |> validate_required(@required)
    |> validate_length(:name, min: 3)
    |> validate_length(:password, min: 6)
    |> validate_email(:email)
  end
end
