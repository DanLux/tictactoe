
require_relative 'medium_bot_strategy'

class HardBotStrategy < MediumBotStrategy
  def choose_spot(board)
    @depth_limit = 7 - (board.size/2.0).ceil
    return obvious_choice(board) || estimate_best_move(board)
  end

  def estimate_best_move(board)
    best_score, best_moves = minimax(board)
    best_moves.sample
  end

  private

  PERFECT_SCORE = 1000000

  def evaluate_board(board)
    case board.winner
    when @player_marker
      return PERFECT_SCORE - board.total_moves
    when @opponent_marker
      return -(PERFECT_SCORE - board.total_moves)
    when true # tie
      return 0
    else
      favorable_rows = 0
      unfavorable_rows = 0
      board.winning_rows.each do |row|
        markers = row.map { |spot| board.get_mark spot }
        if not markers.include?(@opponent_marker)
          favorable_rows += 2 ** markers.count(@player_marker)
        elsif not markers.include?(@player_marker)
          unfavorable_rows += 2 ** markers.count(@opponent_marker)
        end
      end
      return favorable_rows - unfavorable_rows
    end
  end

  def bot_turn?(player_marker)
    player_marker == @player_marker
  end

  def found_better_score?(player_marker, score, current_score)
    signal = bot_turn?(player_marker) ? -1 : 1
    signal * score < signal * current_score
  end

  def minimax(board, player_marker=@player_marker, opponent_marker=@opponent_marker, depth = 1)
    best_score = bot_turn?(player_marker) ? -Float::INFINITY : Float::INFINITY
    best_moves = []
    board.available_spots.each do |spot|
      board.mark_spot spot, player_marker

      if depth == @depth_limit || board.game_over
        score = evaluate_board board
      else
        score, _ = minimax(board, opponent_marker, player_marker, depth + 1)
      end

      if score == best_score
        best_score = score
        best_moves << spot
      elsif found_better_score?(player_marker, score, best_score)
        best_score, best_moves = score, [spot]
      end

      board.unmark_spot spot
    end
    return best_score, best_moves
  end
end
