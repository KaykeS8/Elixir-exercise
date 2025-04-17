defmodule BoutiqueSuggestions do
  def get_combinations(tops, bottoms, options = []) do
    for first_item <- tops,
        second_item <- bottoms do
      {first_item, second_item}
    end
  end
end
