defmodule NameBadge do
  def print(id, name, department) do
    cond do
      !department && !id -> "#{name} - OWNER"
      !department -> "[#{id}] - #{name} - OWNER"
      id -> "[#{id}] - #{name} - #{String.upcase(department)}"
      !id -> "#{name} - #{String.upcase(department)}"
    end
  end
end
