defmodule TestModule do
  def start() do
    listid = []
    listid = start(2, listid)
    sendMsg(listid, 0)
  end

  def start(total, listid) do
    if total == 0 do
      listid
    else
      pid = spawn(fn -> creatingProcess(listid) end)
      start(total - 1, [pid | listid])
    end
  end

  def sendMsg(listid, idx) do
    if length(listid) == 0 do
      "#{idx}monu"
    else
      pid = hd(listid)
      tell = tl(listid)
      send(pid, {:hello, idx})
      sendMsg(tell, idx + 1)
    end
  end

  def creatingProcess(_listid) do
    IO.inspect(self(), label: "Process PID")
    IO.puts("created")

    receive do
      {:hello, idx} ->
        IO.puts("#{idx} receive")
    end
  end
end
