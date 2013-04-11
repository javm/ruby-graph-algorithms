require_relative "depth_first_order"

# Step 1: Run depth first search to compute the reverse order
# Step 2: Run depth first search again, considering the vertices
#         in the order given by the first dfs
class StrongComponents
  attr_accessor :connected_components

  def initialize(graph)
    @graph = graph
    @visited = []
    @connected_components = {}
    counter = 0

    nodes_in_reverse_order = DepthFirstOrder.new(graph).reverse_post
    nodes_in_reverse_order.each do |node|
      next if @visited.include?(node)

      dfs(node, counter)
      counter += 1
    end
  end

  private
  def dfs(node, counter)
    @visited << node
    @connected_components[counter] ||= []
    @connected_components[counter] << node

    node.adjacents.each do |adj_node|
      dfs(adj_node, counter) unless @visited.include?(adj_node)
    end
  end
end
