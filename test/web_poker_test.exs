defmodule WebPokerTest do
  use ExUnit.Case, async: true
  doctest WebPoker.Card
  doctest WebPoker.Deck
  doctest WebPoker.Table

  test "the truth" do
    assert 1 + 1 == 2
  end
end
