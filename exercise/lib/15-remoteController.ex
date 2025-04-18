defmodule RemoteControlCar do
  @enforce_keys [:nickname]
  defstruct [:nickname, battery_percentage: 100, distance_driven_in_meters: 0]

  def new(nickname \\ "none"), do: %RemoteControlCar{nickname: nickname}

  def display_distance(%RemoteControlCar{distance_driven_in_meters: distance}),
    do: "#{distance} meters"

  def display_battery(%RemoteControlCar{battery_percentage: battery}) do
    case battery do
      0 -> "Battery empty"
      _ -> "Battery at #{battery}%"
    end
  end

  def drive(
        %RemoteControlCar{
          battery_percentage: battery,
          distance_driven_in_meters: distance,
          nickname: name
        } = car
      ) do
    case battery do
      0 ->
        car

      _ ->
        %RemoteControlCar{
          battery_percentage: battery - 1,
          distance_driven_in_meters: distance + 20,
          nickname: name
        }
    end
  end
end
