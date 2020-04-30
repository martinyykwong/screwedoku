require_relative "board"

# People write terrible method names in real life.
# On the job, it is your job to figure out how the methods work and then name them better.
# Do this now.

class SudokuGame
  def self.from_file(filename)
    board = Board.from_file(filename)
    self.new(board)
  end

  def initialize(board)
    @board = board
  end

  def retrieve_pos_from_ui
    position = nil
    until position && valid_position?(position)
      puts "Please enter a position on the board (e.g., '3,4')"
      print "> "

      begin
        position = parse_position(gets.chomp)
      rescue
        puts "Invalid position entered (did you use a comma?)"
        puts ""

        position = nil
      end
    end
    position
  end

  def retrieve_value_from_ui
    value = nil
    until value && valid_value?(value)
      puts "Please enter a value between 1 and 9 (0 to clear the tile)"
      print "> "
      value = parse_value(gets.chomp)
    end
    value
  end

  def parse_position(string)
    string.split(",").map { |char| Integer(char) }
  end

  def parse_value(string)
    Integer(string)
  end

  def get_player_input
    set_value(retrieve_pos_from_ui, retrieve_value_from_ui)
  end

  def set_value(p, v)
    board[p] = v
  end

  def run
    get_player_input until game_won?
    puts "Congratulations, you win!"
  end

  def game_won?
    board.completed?
  end

  def valid_position?(pos)
    pos.is_a?(Array) &&
      pos.length == 2 &&
      pos.all? { |x| x.between?(0, board.size - 1) }
  end

  def valid_value?(val)
    val.is_a?(Integer) &&
      val.between?(0, 9)
  end

  private
  attr_reader :board
end


game = SudokuGame.from_file("puzzles/sudoku1.txt")
game.run
