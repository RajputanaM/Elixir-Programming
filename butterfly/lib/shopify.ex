defmodule Shop do
  def start() do
    CartgenServer.start_link([])
  end

  def add_item(item) do
    CartgenServer.addItem(item)
  end

  def get_items() do
    CartgenServer.getItems()
  end

  def print_items() do
    items = get_items()
    IO.inspect(items, label: "Items in cart")
  end

  def clear_cart() do
    CartgenServer.start_link([])
    IO.puts("Cart cleared.")
  end

  # def removeItem(item) do
  #   items = get_items()
  #   new_items = List.delete(items, item)
  #   GenServer.cast(CartgenServer, {:update_items, new_items})
  #   IO.puts("Item removed: #{item}")
  # end
end
