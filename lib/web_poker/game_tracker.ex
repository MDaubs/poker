defmodule WebPoker.GameTracker do
  def start_link do
    Agent.start_link(&HashDict.new/0, name: __MODULE__)
  end

  def create_game(name) do
    game_id = UUID.uuid4(:hex)
    Agent.update(__MODULE__, fn dict -> Dict.put(dict, game_id, %{name: name}) end)
    game_id
  end

  def get_game(game_id) do
    Agent.get(__MODULE__, fn dict -> Dict.get(dict, game_id) end)
  end
end
