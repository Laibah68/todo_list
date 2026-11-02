defmodule TodoList.Repo.Migrations.ConvertPriorityToLowercase do
  use Ecto.Migration

  def up do
    execute("""
    UPDATE todos
    SET priority = LOWER(priority)
    WHERE priority IS NOT NULL
    """)

    execute("""
    ALTER TABLE todos
    ALTER COLUMN priority SET DEFAULT 'medium'
    """)
  end

  def down do
    execute("""
    UPDATE todos
    SET priority = INITCAP(priority)
    WHERE priority IS NOT NULL
    """)

    execute("""
    ALTER TABLE todos
    ALTER COLUMN priority SET DEFAULT 'Medium'
    """)
  end
end
