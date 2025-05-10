defmodule RPNCalculator.Exception do
  defmodule DivisionByZeroError do
    defexception message: "division by zero occurred"
  end

  defmodule StackUnderflowError do
    defexception message: "stack underflow occurred"

    def exception(value) when is_binary(value) do
      %__MODULE__{message: "stack underflow occurred, context: #{value}"}
    end

    def exception(_) do
      %__MODULE__{message: "stack underflow occurred"}
    end
  end

  def divide(list) when length(list) < 2, do: raise(StackUnderflowError, "when dividing")
  def divide([0, _]), do: raise DivisionByZeroError
  def divide([divisor, dividend]), do: dividend / divisor
end
