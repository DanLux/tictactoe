
require_relative 'board'
require_relative 'strategies/human_strategy'
require_relative 'strategies/easy_bot_strategy'
require_relative 'strategies/medium_bot_strategy'
require_relative 'strategies/hard_bot_strategy'

class Player
  attr_reader :marker

  def initialize(marker)
    @marker = marker
  end

  def do_move(board)
    spot = @strategy.choose_spot board
    board.mark_spot spot, @marker
  end
end


class HumanPlayer < Player
  def initialize(marker, opponent_marker)
    super(marker)
    @strategy = HumanStrategy.new(marker, opponent_marker)
  end
end


class BotPlayer < Player
  @@STRATEGIES = {
    :easy => EasyBotStrategy,
    :medium => MediumBotStrategy,
    #:hard => HardBotStrategy,
  }

  def self.available_levels
    @@STRATEGIES.keys
  end

  def initialize(marker, opponent_marker, level)
    super(marker)
    @strategy = @@STRATEGIES[level].new(marker, opponent_marker)
  end
end
