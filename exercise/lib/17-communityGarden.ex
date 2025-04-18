# Use the Plot struct as it is provided
defmodule Plot do
  @enforce_keys [:plot_id, :registered_to]
  defstruct [:plot_id, :registered_to]
end

defmodule CommunityGarden do
  def start(opts \\ []) do
    Agent.start(fn -> opts end)
  end

  def list_registrations(pid) do
    Agent.get(pid, & &1)
  end

  def register(pid, register_to) do
    Agent.update(pid, fn state ->
      next_id =
        case state do
          [] -> 1
          _ -> Enum.max_by(state, & &1.plot_id).plot_id + 1
        end

      plot = %Plot{plot_id: next_id, registered_to: register_to}
      state ++ [plot]
    end)

    plot
  end

  def release(pid, plot_id) do
  end

  def get_registration(pid, plot_id) do
  end
end
