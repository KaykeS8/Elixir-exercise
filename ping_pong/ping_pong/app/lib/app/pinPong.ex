defmodule App.Ping do
  def start() do
    wait()
  end

  def wait() do
    receive do
      {pid, :pong} -> send(pid, {self(), :ping})
      IO.puts "PONG"
    end
    wait()
  end
end

defmodule App.Pong do
  def start() do
    wait()
  end

  def wait() do
    receive do
      {pid, :ping} -> send(pid, {self(), :pong})
      IO.puts "PING"
    end
    wait()
  end
end

defmodule App.Table do
  def start() do
    pong = spawn(App.Pong, :start, [])
    ping = spawn(App.Ping, :start, [])
    send(ping, {pong, :pong})
  end
end
