defmodule TodoListWeb.TodoLive.Show do
  use TodoListWeb, :live_view

  alias TodoList.Todos

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash}>
      <div class="mx-auto w-full min-w-0 max-w-6xl space-y-4 px-2 py-3 sm:space-y-5 sm:px-4 sm:py-4 lg:px-6 lg:py-5">
        <%!-- Page Header --%>
        <header class="flex flex-wrap items-center justify-between gap-3 sm:gap-4">
          <div class="flex min-w-0 items-center gap-3 sm:gap-4">
            <.link
              navigate={~p"/todos"}
              aria-label="Back to tasks"
              class="flex size-10 shrink-0 items-center justify-center rounded-xl border border-slate-200 bg-white text-slate-600 shadow-sm transition hover:border-indigo-300 hover:bg-indigo-50 hover:text-indigo-700 focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-indigo-600 dark:border-slate-700 dark:bg-slate-800 dark:text-slate-300 dark:hover:border-indigo-500 dark:hover:bg-slate-700 dark:hover:text-indigo-300 sm:size-11"
            >
              <.icon name="hero-arrow-left" class="size-5" />
            </.link>

            <div class="min-w-0">
              <h1 class="text-2xl font-bold tracking-tight text-slate-900 dark:text-slate-100 sm:text-3xl">
                Task Details
              </h1>

              <p class="mt-1 text-xs text-slate-500 dark:text-slate-400 sm:text-sm">
                View and manage your task information.
              </p>
            </div>
          </div>

          <.link
            navigate={~p"/todos/#{@todo}/edit?return_to=show"}
            class="inline-flex shrink-0 items-center justify-center gap-2 rounded-lg bg-indigo-600 px-3 py-2.5 text-sm font-semibold text-white shadow-sm transition hover:bg-indigo-700 focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-indigo-500 sm:px-4"
          >
            <.icon name="hero-pencil-square" class="size-4" /> Edit Task
          </.link>
        </header>

        <%!-- Main Task Card --%>
        <section class="min-w-0 overflow-hidden rounded-2xl border border-slate-200 bg-white shadow-sm dark:border-slate-700 dark:bg-slate-900">
          <%!-- Task Title and Status --%>
          <div class="flex flex-col justify-between gap-4 border-b border-slate-200 bg-slate-50 px-4 py-4 dark:border-slate-700 dark:bg-slate-800 sm:flex-row sm:items-center sm:px-6 sm:py-5 lg:px-8">
            <div class="min-w-0">
              <div class="flex flex-wrap items-center gap-2">
                <span class="inline-flex items-center rounded-md bg-indigo-100 px-2.5 py-1 text-xs font-semibold text-indigo-800 dark:bg-indigo-950 dark:text-indigo-300">
                  Task # {@todo.id}
                </span>

                <span class={[
                  "inline-flex items-center gap-1.5 rounded-full px-3 py-1 text-xs font-semibold",
                  if(@todo.completed,
                    do: "bg-emerald-100 text-emerald-800 dark:bg-emerald-950 dark:text-emerald-300",
                    else: "bg-amber-100 text-amber-900 dark:bg-amber-950 dark:text-amber-300"
                  )
                ]}>
                  <span class={[
                    "size-1.5 rounded-full",
                    if(@todo.completed,
                      do: "bg-emerald-600 dark:bg-emerald-400",
                      else: "bg-amber-600 dark:bg-amber-400"
                    )
                  ]}></span>

                  {if @todo.completed, do: "Completed", else: "Pending"}
                </span>
              </div>

              <h2 class="mt-3 break-words text-xl font-bold leading-snug text-slate-900 dark:text-slate-100 sm:text-2xl lg:text-3xl">
                {@todo.title}
              </h2>

              <p class="mt-2 text-sm text-slate-500 dark:text-slate-400">
                Task information and current status
              </p>
            </div>

            <div class="flex min-w-0 shrink-0 items-center gap-3 rounded-xl border border-slate-200 bg-white p-3 dark:border-slate-700 dark:bg-slate-900 sm:min-w-40">
              <span class={[
                "flex size-10 shrink-0 items-center justify-center rounded-lg",
                if(@todo.completed,
                  do: "bg-emerald-100 text-emerald-700 dark:bg-emerald-950 dark:text-emerald-300",
                  else: "bg-amber-100 text-amber-700 dark:bg-amber-950 dark:text-amber-300"
                )
              ]}>
                <.icon
                  name={if @todo.completed, do: "hero-check-circle", else: "hero-clock"}
                  class="size-6"
                />
              </span>

              <div class="min-w-0">
                <p class="text-xs font-medium text-slate-500 dark:text-slate-400">
                  Current Status
                </p>

                <p class="mt-1 text-sm font-bold text-slate-900 dark:text-slate-100">
                  {if @todo.completed, do: "Finished", else: "In Progress"}
                </p>
              </div>
            </div>
          </div>

          <%!-- Task Information --%>
          <div class="grid min-w-0 grid-cols-1 gap-3 p-3 sm:grid-cols-2 sm:gap-4 sm:p-5 lg:gap-5 lg:p-6">
            <%!-- Title --%>
            <section class="min-w-0 rounded-xl border border-slate-200 bg-white p-4 transition hover:border-indigo-300 dark:border-slate-700 dark:bg-slate-900 dark:hover:border-indigo-700 sm:p-5">
              <div class="flex items-center gap-2">
                <span class="flex size-9 shrink-0 items-center justify-center rounded-lg bg-indigo-50 text-indigo-700 dark:bg-indigo-950 dark:text-indigo-300">
                  <.icon name="hero-document-text" class="size-5" />
                </span>

                <h3 class="text-sm font-semibold text-slate-500 dark:text-slate-400">
                  Task Title
                </h3>
              </div>

              <p class="mt-3 break-words text-base font-semibold leading-6 text-slate-900 dark:text-slate-100">
                {@todo.title}
              </p>
            </section>

            <%!-- Priority --%>
            <section class="min-w-0 rounded-xl border border-slate-200 bg-white p-4 transition hover:border-indigo-300 dark:border-slate-700 dark:bg-slate-900 dark:hover:border-indigo-700 sm:p-5">
              <div class="flex items-center gap-2">
                <span class="flex size-9 shrink-0 items-center justify-center rounded-lg bg-indigo-50 text-indigo-700 dark:bg-indigo-950 dark:text-indigo-300">
                  <.icon name="hero-flag" class="size-5" />
                </span>

                <h3 class="text-sm font-semibold text-slate-500 dark:text-slate-400">
                  Task Priority
                </h3>
              </div>

              <div class="mt-3">
                <span class={[
                  "inline-flex items-center gap-2 rounded-lg px-3 py-2 text-sm font-semibold",
                  case @todo.priority do
                    :high -> "bg-rose-50 text-rose-700 dark:bg-rose-950 dark:text-rose-300"
                    :medium -> "bg-amber-50 text-amber-800 dark:bg-amber-950 dark:text-amber-300"
                    :low -> "bg-teal-50 text-teal-700 dark:bg-teal-950 dark:text-teal-300"
                    _ -> "bg-slate-100 text-slate-700 dark:bg-slate-800 dark:text-slate-300"
                  end
                ]}>
                  <span class={[
                    "size-2 rounded-full",
                    case @todo.priority do
                      :high -> "bg-rose-600 dark:bg-rose-400"
                      :medium -> "bg-amber-600 dark:bg-amber-400"
                      :low -> "bg-teal-600 dark:bg-teal-400"
                      _ -> "bg-slate-500 dark:bg-slate-400"
                    end
                  ]}></span>

                  {@todo.priority |> to_string() |> String.capitalize()} Priority
                </span>
              </div>
            </section>

            <%!-- Description --%>
            <section class="min-w-0 rounded-xl border border-slate-200 bg-white p-4 transition hover:border-indigo-300 dark:border-slate-700 dark:bg-slate-900 dark:hover:border-indigo-700 sm:col-span-2 sm:p-5">
              <div class="flex items-center gap-2">
                <span class="flex size-9 shrink-0 items-center justify-center rounded-lg bg-indigo-50 text-indigo-700 dark:bg-indigo-950 dark:text-indigo-300">
                  <.icon name="hero-bars-3-bottom-left" class="size-5" />
                </span>

                <h3 class="text-sm font-semibold text-slate-500 dark:text-slate-400">
                  Description
                </h3>
              </div>

              <p class="mt-3 whitespace-pre-wrap break-words text-sm leading-7 text-slate-700 dark:text-slate-300">
                {if @todo.description in [nil, ""],
                  do: "No description provided.",
                  else: @todo.description}
              </p>
            </section>

            <%!-- Completion Status --%>
            <section class={[
              "min-w-0 rounded-xl border p-4 sm:col-span-2 sm:p-5",
              if(@todo.completed,
                do:
                  "border-emerald-200 bg-emerald-50/70 dark:border-emerald-900 dark:bg-emerald-950/40",
                else: "border-amber-200 bg-amber-50/70 dark:border-amber-900 dark:bg-amber-950/40"
              )
            ]}>
              <div class="flex items-start gap-3">
                <span class={[
                  "flex size-11 shrink-0 items-center justify-center rounded-xl",
                  if(@todo.completed,
                    do: "bg-emerald-100 text-emerald-700 dark:bg-emerald-900 dark:text-emerald-300",
                    else: "bg-amber-100 text-amber-700 dark:bg-amber-900 dark:text-amber-300"
                  )
                ]}>
                  <.icon
                    name={if @todo.completed, do: "hero-check-circle", else: "hero-clock"}
                    class="size-6"
                  />
                </span>

                <div class="min-w-0">
                  <h3 class="text-sm font-bold text-slate-900 dark:text-slate-100">
                    Completion Status
                  </h3>

                  <p class="mt-1 break-words text-sm leading-6 text-slate-600 dark:text-slate-300">
                    {if @todo.completed,
                      do: "This task has been completed successfully.",
                      else:
                        "This task is still pending. You can mark it as completed from the task list."}
                  </p>
                </div>
              </div>
            </section>
          </div>

          <%!-- Footer Actions --%>
          <footer class="flex flex-col-reverse gap-3 border-t border-slate-200 bg-slate-50 px-4 py-4 dark:border-slate-700 dark:bg-slate-800 sm:flex-row sm:items-center sm:justify-between sm:px-6 lg:px-8">
            <.link
              navigate={~p"/todos"}
              class="inline-flex w-full items-center justify-center gap-2 rounded-lg border border-slate-300 bg-white px-4 py-2.5 text-sm font-semibold text-slate-700 transition hover:bg-slate-100 focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-indigo-600 dark:border-slate-600 dark:bg-slate-800 dark:text-slate-200 dark:hover:bg-slate-700 sm:w-auto"
            >
              <.icon name="hero-arrow-left" class="size-4" /> Back to Tasks
            </.link>

            <.link
              navigate={~p"/todos/#{@todo}/edit?return_to=show"}
              class="inline-flex w-full items-center justify-center gap-2 rounded-lg bg-indigo-600 px-4 py-2.5 text-sm font-semibold text-white shadow-sm transition hover:bg-indigo-700 focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-indigo-500 sm:w-auto"
            >
              <.icon name="hero-pencil-square" class="size-4" /> Edit Task
            </.link>
          </footer>
        </section>
      </div>
    </Layouts.app>
    """
  end

  @impl true
  def mount(%{"id" => id}, _session, socket) do
    {:ok,
     socket
     |> assign(:page_title, "Show Todo")
     |> assign(:todo, Todos.get_todo!(id))}
  end
end
