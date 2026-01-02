defmodule Vendor do
  use GenServer

  def start_link(state \\ 0) do
    GenServer.start_link(__MODULE__, state, __MODULE__)
  end

  def init(state) do
    for i <- 0..state.num_sensors do
      GenServer.start_link(Sensor, %{id: i, parent: self()})
    end

    new_state =
      Map.merge(state, %{
        sensor_data: %{},
        count: 0
      })

    {:ok, new_state}
  end

  def handle_cast({:check_sensor, newstate, sensorid}, state) do
    newdata = Map.put(state.sensor_data, sensorid, newstate)
    newcount = state.count + 1

    new_state = Map.put(state, :sensor_data, newdata)
    new_state = Map.put(new_state, :count, newcount)

    if newcount == state.num_sensors do
      GenServer.cast(state.parent, {:check_vendors, new_state, self()})
    end

    {:noreply, new_state}
  end
end
