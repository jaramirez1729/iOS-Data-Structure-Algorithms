//
//  Algorithms.swift
//  TreesAndGraphs
//
//  Created by J.A. Ramirez on 12/26/21.
//

// MARK: - Route Between Nodes
/*
 Given a directed graph, design an algorithm to find out whether there is a route between two nodes.
 */
// LEBOWITS
// Approach #1: Get the edges of the starting node. Check those edges if they connect to the end vertex. If yes, return true. If no, queue those children into a soon-to-visit queue and dequeue the starting node in the visited queue. As we pop from the soon-to-visit queue, we check that those children are not in the visited queue otherwise don't add those children to the queue. Keep exploring until we find the ending vertex.
// 
func isRouteBetweenNodes(graph: AdjacencyList<String>, start: Vertex<String>, end: Vertex<String>) -> Bool {
    
    var visited: [Vertex<String>] = []
    var toVisit: [Vertex<String>] = [start]
    
    while !toVisit.isEmpty {
        let currentVertex = toVisit.removeFirst()
        let edges = graph.edges(from: currentVertex)

        for edge in edges {
            // If the destination node has been previously visited, ignore it to avoid cycles.
            guard !visited.contains(edge.destination) else { continue }
            
            // If one of the edge's destination is the target, return immediately.
            if edge.destination == end {
                return true
            }
            
            // If not, queue those destinations.
            toVisit.append(edge.destination)
            // Add the current visited one to the list to not visit again.
            visited.append(currentVertex)
        }
    }
    
    return false
}

// MARK: - Minimal Tree
/*
 Given a sorted (increasing order) array with unique integer elements, write an algo­rithm to create a binary search tree with minimal height.
 */
// Approach #1: Select the middle element of the array to be the root and record its index. Repeat the process for the array slice to the left of the index and to the right if the index. It will keep selecting the middle element of the array and repeat the process until all values have been added.
// Example: [2, 4, 6, 8]
//                                  4                             
//                             2        6
//                                          8
// 
// Example: [2, 4, 6, 8, 10, 11, 20, 400]
//                                                      10  
//                                                6             20
//                                            4      8     11      400
//                                        2
// Divide-and-Conquer on the list, splitting up in the middle each time. This ensures a minimum-height tree because each left and right child are set before proceeding and dividing the list in 2 each time ensures each side of the tree will be balanced.
func createMinimalHeightTree(from list: [Int]) -> TreeNode<Int>? {
    guard !list.isEmpty else { return nil }
    
    // Create the node from the middle element of the list.
    let middleIndex = list.count / 2
    let root = TreeNode<Int>(value: list[middleIndex])
    
    // Repeat but with only the left side of the list.
    root.leftChild = createMinimalHeightTree(from: Array(list[0..<middleIndex]))
    
    // Repeat but with only the right side of the list.
    root.rightChild = createMinimalHeightTree(from: Array(list[(middleIndex + 1)..<list.endIndex]))
    
    return root
}

// MARK: - Check Balanced
/*
 Implement a function to check if a binary tree is balanced. For the purposes of this question, a balanced tree is defined to be a tree such that the heights of the two subtrees of any node never differ by more than one.
 */
// Example:
//                 10  
//           6             20
//       4
// Approach: Compare the left and right depth of each node, recursively if there is a difference greater than 1. Recursion ensures it checks each node's subtrees against each other to ensure no inner subtree differs by more than 1.
func checkBalancedTree(_ root: TreeNode<Int>?) -> Bool {
    guard root != nil else { return true }
    
    // First get the depth of the left and right subtree and compare.
    let leftDepth = Helper().maxDepth(root?.leftChild)
    let rightDepth = Helper().maxDepth(root?.rightChild)
    
    // If the difference is less than 1, then check the root's children, recursively.
    if abs(leftDepth - rightDepth) <= 1 {
        return checkBalancedTree(root?.leftChild) && checkBalancedTree(root?.rightChild)
    }
    
    // Otherwise, just return immediately.
    return false
}
