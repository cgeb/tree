class Tree
  attr_accessor :children, :node_name

  def initialize(tree)
    @node_name = tree.keys[0]
    @children = []
    tree[@node_name].each do |x|
      create_children(x)
    end
  end
  
  def visit_all(&block)
    visit &block
    children.each { |c| c.visit_all &block }
  end
  
  def visit(&block)
    block.call self
  end

  private

  def create_children(tree)
    new_hash = {tree[0] => tree[1]}
    @children << Tree.new(new_hash) unless tree.empty?
  end
end


ruby_tree = Tree.new({"grandpa" => {"dad" => {"child1" => {}, "child2" => {}}, "uncle" => {"child3" => {}, "child4" => {}}}})
ruby_tree.visit_all { |node| puts node.node_name }
