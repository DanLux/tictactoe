
require_relative 'player_strategy'

class EasyBotStrategy < PlayerStrategy
  def choose_spot(board)
    random_choice(board)
  end

  private

  def random_choice(board)
    board.available_spots.sample
  end
end
