defmodule TakeANumber do
  def start() do
    spawn(TakeANumber, :loop, [0])
  end

  def loop(state) do
    receive do
      {:report_state, sender_pid} ->
        send(sender_pid, state)
        loop(state)

      {:take_a_number, sender_pid} ->
        send(sender_pid, state + 1)
        loop(state + 1)

      :stop ->
        IO.puts("Stop machine")

      _ ->
        loop(state)
    end
  end
end
