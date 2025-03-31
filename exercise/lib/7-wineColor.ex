defmodule WineCellar do
  def explain_colors do
    [
      white: "Fermented without skin contact.",
      red: "Fermented with skin contact using dark-colored grapes.",
      rose: "Fermented with some skin contact, but not enough to qualify as a red wine."
    ]
  end

  def filter(cellar, color, opts \\ []) do
    wines = Keyword.get_values(cellar, color)

    wines
    |> maybe_filter_by_year(opts)
    |> maybe_filter_by_country(opts)
  end

  defp maybe_filter_by_year(wines, opts) do
    case Keyword.get(opts, :year) do
      nil -> wines
      year -> filter_by_year(wines, year)
    end
  end

  defp maybe_filter_by_country(wines, opts) do
    case Keyword.get(opts, :country) do
      nil -> wines
      country -> filter_by_country(wines, country)
    end
  end

  defp filter_by_year([], _year), do: []

  defp filter_by_year([{_, year, _} = wine | tail], year) do
    [wine | filter_by_year(tail, year)]
  end

  defp filter_by_year([{_, _, _} | tail], year) do
    filter_by_year(tail, year)
  end

  defp filter_by_country([], _country), do: []

  defp filter_by_country([{_, _, country} = wine | tail], country) do
    [wine | filter_by_country(tail, country)]
  end

  defp filter_by_country([{_, _, _} | tail], country) do
    filter_by_country(tail, country)
  end
end

# Example usage:
# lista = [
#   white: {"Chardonnay", 2015, "Italy"},
#   white: {"Pinot grigio", 2017, "Germany"},
#   red: {"Pinot noir", 2016, "France"},
#   rose: {"Dornfelder", 2018, "Germany"}
# ]
# WineCellar.filter(lista, :white, year: 2015)
# WineCellar.filter(lista, :red, country: "France")
