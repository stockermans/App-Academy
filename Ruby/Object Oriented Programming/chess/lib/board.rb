require_relative "./pieces/piece.rb"
require_relative "./pieces/pawn.rb"
require_relative "./pieces/knight.rb"
require_relative "./pieces/king.rb"
require_relative "./pieces/rook.rb"
require_relative "./pieces/bishop.rb"
require_relative "./pieces/queen.rb"
require_relative "./pieces/null_piece.rb"
require_relative "./display.rb"

# Handles board logic, making pieces, moving pieces, and setting up the chess board
class Board
  attr_reader :grid

  def initialize
    @grid = Array.new(8){ Array.new(8) }
    setup_chess_board
  end

  def dup
    new_board = Board.new
    (0..7).each do |i|
      (0..7).each do |k|
        if @grid[i][k].class == NullPiece
          new_board.grid[i][k] = NullPiece.instance
        else
          this_item = @grid[i][k]
          new_board.grid[i][k] = this_item.class.new(this_item.colour, new_board, this_item.pos)
        end
      end
    end
    new_board
  end

  def checkmate?(colour)
    @grid.each do |sub_array|
      sub_array.each do |ele|
        if ele.class != NullPiece && ele != nil && ele.colour == colour
          #p "my colour piece, checking if " + colour.to_s + " is in checkmate"
          all_moves = ele.valid_moves
          all_moves.each do |check_move|
            if is_valid_move(check_move)
              if !ele.move_into_check(check_move)
                p " Was found NOT IN CHECK!"
                was_found = false
              end
            end
          end
        end
      end
    end
    return true
  end

  def in_check?(colour)
    king_location = find_king(colour)
    p "Found king at: " + king_location.to_s
    @grid.each do |sub_array|
      sub_array.each do |ele|
        if ele.class != NullPiece && ele.colour == (colour == :black ? :white : :black)
          if ele.valid_moves.include?(king_location)
            return true
          end
        end
      end
    end
    return false
  end

  def find_king(colour)
    @grid.each do |sub_array|
      sub_array.each do |ele|
        if ele.class == King && ele.colour == colour
          return ele.pos
        end
      end
    end
  end

  def [](pos)
    @grid[pos[0]][pos[1]]
  end

  def []=(pos, result)
    @grid[pos[0]][pos[1]] = result
  end

  def is_valid_move(pos)
    return false if pos[0] < 0 || pos[0] > 7
    return false if pos[1] < 0 || pos[1] > 7
    true
  end

  def ends_on_own_piece(start_pos, end_pos)
    return true if self.[](end_pos) != NullPiece.instance && self.[](end_pos).colour == self.[](start_pos).colour
    return false
  end

  def move_piece(start_pos, end_pos)
    raise "This start position is off the board." if !is_valid_move(start_pos)
    raise "This end position is off the board" if !is_valid_move(end_pos)
    raise "There is no piece at starting position: #{start_pos}" if self.[](start_pos) == NullPiece.instance
    raise "This end position lands on your own piece" if ends_on_own_piece(start_pos, end_pos)
    piece_to_move = self.[](start_pos)

    if piece_to_move.valid_moves.include?(end_pos)
      p "Moving: " + piece_to_move.symbol + " to: " + end_pos.to_s
      self[end_pos] = piece_to_move
      piece_to_move.pos = end_pos
      self[start_pos] = NullPiece.instance
    else
      p "Didn't find the move"
    end
  end

  def setup_chess_board
    8.times do |black_index|
      if black_index == 1 || black_index == 6
        @grid[0][black_index] = Knight.new(:black, self, [0, black_index])
      elsif black_index == 4
        @grid[0][black_index] = King.new(:black, self, [0, black_index])
      elsif black_index == 0 || black_index == 7
        @grid[0][black_index] = Rook.new(:black, self, [0, black_index])
      elsif black_index == 2 || black_index == 5
        @grid[0][black_index] = Bishop.new(:black, self, [0, black_index])
      elsif black_index == 3
        @grid[0][black_index] = Queen.new(:black, self, [0, black_index])
      end
      @grid[1][black_index] = Pawn.new(:black, self, [1, black_index])
    end
    8.times do |null_piece_index|
      (2..5).each do |i|
        @grid[i][null_piece_index] = NullPiece.instance
      end
    end
    8.times do |white_index|
      @grid[6][white_index] = Pawn.new(:white, self, [6, white_index])
      if white_index == 1 || white_index == 6
        @grid[7][white_index] = Knight.new(:white, self, [7, white_index])
      elsif white_index == 4
        @grid[7][white_index] = King.new(:white, self, [7, white_index])
      elsif white_index == 0 || white_index == 7
        @grid[7][white_index] = Rook.new(:white, self, [7, white_index])
      elsif white_index == 2 || white_index == 5
        @grid[7][white_index] = Bishop.new(:white, self, [7, white_index])
      elsif white_index == 3
        @grid[7][white_index] = Queen.new(:white, self, [7, white_index])
      end
    end
  end
end

board = Board.new
board.move_piece([6,5], [5,5])
board.move_piece([1,4], [3,4])
board.move_piece([6,6], [4,6])
board.move_piece([0,3], [4,7])

display = Display.new(board)
