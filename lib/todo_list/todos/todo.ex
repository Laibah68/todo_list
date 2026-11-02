defmodule TodoList.Todos.Todo do
  use Ecto.Schema
  import Ecto.Changeset

  schema "todos" do
    field :title, :string
    field :description, :string
    field :completed, :boolean, default: false
    field :priority, Ecto.Enum, values: [:low, :medium, :high], default: :medium

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(todo, attrs) do
    todo
    |> cast(attrs, [:title, :description, :completed, :priority])
    |> validate_required([:title, :description, :completed, :priority])
  end

  # defp normalize_priority(attrs) do
  #   case Map.get(attrs, "priority") || Map.get(attrs, :priority) do
  #     value when value in ["Low", "Medium", "High"] ->
  #       key = if Map.has_key?(attrs, :priority), do: :priority, else: "priority"
  #       Map.put(attrs, key, String.downcase(value))

  #     _ ->
  #       attrs
  #     end
  # end
end
