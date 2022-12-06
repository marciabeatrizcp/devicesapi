defmodule DevicesApi.Users.Schemas.User do
  @moduledoc """
  User table schema
  """
  use DevicesApi.Schema
  import Ecto.Changeset

  @required_fields [:name, :email, :password]

  schema "users" do
    field :name, :string
    field :email, :string
    field :password_hash, :string, redact: true

    # Virtuals
    field :password, :string, virtual: true, redact: true

    timestamps()
  end

  @doc false
  @spec changeset(params :: map()) :: Ecto.Changeset.t()
  def changeset(params) when is_map(params) do
    %__MODULE__{}
    |> cast(params, @required_fields)
    |> validate_required(@required_fields)
    |> unique_constraint(:email)
    |> put_pass_hash()
  end

  defp put_pass_hash(%Ecto.Changeset{valid?: true, changes: %{password: password}} = changeset) do
    change(changeset, Argon2.add_hash(password))
  end

  defp put_pass_hash(changeset), do: changeset
end
