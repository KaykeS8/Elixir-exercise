defmodule LucasNumbers do

  @message_error "count must be specified as an integer >= 1"

  def generate(count) when is_integer(count) and count >= 1 do
    Stream.unfold({2,1}, fn {a,b} -> {a, {b, a + b}} end)
    |> Enum.take(count)
  end

  def generate(_), do: raise(ArgumentError, @message_error)

end
