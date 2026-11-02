defmodule TodoListWeb.TodoLive.Form do
  use TodoListWeb, :live_view

  alias TodoList.Todos
  alias TodoList.Todos.Todo

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash}>
      <div class="mx-auto w-full min-w-0 max-w-5xl space-y-4 px-2 py-3 sm:space-y-5 sm:px-4 sm:py-4 lg:px-6 lg:py-5">
        <%!-- Page Header --%>
        <header class="flex min-w-0 items-center gap-3 sm:gap-4">
          <.link
            navigate={~p"/todos"}
            aria-label="Back to tasks"
            class="flex size-10 shrink-0 items-center justify-center rounded-xl border border-slate-200 bg-white text-slate-600 shadow-sm transition hover:border-indigo-300 hover:bg-indigo-50 hover:text-indigo-700 dark:border-slate-700 dark:bg-slate-800 dark:text-slate-300 dark:hover:border-indigo-500 dark:hover:bg-slate-700 dark:hover:text-indigo-300 sm:size-11"
          >
            <.icon name="hero-arrow-left" class="size-5" />
          </.link>

          <div class="min-w-0">
            <h1 class="text-2xl font-bold tracking-tight text-slate-900 dark:text-slate-100 sm:text-3xl">
              {@page_title}
            </h1>

            <p class="mt-1 text-xs leading-5 text-slate-500 dark:text-slate-400 sm:text-sm">
              Create a task or update its details.
            </p>
          </div>
        </header>

        <%!-- Form Card --%>
        <section class="min-w-0 overflow-hidden rounded-2xl border border-slate-200 bg-white shadow-sm dark:border-slate-700 dark:bg-slate-900">
          <%!-- Card Header --%>
          <div class="border-b border-slate-200 bg-slate-50 px-4 py-4 dark:border-slate-700 dark:bg-slate-800 sm:px-6 sm:py-5">
            <div class="flex items-center gap-3">
              <span class="flex size-10 shrink-0 items-center justify-center rounded-xl bg-indigo-100 text-indigo-700 dark:bg-indigo-950 dark:text-indigo-300">
                <.icon name="hero-clipboard-document-list" class="size-5" />
              </span>

              <div class="min-w-0">
                <h2 class="text-base font-bold text-slate-900 dark:text-slate-100 sm:text-lg">
                  Task Information
                </h2>

                <p class="mt-1 text-xs text-slate-500 dark:text-slate-400 sm:text-sm">
                  Fill in the details below.
                </p>
              </div>
            </div>
          </div>

          <%!-- Form Fields --%>
          <.form
            for={@form}
            id="todo-form"
            phx-change="validate"
            phx-submit="save"
            class="min-w-0 space-y-5 p-4 sm:space-y-6 sm:p-6 lg:p-8"
          >
            <div class="min-w-0 space-y-2">
              <.input
                field={@form[:title]}
                type="text"
                label="Task Title"
                placeholder="e.g. Complete Phoenix assignment"
                required
              />

              <p class="text-xs leading-5 text-slate-500 dark:text-slate-400">
                Give your task a short, clear title.
              </p>
            </div>

            <div class="min-w-0 space-y-2">
              <.input
                field={@form[:description]}
                type="textarea"
                label="Description"
                placeholder="Write the details of your task here..."
                required
              />

              <p class="text-xs leading-5 text-slate-500 dark:text-slate-400">
                Add any details that will help you complete this task.
              </p>
            </div>

            <%!-- Priority and Completion --%>
            <div class="grid min-w-0 grid-cols-1 gap-5 sm:grid-cols-2 sm:gap-6">
              <div class="min-w-0 space-y-2">
                <.input
                  field={@form[:priority]}
                  type="select"
                  label="Priority"
                  options={[
                    {"Low", "low"},
                    {"Medium", "medium"},
                    {"High", "high"}
                  ]}
                />

                <div class="flex flex-wrap gap-2 pt-1">
                  <span class="rounded-md bg-teal-50 px-2 py-1 text-xs font-semibold text-teal-700 dark:bg-teal-950 dark:text-teal-300">
                    Low
                  </span>

                  <span class="rounded-md bg-amber-50 px-2 py-1 text-xs font-semibold text-amber-800 dark:bg-amber-950 dark:text-amber-300">
                    Medium
                  </span>

                  <span class="rounded-md bg-rose-50 px-2 py-1 text-xs font-semibold text-rose-700 dark:bg-rose-950 dark:text-rose-300">
                    High
                  </span>
                </div>
              </div>

              <div class="flex min-w-0 flex-col justify-center rounded-xl border border-emerald-200 bg-emerald-50/70 p-4 dark:border-emerald-900 dark:bg-emerald-950/40 sm:p-5">
                <.input
                  field={@form[:completed]}
                  type="checkbox"
                  label="Mark as completed"
                />

                <p class="mt-2 pl-6 text-xs leading-5 text-slate-600 dark:text-slate-300">
                  Enable this option if you have already finished the task.
                </p>
              </div>
            </div>

            <%!-- Action Buttons --%>
            <footer class="flex flex-col-reverse gap-3 border-t border-slate-200 pt-5 dark:border-slate-700 sm:flex-row sm:justify-end sm:pt-6">
              <.button
                navigate={return_path(@return_to, @todo)}
                class="inline-flex w-full justify-center rounded-lg border border-slate-300 bg-white px-5 py-2.5 text-sm font-semibold text-slate-700 transition hover:bg-slate-100 focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-indigo-600 dark:border-slate-600 dark:bg-slate-800 dark:text-slate-200 dark:hover:bg-slate-700 sm:w-auto"
              >
                Cancel
              </.button>

              <.button
                variant="primary"
                phx-disable-with="Saving..."
                class="inline-flex w-full justify-center rounded-lg bg-indigo-600 px-5 py-2.5 text-sm font-semibold text-white shadow-sm transition hover:bg-indigo-700 focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-indigo-500 sm:w-auto"
              >
                <.icon name="hero-check" class="mr-1.5 size-4" /> Save Todo
              </.button>
            </footer>
          </.form>
        </section>

        <p class="px-2 text-center text-xs leading-5 text-slate-500 dark:text-slate-400">
          Your task details will be saved when you select Save Todo.
        </p>
      </div>
    </Layouts.app>
    """
  end

  @impl true
  def mount(params, _session, socket) do
    {:ok,
     socket
     |> assign(:return_to, return_to(params["return_to"]))
     |> apply_action(socket.assigns.live_action, params)}
  end

  defp return_to("show"), do: "show"
  defp return_to(_), do: "index"

  defp apply_action(socket, :edit, %{"id" => id}) do
    todo = Todos.get_todo!(id)

    socket
    |> assign(:page_title, "Edit Todo")
    |> assign(:todo, todo)
    |> assign(:form, to_form(Todos.change_todo(todo)))
  end

  defp apply_action(socket, :new, _params) do
    todo = %Todo{}

    socket
    |> assign(:page_title, "New Todo")
    |> assign(:todo, todo)
    |> assign(:form, to_form(Todos.change_todo(todo)))
  end

  @impl true
  def handle_event("validate", %{"todo" => todo_params}, socket) do
    changeset = Todos.change_todo(socket.assigns.todo, todo_params)

    {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
  end

  def handle_event("save", %{"todo" => todo_params}, socket) do
    save_todo(socket, socket.assigns.live_action, todo_params)
  end

  defp save_todo(socket, :edit, todo_params) do
    case Todos.update_todo(socket.assigns.todo, todo_params) do
      {:ok, todo} ->
        {:noreply,
         socket
         |> put_flash(:info, "Todo updated successfully")
         |> push_navigate(to: return_path(socket.assigns.return_to, todo))}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp save_todo(socket, :new, todo_params) do
    case Todos.create_todo(todo_params) do
      {:ok, todo} ->
        {:noreply,
         socket
         |> put_flash(:info, "Todo created successfully")
         |> push_navigate(to: return_path(socket.assigns.return_to, todo))}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp return_path("index", _todo), do: ~p"/todos"
  defp return_path("show", todo), do: ~p"/todos/#{todo}"
end
