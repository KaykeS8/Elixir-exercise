defmodule Recursao do
  # def count([]), do: 0
  # def count([_head | tail]), do: 1 + count(tail)

  def count(list), do: do_count(list, 0)

  defp do_count([], count), do: count
  defp do_count([_head | tail], count), do: do_count(tail, count + 1)
end
