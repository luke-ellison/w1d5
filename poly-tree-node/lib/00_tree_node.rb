class PolyTreeNode

  attr_reader :parent, :children, :value

  def initialize(value, parent = nil, children = [])
    @value = value
    @parent = parent
    @children = children
  end

  def parent=(node)
    @parent.children.delete(self) if @parent
    @parent = node
    node.children << self if node && !node.children.include?(self)
  end

  def add_child(child_node)
    child_node.parent = self
  end

  def remove_child(child_node)
    raise "child_node is not a child" unless child_node.parent == self
    child_node.parent = nil
  end

  def dfs(target_value)
    return self if target_value == @value

    @children.each do |child|
      child_dfs = child.dfs(target_value)
      return child_dfs if child_dfs
    end

    nil
  end

  def bfs(target_value)
    queue = [self]
    until queue == []
      curr_node = queue.shift
      return curr_node if curr_node.value == target_value
      curr_node.children.each { |child| queue << child }
    end

    nil
  end

end

if __FILE__ == $0
  n1 = PolyTreeNode.new("root")
  n2 = PolyTreeNode.new("child1")
  n3 = PolyTreeNode.new("child2")
  n1.add_child(n2)
  n1.add_child(n3)
  p n1.dfs("child1")
end
