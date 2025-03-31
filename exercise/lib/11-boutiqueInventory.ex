defmodule BoutiqueInventory do
  def sort_by_price(inventory), do: Enum.sort_by(inventory, &(&1.price), :asc)

  def with_missing_price(inventory), do: Enum.filter(inventory, &(!&1.price))

  def update_names(inventory, old_word, new_word) do
    Enum.map(inventory, fn item ->
      Map.update!(item, :name, fn name -> String.replace(name, old_word, new_word) end)
    end)
  end

  def increase_quantity(item, count) do
    Map.new(item, fn {k, v} -> {k, v} end)
  end

  def total_quantity(item) do
  end
end


# inventory = [
#   %{price: 65, name: "Maxi Brown Dress", quantity_by_size: %{}},
#   %{price: nil, name: "Red Short Skirt", quantity_by_size: %{}},
#   %{price: nil, name: "Black Short Skirt", quantity_by_size: %{}},
#   %{price: 20, name: "Bamboo Socks Cats", quantity_by_size: %{}}
# ]

# data = %{
#   name: "Polka Dot Skirt",
#   price: 68,
#   quantity_by_size: %{s: 3, m: 5, l: 3, xl: 4}
# }
