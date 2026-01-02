defmodule CartgenServer do
  use GenServer

  def start_link(initial_state \\ []) do
    GenServer.start_link(__MODULE__, initial_state, name: __MODULE__)
  end

  def addItem(item) do
    GenServer.cast(__MODULE__, {:add_item, item})
  end

  def getItems() do
    GenServer.call(__MODULE__, :get_items)
  end

  def init(initial_state) do
    {:ok, initial_state}
  end

  def handle_cast({:add_item, item}, state) do
    new_state = [item | state]
    {:noreply, new_state}
  end

  def handle_call(:get_items, _from, state) do
    {:reply, state, state}
  end
end
