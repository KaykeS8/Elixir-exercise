defmodule LibraryFees do
  def datetime_from_string(string), do: NaiveDateTime.from_iso8601(string) |> elem(1)

  def before_noon?(datetime), do: NaiveDateTime.to_time(datetime) < ~T[12:00:00]

  def return_date(checkout_datetime) do
    case before_noon?(checkout_datetime) do
      true -> checkout_datetime |> to_date() |> Date.add(28)
      false -> checkout_datetime |> to_date() |> Date.add(29)
    end
  end

  def days_late(planned_return_date, actual_return_datetime) do
    date = actual_return_datetime |> to_date() |> Date.diff(planned_return_date)

    cond do
      date > 0 -> date
      true -> 0
    end
  end

  def monday?(datetime), do: to_date(datetime) |> Date.day_of_week(:monday) == 1

  def calculate_late_fee(checkout, return, rate) do
    day_of_return = datetime_from_string(return)

    late_days =
      checkout
      |> datetime_from_string()
      |> return_date()
      |> days_late(day_of_return)

    (late_days * rate)
    |> apply_discount_if_monday(day_of_return)
    |> trunc()
  end

  defp to_date(datetime), do: NaiveDateTime.to_date(datetime)

  defp apply_discount_if_monday(fee, date), do: if(monday?(date), do: fee * 0.5, else: fee)
end
