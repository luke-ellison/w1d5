require '../poly-tree-node/lib/00_tree_node.rb'

class KnightPathFinder

  DELTAS = [
    [-2, -1],
    [-2, 1],
    [-1, -2],
    [-1, 2],
    [1, -2],
    [1, 2],
    [2, -1],
    [2, 1]
  ]
  BOARD_SIDE_LENGTH = 8

  def self.valid_moves(pos)
    row, col = pos
    valid_moves = []

    DELTAS.each do |d|
      if (0...8).include?(row + d[0]) && (0...8).include?(col + d[1])
        valid_moves << [row + d[0], col + d[1]]
      end
    end

    valid_moves
  end

  def initialize(pos)
    @starting_pos = pos
  end

  def find_path(end_pos)
    path = []

    curr_node = @visited_positions[0].bfs(end_pos)
    while curr_node.parent
      path << curr_node.value
      curr_node = curr_node.parent
    end

    ([@starting_pos] + path.reverse).map { |pos| pos.to_s }.join(" => ")
  end

  def build_move_tree
    @visited_positions = [PolyTreeNode.new(@starting_pos)]
    i = 0

    until i == BOARD_SIDE_LENGTH ** 2 || i == @visited_positions.length
      curr_node = @visited_positions[i]
      @visited_positions.concat(new_move_positions(curr_node))
      i += 1
    end

    @visited_positions
  end

  def new_move_positions(node)
    new_nodes = []

    KnightPathFinder.valid_moves(node.value).each do |pos|
      unless @visited_positions[0].bfs(pos)
        baby_node = PolyTreeNode.new(pos)
        node.add_child(baby_node)
        new_nodes << baby_node
      end
    end

    new_nodes
  end

end

if __FILE__ == $0
  k = KnightPathFinder.new([0, 0])
  k.build_move_tree
  puts k.find_path([6, 2])
end
