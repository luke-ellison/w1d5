require '../skeleton/lib/00_tree_node.rb'

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

    curr_node = @visited_positions.bfs(end_pos)
    while curr_node.parent
      path << curr_node.value
      curr_node = curr_node.parent
    end

    [@starting_pos] + path.reverse
  end

  def build_move_tree
    @visited_positions = PolyTreeNode.new(@starting_pos)
    @num_visited = 1

    curr_nodes = [@visited_positions]
    until @num_visited == BOARD_SIDE_LENGTH ** 2
      # curr_node = curr_nodes.unshift
      # curr_nodes.concat(new_move_positions(curr_node))
      curr_nodes.each do |node|
        new_move_positions(node)
      end
      new_nodes = []
      curr_nodes.each { |node| new_nodes.concat(node.children) }
      curr_nodes = new_nodes
    end

    @visited_positions
  end

  def new_move_positions(node)
    new_nodes = []

    KnightPathFinder.valid_moves(node.value).each do |pos|
      unless @visited_positions.bfs(pos)
        baby_node = PolyTreeNode.new(pos)
        node.add_child(baby_node)
        new_nodes << baby_node
      end
    end
    @num_visited += new_nodes.length

    # p new_nodes
    new_nodes
  end

end

if __FILE__ == $0
  k = KnightPathFinder.new([0, 0])
  k.build_move_tree
  p k.find_path([6, 2])
end
