defmodule HighScore do
  def new(), do: %{}
  @default_score 0
  def add_player(scores, name, score \\ @default_score), do: Map.put(scores, name, score)
  def remove_player(scores, name), do: Map.delete(scores, name)
  def reset_score(scores, name), do: Map.update(scores, name, @default_score, &(&1 - &1))

  def update_score(scores, name, score),
    do: scores |> Map.update(name, score, fn x -> x + score end)

  def get_players(scores), do: Map.keys(scores)
end
