require_relative "./piece.rb"

class Pawn < Piece
  def initialize(colour, board, pos)
    super(colour, board, pos)
  end

  def moves
    forward_steps + side_attacks
  end

  def symbol
    return "\u2659"
  end

  def move_dirs
    return [forward_direction, 0]
  end

  private
  def at_start_row
    return true if @pos[0] == 1 && @colour == :black
    return true if @pos[0] == 6 && @colour == :white
    return false
  end

  def forward_direction
    return -1 if @colour == :white
    return 1 if @colour == :black
  end

  def forward_steps
    moves = []
      moves << [@pos[0] + forward_direction, @pos[1]] if @board.grid[@pos[0] + forward_direction][@pos[1]] == NullPiece.instance

      at_the_end_position = @board.grid[@pos[0] + forward_direction + forward_direction][pos[1]]
      if at_start_row && at_the_end_position == NullPiece.instance
        moves << [@pos[0] + forward_direction + forward_direction, @pos[1]] if at_start_row
      end

    moves
  end

  def side_attacks
    moves = []
      first_diagonal = @board.grid[@pos[0] + forward_direction][@pos[1] + forward_direction]
      second_diagonal = @board.grid[@pos[0] + forward_direction][@pos[1] - forward_direction]

      if first_diagonal != NullPiece.instance && first_diagonal != nil
        if first_diagonal.colour != @colour
          moves << [@pos[0] + forward_direction, @pos[1] + forward_direction]
        end
      end

      if second_diagonal != NullPiece.instance && second_diagonal != nil
        if second_diagonal.colour != @colour
          moves << [@pos[0] + forward_direction, @pos[1] - forward_direction]
        end
      end

    moves
  end
end