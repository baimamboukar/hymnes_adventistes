""" 
        ___•••COMPUTE MAX SAVING COST•••___
        Baimam Boukar JJ | baimamboukar@gmail.com 
        
"""

import heapq


def parse_input(input_string):
    """
    Parse the input string into a matrix.

    Args:
    - input_string (str): The formatted input string.

    Returns:
    - list of lists: The adjacency matrix representing the network.
    """
    lines = input_string.strip().split('\n')
    return [[int(cost) if cost and cost != '-' else 0 for cost in line.split(',')] for line in lines]


def maximum_saving(input_network: str) -> int:
    """
    Calculate the maximum saving that can be achieved from a given input network.

    Args:
    - graph (list of lists): The adjacency matrix representing the network.

    Returns:
    - int: The maximum saving.
    """

    # We parse the input string into a matrix, representing the network
    graph = parse_input(input_network)

    # We calculate the total cost of the network
    total_cost = sum(sum(row) for row in graph) // 2

    # We calculate the minimum spanning tree cost BY USING PRIM'S ALGORITHM
    min_spanning_tree_cost = prim(graph)

    # The maximum saving is the difference between the total cost and the MST cost
    max_saving_cost = total_cost - min_spanning_tree_cost
    return max_saving_cost


def prim(graph):
    """
    Implement Prim's algorithm to find the MST(Minimum Spanning Tree) cost.

    Args:
    - graph (list of lists): The adjacency matrix representing the network.

    Returns:
    - int: The cost of the minimum spanning tree.
    """

    n = len(graph)

    # To keep track of visited nodes, we mark all nodes as unvisited
    visited = [False] * n

    # Initialize the heap with the first node (COST, NODE)
    heap = [(0, 0)]

    min_spanning_tree_cost = 0

    # We loop trough the graph while there are still nodes to visit

    while heap:
        cost, node = heapq.heappop(heap)

        # We check if the node has been already visited, and if so, we skip it
        if visited[node]:
            continue
        # Otherwise, we mark it as visited and add the cost to the MST cost
        visited[node] = True
        min_spanning_tree_cost += cost

        # We add all the neighbors of the current node to the heap
        for neighbor, edge_cost in enumerate(graph[node]):
            if not visited[neighbor] and edge_cost > 0:
                heapq.heappush(heap, (edge_cost, neighbor))

    return min_spanning_tree_cost


# Test case network
NETWORK = '''
-,14,10,19,-,-,-
14,-,-,15,18,-,-
10,-,-,26,,29,-
19,15,26,-,16,17,21
-,18,-,16,-,-,9
-,-,29,17,-,-,25
-,-,-,21,9,25,-
'''

max_saving = maximum_saving(NETWORK)
print(max_saving)
