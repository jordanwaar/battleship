defmodule BattleshipWeb.GameLive.WaitingRoomComponent do
  use BattleshipWeb, :live_component

  def render(assigns) do
    ~H"""
    <div class="text-center animate-fade-in">
      <h1>Aguardando outro jogador</h1>
    </div>
    """
  end
end
