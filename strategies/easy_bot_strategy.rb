
require_relative 'player_strategy'

class EasyBotStrategy < PlayerStrategy
  def choose_spot(board)
    available_spots = board.available_spots
    random_index = rand(0...available_spots.count)
    return available_spots[random_index]
  end
end
