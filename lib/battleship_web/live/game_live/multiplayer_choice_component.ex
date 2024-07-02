defmodule BattleshipWeb.GameLive.MultiplayerChoiceComponent do
  use BattleshipWeb, :live_component

  @impl true
  def render(assigns) do
    ~H"""
    <div class="animate-fade-in" id="multiplayer-choice-component">
      <.btn click="multiplayer" to="#multiplayer-choice-component" class="mt-6 text-white p-2 rounded bg-green-600 hover:bg-green-500 font-bold transition-all ease-linear block mx-auto">Iniciar o posicionamento dos navios.</.btn>

      <.btn click="index" to="#multiplayer-choice-component" class="mt-6 text-white p-2 rounded bg-red-600 hover:bg-reds-500 font-bold transition-all ease-linear block mx-auto">Voltar</.btn>
    </div>
    """
  end
end
