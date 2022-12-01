defmodule DevicesApi.Schema do
  @moduledoc """
  Defines DeviceAPI schema defaults.
  """
  defmacro __using__(_) do
    quote do
      use Ecto.Schema
      @primary_key {:id, :binary_id, autogenerate: true}
      @foreign_key_type :binary_id

      @type t() :: %__MODULE__{}
    end
  end
end
