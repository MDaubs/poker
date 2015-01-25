defmodule WebPoker.GameController do
  use Phoenix.Controller

  plug :action

  def new(conn, _params) do
    render conn, "new.html"
  end

  def create(conn, params) do
    game_id = WebPoker.GameTracker.create_game("My Poker Game")
    redirect conn, to: "/games/#{game_id}"
  end

  def show(conn, %{"id" => id}) do
    {hand, deck} = WebPoker.Deck.new |> WebPoker.Deck.deal(5)
    render conn, "show.html", %{id: id, hand: hand, game: WebPoker.GameTracker.get_game(id)}
  end
end
