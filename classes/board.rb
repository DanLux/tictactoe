
class Board
  attr_reader :all_spots

  def initialize(size=3)
    @size = size
    @all_spots = (0...@size ** 2).to_a
    @winning_spots = horizontal_spots + vertical_spots + diagonal_spots

    @board = @all_spots.map { |spot| spot.to_s }
    @initial_board = @board.clone
    @total_moves = 0
  end

  def get_mark(spot)
    @board[spot]
  end

  def mark_spot(spot, mark)
    if @initial_board.include? mark
      raise ArgumentError, "Invalid mark"
    end

    if is_available? spot
      @board[spot] = mark
      @last_move = spot
      @total_moves += 1
    end
  end

  def unmark_spot(spot)
    if not is_available? spot
      @board[spot] = @initial_board[spot]
      @total_moves -= 1
    end
  end

  def is_available?(spot)
    @board[spot] == @initial_board[spot]
  end

  def available_spots
    @all_spots.select { |spot| is_available? spot  }
  end

  def marked_spots_in_a_row
    @winning_spots.find do |spots_row|
      row_marks = spots_row.map { |spot| get_mark spot }
      row_marks.uniq.length == 1
    end
  end

  def game_over?
    (not marked_spots_in_a_row.nil?) || tie?
  end

  def tie?
    available_spots.empty?
  end


  def print_board
    puts "Board ##{@total_moves}"
    customizable_print_board do |spot|
      mark = get_mark(spot)
      if spot == @last_move
        mark.red
      elsif not is_available? spot
        mark.blue
      else
        mark
      end
    end
  end

  def print_final_board
    if (winning_row = marked_spots_in_a_row)
      puts "Game over: #{get_mark(winning_row.first)} won"
      customizable_print_board do |spot|
        mark = get_mark(spot)
        winning_row.include?(spot) ? mark.green : mark
      end
    elsif tie?
      puts 'Game over: Tie'
      customizable_print_board do |spot|
        get_mark(spot).yellow
      end
    end
  end

  private

  def customizable_print_board
    @all_spots.each do |spot|
      if spot % @size == 0
        if spot > 0
          puts "\n====#{"+====" * (@size - 1)}"
        end
      else
        print "|"
      end
      formatted_mark = (yield spot if block_given?) || get_mark(spot)
      printf(" %2s ", formatted_mark)
    end
    puts "\n\n"
  end

  def horizontal_spots
    rows = []
    @all_spots.each_slice(@size) do |spots_row|
      rows << spots_row
    end
    rows
  end

  def vertical_spots
    columns = []
    (0...@size).each do |column_number|
      columns << @all_spots.select { |spot| spot % @size == column_number }
    end
    columns
  end

  def diagonal_spots
    main_diagonal = []
    anti_diagonal = []
    (0...@size).each do |id|
      main_diagonal << @all_spots[(@size + 1) * id]
      anti_diagonal << @all_spots[(@size - 1) * (id + 1)]
    end

    [main_diagonal, anti_diagonal]
  end
end
