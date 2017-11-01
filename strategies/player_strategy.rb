
require_relative '../board'

class PlayerStrategy
  def initialize(player_marker, opponent_marker)
    @player_marker = player_marker
    @opponent_marker = opponent_marker
  end

  def choose_spot(board)
    raise NotImplementedError
  end
end
