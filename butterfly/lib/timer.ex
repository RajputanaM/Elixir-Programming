defmodule Countdown do
  use GenServer

  def start(initial_money \\ 0) do
    GenServer.start(__MODULE__, initial_money, name: __MODULE__)
  end

  def add_money(amount) do
    GenServer.cast(__MODULE__, {:add_money, amount})
  end

  def get_money() do
    GenServer.call(__MODULE__, :get_money)
  end

  def init(state) do
    {:ok, state}
  end

  def handle_cast({:add_money, amount}, state) do
    state = state + amount
    {:noreply, state}
  end

  def handle_call(:get_money, _from, state) do
    {:reply, state, state}
  end
end
