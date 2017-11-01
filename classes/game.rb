
require_relative 'board'
require_relative 'player'
require_relative 'input_reader'
require_relative 'extensions/string_extension'

class Game
  def initialize
    @markers = ['X', 'O']
  end

  def current_player
    @players[@turn]
  end

  def select_board
    puts "\nFirst select the board size (2x2 up to 10x10)"
    print "> Enter size [2-10]: "
    size = InputReader::read_integer { |size| (2..10).include? size }
    @board = Board.new size
  end

  def add_players
    @players ||= []
    (0...2).each do |marker_id|
      player_marker = @markers[marker_id]
      opponent_marker = @markers[1 - marker_id]

      puts "\nLet's add player #{player_marker}"
      puts "> Enter 0 for human player or 1 for bot player:"
      option = InputReader::read_integer { |option| (0..1).include? option }

      if option == 0
        new_player = HumanPlayer.new(player_marker, opponent_marker)
      else
        available_levels = BotPlayer.available_levels
        level_options_message = available_levels.each_with_index.map { |level, id| "#{id} for #{level}" }.join(", ")
        puts "Now choose AI level for bot"
        puts "> Enter #{level_options_message}:"

        level = InputReader::read_integer { |level| (0...available_levels.length).include? level }
        new_player = BotPlayer.new(player_marker, opponent_marker, available_levels[level])
      end
      @players << new_player
    end
  end

  def start_turn
    if @turn
      @turn = 1 - @turn
    else
      @turn = 0
    end
    puts "#{current_player.marker} turn".cyan
  end

  def play
    puts "*** Welcome to Tic-Tac-Toe game ***"
    select_board
    add_players
    @board.print_board
    until @board.game_over?
      start_turn
      current_player.do_move @board
      @board.print_board
    end
    @board.print_final_board
  end
end
