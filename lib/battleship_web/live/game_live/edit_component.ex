defmodule BattleshipWeb.GameLive.EditComponent do
  @moduledoc """
  This module handles editing(ex. placing ships) of player board
  """
  use BattleshipWeb, :live_component

  alias Battleship.{Gameboard, Ship}

  @impl true
  def mount(socket) do
    {
      :ok,
      assign(socket,
        ship: Ship.get_ship(5),
        axis: "horizontal",
        edit: true,
        error: nil,
        access_next_page: false,
        gameboard: Gameboard.generate_board()
      )
    }
  end

  @impl true
  def handle_event("change-axis", _, %{assigns: %{axis: "horizontal"}} = socket),
    do: {:noreply, assign(socket, :axis, "vertical")}

  def handle_event("change-axis", _, %{assigns: %{axis: "vertical"}} = socket),
    do: {:noreply, assign(socket, :axis, "horizontal")}

  def handle_event(
        "click",
        %{"row" => row, "col" => col},
        %{assigns: %{gameboard: gameboard, ship: ship, axis: axis}} = socket
      ) do
    case add_ship_to_gameboard(
           gameboard,
           ship,
           [String.to_integer(row), String.to_integer(col)],
           axis
         ) do
      {:ok, new_gameboard} ->
        {:noreply,
         socket
         |> assign(:gameboard, new_gameboard)
         |> assign(:error, nil)
         |> change_ship(ship)}

      {:error, :out_of_range} ->
        {:noreply, assign(socket, error: "Out of range. Please select another slot.")}

      {:error, :element_already_present} ->
        {:noreply,
         assign(socket,
           error: "A ship is already present in that slot range. Please select another slot."
         )}
    end
  end

  defp change_ship(socket, current_ship) when current_ship > 2,
    do: assign(socket, :ship, Ship.get_ship(current_ship - 1))

  defp change_ship(socket, current_ship) when current_ship <= 2 do
    send(self(), {:update_player_gameboard, %{gameboard: socket.assigns.gameboard}})
    socket |> assign(:edit, false) |> assign(:access_next_page, true)
  end

  defp add_ship_to_gameboard(board, ship, [initial_row, inital_col], "horizontal") do
    start_position = [initial_row, inital_col]
    end_position = [initial_row, inital_col + ship - 1]
    Gameboard.put_ship(board, ship, [start_position, end_position])
  end

  defp add_ship_to_gameboard(board, ship, [initial_row, inital_col], "vertical") do
    start_position = [initial_row, inital_col]
    end_position = [initial_row + ship - 1, inital_col]
    Gameboard.put_ship(board, ship, [start_position, end_position])
  end
end
