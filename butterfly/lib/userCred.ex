defmodule Usercred do
  use GenServer

  def start(initial_state \\ %{}) do
    GenServer.start_link(__MODULE__, initial_state, name: __MODULE__)
  end

  def init(state) do
    {:ok, state}
  end

  def add_user(userid, password) do
    GenServer.cast(__MODULE__, {:add_user, userid, password})
  end

  def get_password(userid) do
    GenServer.call(__MODULE__, {:getpass, userid})
  end

  def update_password(userid, password) do
    GenServer.cast(__MODULE__, {:update_password, userid, password})
  end

  def get_all_users() do
    GenServer.call(__MODULE__, :get_all_users)
  end

  def handle_call(:get_all_users, _from, state) do
    {:reply, Map.keys(state), state}
  end

  def handle_call({:getpass, userid}, _from, state) do
    password = Map.get(state, userid, "No password found")
    {:reply, password, state}
  end

  def handle_cast({:add_user, userid, password}, state) do
    new_state = Map.put(state, userid, password)
    {:noreply, new_state}
  end

  def handle_cast({:update_password, userid, password}, state) do
    new_state = Map.put(state, userid, password)
    {:noreply, new_state}
  end
end
