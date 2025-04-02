defmodule BoutiqueInventory do
  def sort_by_price(inventory), do: Enum.sort_by(inventory, &(&1.price), :asc)

  def with_missing_price(inventory), do: Enum.filter(inventory, &(!&1.price))

  def update_names(inventory, old_word, new_word) do
    Enum.map(inventory, fn item ->
      Map.update!(item, :name, fn name -> String.replace(name, old_word, new_word) end)
    end)
  end

  def increase_quantity(item, count) do
    new_value =
      Map.new(item.quantity_by_size, fn {key, value} -> {key, value + count} end)

    Map.put(item, :quantity_by_size, new_value)
  end

  def total_quantity(item) do
    all_sizes =
      Map.new(item.quantity_by_size, fn {k, v} -> {k,v} end)
      |> Map.values()

    Enum.reduce(all_sizes, 0, fn size, acc ->  size + acc end)
  end
end
