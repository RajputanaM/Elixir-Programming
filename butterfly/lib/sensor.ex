defmodule Sensor do
  use GenServer

  def start_link(state \\ %{}) do
    GenServer.start_link(__MODULE__, state.__MODULE__)
  end

  def init(state) do
    Process.send_after(self(), :check_sensor, 1000)
    {:ok, Map.merge(%{power: 0, voltage: 0, current: 0}, state)}
  end

  def handle_info(:check_sensor, state) do
    newstate = %{
      state
      | power: :rand.uniform(100),
        voltage: :rand.uniform(100),
        current: :rand.uniform(100)
    }

    GenServer.cast(state.parent, {:check_sensor, newstate, self()})
    Process.send_after(self(), :check_sensor, 1000)
    {:noreply, newstate}
  end
end
