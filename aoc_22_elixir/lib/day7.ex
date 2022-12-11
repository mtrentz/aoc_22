defmodule DaySeven do
  def learning do
    # Import the digraph module from Erlang
    graph = :digraph.new()

    # Create nodes A, B, C, D ,E
    a = :digraph.add_vertex(graph, "A")
    b = :digraph.add_vertex(graph, "B")
    c = :digraph.add_vertex(graph, "C")
    d = :digraph.add_vertex(graph, "D")
    e = :digraph.add_vertex(graph, "E")

    # "A" has two children: "B" and "C"
    # "C" has no children
    # "B" has two children: "D" and "E"
    :digraph.add_edge(graph, a, b)
    :digraph.add_edge(graph, a, c)
    :digraph.add_edge(graph, b, d)
    :digraph.add_edge(graph, b, e)

    # # Add "A" as root, and "B" and "C" as children
    # graph = :digraph.add_edge(graph, v1, v2)
    # graph = :digraph.add_edge(graph, v1, v3)

    # # IO.inspect(:digraph.vertices(graph))
    # IO.inspect(:digraph_utils.is_tree(graph))

    # # Traverse the tree and print the nodes
    # IO.inspect(:digraph_utils.postorder(graph))

    IO.inspect(graph)

    # IO.inspect(:digraph.info(graph))

    IO.inspect(:digraph.vertices(graph))

    # Print childrens of "B"
    # IO.inspect(:digraph.children(graph, b))
    IO.inspect(:digraph.out_neighbours(graph, b))

    IO.puts("Is tree? #{:digraph_utils.is_tree(graph)}")

    IO.inspect(:digraph_utils.postorder(graph))

    # Print
    # IO.inspect(graph)
  end

  def learning_2 do
    # Aqui vou fazer os nodes serem um map
  end
end

DaySeven.learning()
#   DaySeven.solve_pt2()
