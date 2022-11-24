defmodule DevicesApi.ValueObjectSchema do
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
end
