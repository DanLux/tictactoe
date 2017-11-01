
module InputReader
  def self.read_integer
    input = gets.chomp
    until input.is_i? && (yield input.to_i if block_given? || true)
      puts 'Invalid input. Try again:'
      input = gets.chomp
    end
    input.to_i
  end
end
