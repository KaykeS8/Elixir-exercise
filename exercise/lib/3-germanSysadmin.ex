defmodule Username do
  def sanitize([]), do: []

  def sanitize([head | tail]) do
    value =
      case head do
        ?ä -> ~c"ae"
        ?ö -> ~c"oe"
        ?ü -> ~c"ue"
        ?ß -> ~c"ss"
        _ when head >= 97 and head <= 122 -> [head]
        _ when head == 95 -> [head]
        _ -> ~c""
      end

    value ++ sanitize(tail)
  end
end
