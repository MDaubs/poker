defmodule WebPoker.Card do
  @unicode_base  0b1111000010011111100000
  @unicode_ace   0x1
  @unicode_jack  0xB
  @unicode_queen 0xD
  @unicode_king  0xE

  @doc ~S"""
  Returns a card given a rank and suit.

  ## Examples

      iex> WebPoker.Card.unicode({7, :diamonds})
      "🃇"

      iex> WebPoker.Card.unicode({10, :spades})
      "🂪"

      iex> WebPoker.Card.unicode({:queen, :hearts})
      "🂽"

      iex> WebPoker.Card.unicode({:ace, :clubs})
      "🃑"

      iex> WebPoker.Card.unicode([{:ace, :clubs}, {10, :spades}])
      ["🃑", "🂪"]
  """

  def unicode([top_card | remaining_cards]), do: [unicode(top_card) | unicode(remaining_cards)]
  def unicode([]), do: []

  def unicode({rank, :clubs}),    do: << @unicode_base :: size(22), 3 :: size(2), 0b10 :: size(2), 1 :: size(2), unicode_rank(rank) :: size(4) >>
  def unicode({rank, :diamonds}), do: << @unicode_base :: size(22), 3 :: size(2), 0b10 :: size(2), 0 :: size(2), unicode_rank(rank) :: size(4) >>
  def unicode({rank, :hearts}),   do: << @unicode_base :: size(22), 2 :: size(2), 0b10 :: size(2), 3 :: size(2), unicode_rank(rank) :: size(4) >>
  def unicode({rank, :spades}),   do: << @unicode_base :: size(22), 2 :: size(2), 0b10 :: size(2), 2 :: size(2), unicode_rank(rank) :: size(4) >>

  defp unicode_rank(:ace), do: @unicode_ace
  defp unicode_rank(:jack), do: @unicode_jack
  defp unicode_rank(:queen), do: @unicode_queen
  defp unicode_rank(:king), do: @unicode_king
  defp unicode_rank(number) when number in (2..10), do: number
end
