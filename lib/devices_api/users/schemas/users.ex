defmodule DevicesApi.Users.Schemas.Users do
  @moduledoc """
  User table schema
  """
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @required_fields [:name, :email, :password_hash]

  @email_regex ~r/^[A-Za-z0-9\._%+\-+']+@[A-Za-z0-9\.\-]+\.[A-Za-z]{2,4}$/

  schema "users" do
    field :name, :string
    field :email, :string
    field :password_hash, :string

    # Virtuals
    field :password, :string, virtual: true

    timestamps()
  end

  @doc false
  def changeset(model \\ %__MODULE__{}, params) do
    model
    |> cast(params, @required_fields)
    |> validate_required(@required_fields)
    |> validate_length(:name, min: 3)
    |> validate_format(:email, @email_regex)
    |> unique_constraint(:email)
  end
end
