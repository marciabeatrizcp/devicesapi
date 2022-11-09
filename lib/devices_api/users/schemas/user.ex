defmodule DevicesApi.Users.Schemas.User do
  @moduledoc """
  User table schema
  """
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @required_fields [:name, :email, :password]

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
  @spec changeset(params :: map()) :: Ecto.Changeset.t()
  def changeset(params) when is_map(params) do
    %__MODULE__{}
    |> cast(params, @required_fields)
    |> validate_required(@required_fields)
    |> validate_length(:name, min: 3)
    |> validate_length(:password, min: 6)
    |> validate_format(:email, @email_regex)
    |> unique_constraint(:email)
    |> put_pass_hash()
  end

  defp put_pass_hash(%Ecto.Changeset{valid?: true, changes: %{password: password}} = changeset) do
    change(changeset, Argon2.add_hash(password))
  end

  defp put_pass_hash(changeset), do: changeset
end
