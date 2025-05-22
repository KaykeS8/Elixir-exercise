defmodule TopSecret do
  def to_ast(string) do
    Code.string_to_quoted(string) |> elem(1)
  end

  def decode_secret_message_part(ast, acc) do
    case ast do
      {:def, _, [fun]} ->
        name_of_function = elem(fun, 0)
        {ast, [name_of_function | acc]}

      {:defp, _, [fun]} ->
        name_of_function = elem(fun, 0)
        {ast, [name_of_function | acc]}

      _ -> {ast, acc}
    end
  end

  def decode_secret_message(string) do
  end
end
