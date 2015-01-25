defmodule WebPoker.Table do
  use GenServer

  @doc ~S"""
  Creates a new poker table with +capacity+ seats.
  Returns the PID of the new table.
  """
  def create(capacity \\ 6) do
    seats = Enum.map(1..capacity, fn(_x) -> nil end)
    GenServer.start_link(__MODULE__, {seats})
  end

  @doc ~S"""
  Adds a player to a table.

  On success, returns the tuple {:ok, seat} where seat is the seat number that
  the player was placed.

  If the table is full, returns the tuple {:full, :at_capacity}.

  ## Examples

      iex> {:ok, table} = WebPoker.Table.create(2)
      iex> {:ok, 1} = WebPoker.Table.add_player(table, "Alice")
      iex> {:ok, 2} = WebPoker.Table.add_player(table, "Bob")
      iex> WebPoker.Table.add_player(table, "Carol")
      {:error, :at_capacity}
  """
  def add_player(table_pid, name) do
    GenServer.call(table_pid, {:add_player, name})
  end

  def handle_call({:add_player, name}, _from, {seats}) do
    case fill_next_available_seat(name, seats, 1) do
      {:ok, seat_number, updated_seats} -> {:reply, {:ok, seat_number}, {updated_seats}}
      :full -> {:reply, {:error, :at_capacity}, {seats}}
    end
  end

  defp fill_next_available_seat(name, [], _seat_number), do: :full
  defp fill_next_available_seat(name, [nil | other_seats], seat_number), do: {:ok, seat_number, [name | other_seats]}
  defp fill_next_available_seat(name, [_occupied | other_seats], seat_number), do: fill_next_available_seat(name, other_seats, seat_number + 1)
end
