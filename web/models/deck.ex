defmodule WebPoker.Deck do
  @suits [:clubs, :diamonds, :hearts, :spades]
  @ranks [:ace, 2, 3, 4, 5, 6, 7, 8, 9, 10, :jack, :queen, :king]

  @doc ~S"""
  Returns a new shuffled deck of cards.

  ## Examples

      iex> length WebPoker.Deck.new
      52

      iex> {7, :clubs} in WebPoker.Deck.new
      true

      iex> {:ace, :spades} in WebPoker.Deck.new
      true
  """
  def new do
    all_cards |> Enum.shuffle
  end

  defp all_cards do
    for suit <- @suits, rank <- @ranks, do: {rank, suit}
  end

  @doc ~S"""
  Returns the top +count+ cards from +deck+ and the new deck.

  ## Examples

      iex> [{4, :hearts}, {:queen, :clubs}, {8, :diamonds}]
      iex> |> WebPoker.Deck.deal(1)
      {[{4, :hearts}], [{:queen, :clubs}, {8, :diamonds}]}
  """
  def deal(deck, count) do
    Enum.split deck, count
  end
end
