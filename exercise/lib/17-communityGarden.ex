# Use the Plot struct as it is provided
defmodule Plot do
  @enforce_keys [:plot_id, :registered_to]
  defstruct [:plot_id, :registered_to]
end

defmodule CommunityGarden do
  defstruct [counter_id: 0, plots: []]

  defp initial_value, do: %CommunityGarden{counter_id: 0, plots: []}
  def start(opts \\ []) do
    Agent.start(&initial_value/0, opts)
  end

  def list_registrations(pid) do
    Agent.get(pid, &(&1.plots))
  end

  def register(pid, register_to) do
      Agent.get_and_update(pid, fn garden ->
        plot = %Plot{plot_id: garden.counter_id + 1, registered_to: register_to}
        {plot, %{counter_id: garden.counter_id + 1, plots: [plot | garden.plots]}}
      end)
  end

  def release(pid, plot_id) do
    Agent.update(pid, fn state ->
      %{state | plots: state.plots |> Enum.filter(&(&1.plot_id != plot_id))}
    end)
  end

  def get_registration(pid, plot_id) do
    plot = list_registrations(pid) |> Enum.filter(&(&1.plot_id == plot_id)) |> List.first()
    case plot do
      nil -> {:not_found, "plot is unregistered"}
      _ -> plot
    end
  end
end
