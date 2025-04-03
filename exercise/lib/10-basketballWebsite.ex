defmodule BasketballWebsite do
  defp extract(nil, _), do: nil
  defp extract(data, []), do: data
  defp extract(data, [key | others]), do: extract(data[key], others)

  def extract_from_path(data, path) do
    extract(data, String.split(path, "."))
  end

  def get_in_path(data, path) do
    Kernel.get_in(data, String.split(path, "."))
  end
end
