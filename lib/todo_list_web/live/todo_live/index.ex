defmodule TodoListWeb.TodoLive.Index do
  use TodoListWeb, :live_view

  alias TodoList.Todos

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash}>
      <main class="h-auto min-h-0 w-full min-w-0 lg:h-[calc(100dvh-6.5rem)]">
        <div class="mx-auto flex min-h-[36rem] w-full min-w-0 flex-col overflow-hidden rounded-xl border border-slate-200 bg-white shadow-sm dark:border-slate-800 dark:bg-slate-900 sm:rounded-2xl lg:h-full lg:min-h-0">
          <%!-- Header --%>
          <header class="flex shrink-0 items-center justify-between gap-2 border-b border-slate-200 bg-white px-3 py-3 dark:border-slate-800 dark:bg-slate-900 sm:gap-4 sm:px-5 sm:py-4 lg:px-6">
            <div class="flex min-w-0 items-center gap-2">
              <span class="flex size-9 shrink-0 items-center justify-center rounded-lg bg-indigo-100 text-indigo-700 dark:bg-indigo-950 dark:text-indigo-300 sm:size-10">
                <.icon name="hero-clipboard-document-list" class="size-5 sm:size-6" />
              </span>

              <div class="min-w-0">
                <h1 class="truncate text-lg font-bold tracking-tight text-slate-900 dark:text-slate-100 sm:text-2xl">
                  My Tasks
                </h1>
                <p class="hidden text-sm text-slate-500 dark:text-slate-400 sm:block">
                  Organize your work and track your progress.
                </p>
              </div>
            </div>

            <.link
              navigate={~p"/todos/new"}
              class="inline-flex shrink-0 items-center justify-center gap-1.5 rounded-lg bg-indigo-600 px-3 py-2.5 text-xs font-semibold text-white shadow-sm transition hover:bg-indigo-700 focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-indigo-500 sm:gap-2 sm:px-4 sm:text-sm"
            >
              <.icon name="hero-plus" class="size-4" />
              <span>New Task</span>
            </.link>
          </header>

          <%!-- Summary Cards --%>
          <section class="grid shrink-0 grid-cols-3 gap-2 border-b border-slate-200 bg-slate-50 p-3 dark:border-slate-800 dark:bg-slate-800/60 sm:gap-3 sm:px-5 sm:py-4 lg:px-6">
            <div class="min-w-0 rounded-lg border border-slate-200 bg-white p-2.5 dark:border-slate-700 dark:bg-slate-900 sm:rounded-xl sm:p-4">
              <div class="flex flex-col gap-1 sm:flex-row sm:items-center sm:gap-2">
                <span class="flex size-7 items-center justify-center rounded-md bg-indigo-50 text-indigo-600 dark:bg-indigo-950 dark:text-indigo-300 sm:size-8">
                  <.icon name="hero-clipboard-document-list" class="size-4 sm:size-5" />
                </span>
                <p class="text-[10px] font-semibold text-slate-500 dark:text-slate-400 sm:text-sm">
                  Total Tasks
                </p>
              </div>

              <p class="mt-2 text-xl font-bold text-slate-900 dark:text-slate-100 sm:mt-3 sm:text-3xl">
                {length(@todos)}
              </p>
            </div>

            <div class="min-w-0 rounded-lg border border-amber-200 bg-amber-50 p-2.5 dark:border-amber-900 dark:bg-amber-950/50 sm:rounded-xl sm:p-4">
              <div class="flex flex-col gap-1 sm:flex-row sm:items-center sm:gap-2">
                <span class="flex size-7 items-center justify-center rounded-md bg-amber-100 text-amber-700 dark:bg-amber-900 dark:text-amber-300 sm:size-8">
                  <.icon name="hero-clock" class="size-4 sm:size-5" />
                </span>
                <p class="text-[10px] font-semibold text-amber-800 dark:text-amber-300 sm:text-sm">
                  Pending
                </p>
              </div>

              <p class="mt-2 text-xl font-bold text-amber-900 dark:text-amber-200 sm:mt-3 sm:text-3xl">
                {length(@incomplete_todos)}
              </p>
            </div>

            <div class="min-w-0 rounded-lg border border-emerald-200 bg-emerald-50 p-2.5 dark:border-emerald-900 dark:bg-emerald-950/50 sm:rounded-xl sm:p-4">
              <div class="flex flex-col gap-1 sm:flex-row sm:items-center sm:gap-2">
                <span class="flex size-7 items-center justify-center rounded-md bg-emerald-100 text-emerald-700 dark:bg-emerald-900 dark:text-emerald-300 sm:size-8">
                  <.icon name="hero-check-circle" class="size-4 sm:size-5" />
                </span>
                <p class="text-[10px] font-semibold text-emerald-800 dark:text-emerald-300 sm:text-sm">
                  Completed
                </p>
              </div>

              <p class="mt-2 text-xl font-bold text-emerald-900 dark:text-emerald-200 sm:mt-3 sm:text-3xl">
                {length(@completed_todos)}
              </p>
            </div>
          </section>

          <%!-- Pending and Completed Sections --%>
          <div class="grid min-h-0 flex-1 grid-cols-1 grid-rows-2 gap-3 bg-slate-50 p-3 dark:bg-slate-950/60 sm:gap-4 sm:p-4 lg:grid-cols-2 lg:grid-rows-1 lg:gap-4 lg:p-4">
            <%!-- Pending Tasks --%>
            <section class="flex min-h-0 min-w-0 flex-col overflow-hidden rounded-xl border border-slate-200 bg-white shadow-sm dark:border-slate-700 dark:bg-slate-900">
              <header class="flex shrink-0 items-center justify-between gap-2 border-b border-slate-200 bg-white px-3 py-3 dark:border-slate-700 dark:bg-slate-900 sm:px-4 sm:py-4">
                <div class="flex min-w-0 items-center gap-2.5">
                  <span class="flex size-9 shrink-0 items-center justify-center rounded-lg bg-amber-100 text-amber-700 dark:bg-amber-900 dark:text-amber-300">
                    <.icon name="hero-clock" class="size-5" />
                  </span>

                  <div class="min-w-0">
                    <h2 class="text-sm font-bold text-slate-900 dark:text-slate-100 sm:text-base">
                      Pending Tasks
                    </h2>
                    <p class="mt-0.5 text-xs text-slate-500 dark:text-slate-400">
                      Tasks waiting to be finished
                    </p>
                  </div>
                </div>

                <span class="shrink-0 rounded-lg bg-amber-100 px-2.5 py-1 text-xs font-bold text-amber-900 dark:bg-amber-900 dark:text-amber-200">
                  {length(@incomplete_todos)}
                </span>
              </header>

              <div class="min-h-0 flex-1 overflow-y-auto overscroll-contain">
                <div
                  :for={todo <- @incomplete_todos}
                  id={"pending-todo-#{todo.id}"}
                  class="flex min-w-0 items-start gap-2 border-b border-slate-100 px-3 py-3 transition hover:bg-indigo-50/60 dark:border-slate-800 dark:hover:bg-slate-800/70 sm:items-center sm:gap-3 sm:px-4"
                >
                  <input
                    type="checkbox"
                    checked={false}
                    phx-click="toggle_completed"
                    phx-value-id={todo.id}
                    aria-label={"Complete #{todo.title}"}
                    class="mt-1 size-4 shrink-0 cursor-pointer rounded border-slate-300 text-indigo-600 focus:ring-indigo-500 dark:border-slate-600 dark:bg-slate-800 sm:mt-0"
                  />

                  <.link
                    navigate={~p"/todos/#{todo}"}
                    class="min-w-0 flex-1"
                  >
                    <span class="block break-words text-sm font-semibold text-slate-800 transition hover:text-indigo-600 dark:text-slate-200 dark:hover:text-indigo-300">
                      {todo.title}
                    </span>

                    <span
                      :if={todo.description not in [nil, ""]}
                      class="mt-1 line-clamp-2 break-words text-xs leading-5 text-slate-500 dark:text-slate-400"
                    >
                      {todo.description}
                    </span>

                    <span class="mt-1.5 inline-flex rounded-md px-2 py-0.5 text-[10px] font-semibold sm:hidden">
                      <span class={[
                        todo.priority == :high &&
                          "rounded-md bg-rose-50 px-2 py-0.5 text-rose-700 dark:bg-rose-950 dark:text-rose-300",
                        todo.priority == :medium &&
                          "rounded-md bg-amber-50 px-2 py-0.5 text-amber-800 dark:bg-amber-950 dark:text-amber-300",
                        todo.priority == :low &&
                          "rounded-md bg-teal-50 px-2 py-0.5 text-teal-700 dark:bg-teal-950 dark:text-teal-300"
                      ]}>
                        {todo.priority |> to_string() |> String.capitalize()} Priority
                      </span>
                    </span>
                  </.link>

                  <span class={[
                    "hidden shrink-0 rounded-md px-2 py-1 text-xs font-semibold sm:inline-flex",
                    todo.priority == :high &&
                      "bg-rose-50 text-rose-700 dark:bg-rose-950 dark:text-rose-300",
                    todo.priority == :medium &&
                      "bg-amber-50 text-amber-800 dark:bg-amber-950 dark:text-amber-300",
                    todo.priority == :low &&
                      "bg-teal-50 text-teal-700 dark:bg-teal-950 dark:text-teal-300"
                  ]}>
                    {todo.priority |> to_string() |> String.capitalize()}
                  </span>

                  <div class="flex shrink-0 flex-col items-end gap-1 sm:flex-row sm:items-center">
                    <.link
                      navigate={~p"/todos/#{todo}/edit"}
                      aria-label={"Edit #{todo.title}"}
                      class="inline-flex items-center gap-1 rounded-md px-2 py-1.5 text-xs font-semibold text-indigo-600 transition hover:bg-indigo-50 dark:text-indigo-300 dark:hover:bg-indigo-950 sm:px-2.5"
                    >
                      <.icon name="hero-pencil-square" class="size-3.5" /> Edit
                    </.link>

                    <button
                      type="button"
                      phx-click="delete"
                      phx-value-id={todo.id}
                      data-confirm="Are you sure you want to delete this task?"
                      aria-label={"Delete #{todo.title}"}
                      class="inline-flex items-center gap-1 rounded-md px-2 py-1.5 text-xs font-semibold text-rose-600 transition hover:bg-rose-50 dark:text-rose-300 dark:hover:bg-rose-950 sm:px-2.5"
                    >
                      <.icon name="hero-trash" class="size-3.5" /> Delete
                    </button>
                  </div>
                </div>

                <div
                  :if={@incomplete_todos == []}
                  class="flex min-h-40 flex-col items-center justify-center px-4 py-8 text-center"
                >
                  <span class="flex size-12 items-center justify-center rounded-full bg-emerald-100 text-emerald-700 dark:bg-emerald-950 dark:text-emerald-300">
                    <.icon name="hero-check-circle" class="size-7" />
                  </span>
                  <p class="mt-3 text-sm font-semibold text-slate-800 dark:text-slate-100">
                    All caught up!
                  </p>
                  <p class="mt-1 text-xs text-slate-500 dark:text-slate-400">
                    You have no pending tasks.
                  </p>
                </div>
              </div>
            </section>

            <%!-- Completed Tasks --%>
            <section class="flex min-h-0 min-w-0 flex-col overflow-hidden rounded-xl border border-slate-200 bg-white shadow-sm dark:border-slate-700 dark:bg-slate-900">
              <header class="flex shrink-0 items-center justify-between gap-2 border-b border-slate-200 bg-white px-3 py-3 dark:border-slate-700 dark:bg-slate-900 sm:px-4 sm:py-4">
                <div class="flex min-w-0 items-center gap-2.5">
                  <span class="flex size-9 shrink-0 items-center justify-center rounded-lg bg-emerald-100 text-emerald-700 dark:bg-emerald-900 dark:text-emerald-300">
                    <.icon name="hero-check-circle" class="size-5" />
                  </span>

                  <div class="min-w-0">
                    <h2 class="text-sm font-bold text-slate-900 dark:text-slate-100 sm:text-base">
                      Completed Tasks
                    </h2>
                    <p class="mt-0.5 text-xs text-slate-500 dark:text-slate-400">
                      Tasks you have finished
                    </p>
                  </div>
                </div>

                <span class="shrink-0 rounded-lg bg-emerald-100 px-2.5 py-1 text-xs font-bold text-emerald-900 dark:bg-emerald-900 dark:text-emerald-200">
                  {length(@completed_todos)}
                </span>
              </header>

              <div class="min-h-0 flex-1 overflow-y-auto overscroll-contain">
                <div
                  :for={todo <- @completed_todos}
                  id={"completed-todo-#{todo.id}"}
                  class="flex min-w-0 items-start gap-2 border-b border-slate-100 bg-emerald-50/40 px-3 py-3 transition hover:bg-emerald-50 dark:border-slate-800 dark:bg-emerald-950/20 dark:hover:bg-emerald-950/50 sm:items-center sm:gap-3 sm:px-4"
                >
                  <input
                    type="checkbox"
                    checked={true}
                    phx-click="toggle_completed"
                    phx-value-id={todo.id}
                    aria-label={"Mark #{todo.title} as pending"}
                    class="mt-1 size-4 shrink-0 cursor-pointer rounded border-slate-300 text-emerald-600 focus:ring-emerald-500 dark:border-slate-600 dark:bg-slate-800 sm:mt-0"
                  />

                  <.link
                    navigate={~p"/todos/#{todo}"}
                    class="min-w-0 flex-1"
                  >
                    <span class="block break-words text-sm font-semibold text-slate-500 line-through transition hover:text-slate-700 dark:text-slate-400 dark:hover:text-slate-200">
                      {todo.title}
                    </span>

                    <span
                      :if={todo.description not in [nil, ""]}
                      class="mt-1 line-clamp-2 break-words text-xs leading-5 text-slate-400 dark:text-slate-500"
                    >
                      {todo.description}
                    </span>

                    <span class="mt-1.5 inline-flex rounded-md bg-emerald-100 px-2 py-0.5 text-[10px] font-semibold text-emerald-800 dark:bg-emerald-950 dark:text-emerald-300 sm:hidden">
                      Completed
                    </span>
                  </.link>

                  <span class="hidden shrink-0 rounded-md bg-emerald-100 px-2 py-1 text-xs font-semibold text-emerald-800 dark:bg-emerald-950 dark:text-emerald-300 sm:inline-flex">
                    Done
                  </span>

                  <div class="flex shrink-0 flex-col items-end gap-1 sm:flex-row sm:items-center">
                    <.link
                      navigate={~p"/todos/#{todo}/edit"}
                      aria-label={"Edit #{todo.title}"}
                      class="inline-flex items-center gap-1 rounded-md px-2 py-1.5 text-xs font-semibold text-indigo-600 transition hover:bg-indigo-50 dark:text-indigo-300 dark:hover:bg-indigo-950 sm:px-2.5"
                    >
                      <.icon name="hero-pencil-square" class="size-3.5" /> Edit
                    </.link>

                    <button
                      type="button"
                      phx-click="delete"
                      phx-value-id={todo.id}
                      data-confirm="Are you sure you want to delete this task?"
                      aria-label={"Delete #{todo.title}"}
                      class="inline-flex items-center gap-1 rounded-md px-2 py-1.5 text-xs font-semibold text-rose-600 transition hover:bg-rose-50 dark:text-rose-300 dark:hover:bg-rose-950 sm:px-2.5"
                    >
                      <.icon name="hero-trash" class="size-3.5" /> Delete
                    </button>
                  </div>
                </div>

                <div
                  :if={@completed_todos == []}
                  class="flex min-h-40 flex-col items-center justify-center px-4 py-8 text-center"
                >
                  <span class="flex size-12 items-center justify-center rounded-full bg-indigo-50 text-indigo-600 dark:bg-indigo-950 dark:text-indigo-300">
                    <.icon name="hero-clipboard-document-list" class="size-7" />
                  </span>
                  <p class="mt-3 text-sm font-semibold text-slate-800 dark:text-slate-100">
                    Nothing completed yet
                  </p>
                  <p class="mt-1 text-xs text-slate-500 dark:text-slate-400">
                    Completed tasks will appear here.
                  </p>
                </div>
              </div>
            </section>
          </div>
        </div>
      </main>
    </Layouts.app>
    """
  end

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:page_title, "My Tasks")
     |> assign_todos()}
  end

  @impl true
  def handle_event("toggle_completed", %{"id" => id}, socket) do
    todo = Todos.get_todo!(id)

    case Todos.update_todo(todo, %{completed: not todo.completed}) do
      {:ok, _updated_todo} ->
        {:noreply, assign_todos(socket)}

      {:error, _changeset} ->
        {:noreply, put_flash(socket, :error, "Task update nahi ho saka. Dobara try karo.")}
    end
  end

  def handle_event("delete", %{"id" => id}, socket) do
    todo = Todos.get_todo!(id)

    case Todos.delete_todo(todo) do
      {:ok, _deleted_todo} ->
        {:noreply, assign_todos(socket)}

      {:error, _changeset} ->
        {:noreply, put_flash(socket, :error, "Task delete nahi ho saka.")}
    end
  end

  defp assign_todos(socket) do
    incomplete_todos = Todos.list_incomplete_todos()
    completed_todos = Todos.list_completed_todos()

    todos = incomplete_todos ++ completed_todos

    socket
    |> assign(:todos, todos)
    |> assign(:incomplete_todos, incomplete_todos)
    |> assign(:completed_todos, completed_todos)
  end
end
