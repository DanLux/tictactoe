
require_relative 'easy_bot_strategy'

class MediumBotStrategy < EasyBotStrategy
  def choose_spot(board)
    return obvious_choice(board) || random_choice(board)
  end

  private

  def obvious_choice(board)
    board.available_spots.each do |spot|
      board.mark_spot spot, @player_marker
      victory = board.game_over
      board.unmark_spot spot

      board.mark_spot spot, @opponent_marker
      defeat = board.game_over
      board.unmark_spot spot

      if victory || defeat
        return spot
      end
    end
    return nil
  end
end
