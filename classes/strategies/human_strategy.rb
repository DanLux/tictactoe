
require_relative 'player_strategy'

class HumanStrategy < PlayerStrategy
  def choose_spot(board)
    valid_spots = board.all_spots
    available_spots = board.available_spots
    puts "> Enter [#{ valid_spots.first }-#{ valid_spots.last }]:"
    InputReader::read_integer { |spot| available_spots.include? spot }
  end
end
