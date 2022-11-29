defmodule DevicesApi.ValueObject do
  @moduledoc """
  Models a value object.

  A value object is one that has no identity. It is mostly used as an embedded object.
  """
  defmacro __using__(_) do
    quote do
      use Ecto.Schema

      import Ecto.Changeset

      @primary_key false
      @type t() :: %__MODULE__{}
    end
  end

  @doc "Converts a struct to a map"
  @spec convert_map_from_struct(struct()) :: {map()}
  def convert_map_from_struct(params), do: Map.from_struct(params)
end
