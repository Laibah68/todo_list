defmodule TodoList.Repo.Migrations.AddPriorityToTodos do
  use Ecto.Migration

  def change do
    alter table(:todos) do
      add :priority, :string, default: "Medium", null: false
    end
  end
end
