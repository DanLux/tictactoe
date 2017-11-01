
require_relative 'player_strategy'

class MediumBotStrategy < PlayerStrategy
  def choose_spot(board)
    available_spots = board.available_spots
    best_move = nil

    available_spots.each do |spot|
      board.mark_spot spot, @player_marker
      end_game = board.game_over?
      board.unmark_spot spot

      if end_game
        return spot
      else
        board.mark_spot spot, @opponent_marker
        if board.game_over?
          best_move = spot
        end
      end
      board.unmark_spot spot
    end

    if best_move
      return best_move
    else
      return available_spots[rand(0...available_spots.count)]
    end
  end
end
