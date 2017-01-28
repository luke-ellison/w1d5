require_relative 'tic_tac_toe'

class TicTacToeNode
  attr_reader :board, :next_mover_mark, :prev_move_pos

  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @next_mover_mark = next_mover_mark
    @prev_move_pos = prev_move_pos
  end

  def losing_node?(evaluator)
    return @board.winner == (evaluator == :x ? :o : :x) if @board.over?

    if @next_mover_mark == evaluator
      children.all? { |child| child.losing_node?(evaluator) }
    else
      children.any? { |child| child.losing_node?(evaluator) }
    end
  end

  def winning_node?(evaluator)
    return @board.winner == evaluator if @board.over?

    if @next_mover_mark == evaluator
      children.any? { |child| child.winning_node?(evaluator) }
    else
      children.all? { |child| child.winning_node?(evaluator) }
    end
  end

  # This method generates an array of all moves that can be made after
  # the current move.
  def children
    next_nodes = []

    empty_squares.each do |pos|
      b = @board.dup
      b[pos] = @next_mover_mark
      new_mover_mark = (@next_mover_mark == :x ? :o : :x)

      new_node = TicTacToeNode.new(b, new_mover_mark, pos)
      next_nodes << new_node
    end

    next_nodes
  end

  def empty_squares
    empties = []

    (0...3).each do |row|
      (0...3).each do |col|
        empties << [row, col] if @board.empty?([row, col])
      end
    end

    empties
  end
end
