defmodule Username do
  def sanitize([]), do: []
  def sanitize([head | tail]) do
    value =
      case head do
        ?ä -> 'ae'
        ?ö -> 'oe'
        ?ü -> 'ue'
        ?ß -> 'ss'
        _ when head >= 97 and head <= 122 -> [head]
        _ when head == 95 -> [head]
        _ -> ''
      end
      value ++ sanitize(tail)
  end
end
