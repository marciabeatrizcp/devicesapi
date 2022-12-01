defmodule DevicesApi.Changesets do
  @moduledoc """
  Helper functions to work with changeset validations.
  """

  alias Ecto.Changeset

  # Validation email regex
  @email_regex ~r<\A[a-zA-Z0-9!#$%&'*+/=?^_`{|}~.-]+[^\.]@[a-zA-Z0-9-]+(\.[a-zA-Z0-9-]+)*\z>

  @doc "Validate an email field"
  @spec validate_email(changeset :: Changeset.t(), field :: atom()) :: Changeset.t()
  def validate_email(%Changeset{} = changeset, field) when is_atom(field) do
    Changeset.validate_change(changeset, field, fn ^field, value ->
      case {:proper, String.match?(value, @email_regex)} do
        {:proper, true} -> []
        {:proper, false} -> [{field, {"has invalid format", exchema_error: :invalid_email}}]
      end
    end)
  end

  @doc "Cast and apply changeset"
  @spec cast_and_aply(schema :: atom(), params :: map() | struct()) ::
          {:ok, struct()} | {:error, :invalid_params, struct()}
  def cast_and_aply(schema, params) when is_atom(schema) and is_map(params) do
    %{}
    |> schema.__struct__()
    |> schema.changeset(params)
    |> case do
      %{valid?: true} = changeset ->
        {:ok, Changeset.apply_changes(changeset)}

      changeset ->
        {:error, :invalid_params, changeset}
    end
  end
end
