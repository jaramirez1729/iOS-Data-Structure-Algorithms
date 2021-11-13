//
//  main.swift
//  GraphAlgorithms
//
//  Created by Jozeee on 1/27/20.
//  Copyright © 2020 AdaloveSoftware. All rights reserved.
//

/*
 Graph Questions
 Implement a breadth-first search.
 Implement a depth-first first.
 Check if a graph is a tree or not.
 Count number of edges in a graph.
 Find the shortest path between 2 vertices.
 */


// MARK: -
// Implement a breadth-first search. Since we care about order, we will use a queue to ensure that the
// neighbors of the visited node remain in order as it traverses inside.
// LISTEN; EXAMPLE; BRUTE; OPTIMIZE (BUD); WALKTHROUGH;
func breadthFirstSearch(_ graph: Graph) {
    guard graph.nodes.count > 0 else { return }
    let queue: Queue<Vertex> = Queue<Vertex>()
    
    // Add the first node to the queue
    queue.enqueue(graph.nodes[0])
    graph.nodes[0].isVisited = true
    
    while !queue.isEmpty {
        if let node = queue.dequeue() {
            print(node)
            for edge in node.edges where !edge.destination.isVisited {
                // Mark the nodes as visited when adding them to the queue to prevent
                // duplicates from being added.
                edge.destination.isVisited = true
                queue.enqueue(edge.destination)
            }
        }
    }
}


// MARK: -
// Implement a depth-first search. A stack is used for this to ensure that closeby neighbors have to wait
// until they are printed in order to wait until the traversal is done first.
func depthFirstSearch(_ graph: Graph) {
    guard graph.nodes.count > 0 else { return }
    let stack: Stack<Vertex> = Stack<Vertex>()
    
    stack.push(graph.nodes[0])
    graph.nodes[0].isVisited = true
    
    while !stack.isEmpty {
        if let node = stack.pop() {
            print(node)
            for edge in node.edges where !edge.destination.isVisited {
                edge.destination.isVisited = true
                stack.push(edge.destination)
            }
        }
    }
}


// MARK: -
// Check if a graph is a tree or not.
// A tree cannot have any cycles. A tree has n-1 edges.
// BRUTE: We can check by counting the number of edges and comparing to n - 1.
// This only works if the graph that is actually a tree has isDirected set to true because
// it doesn't have duplicate edges. Unline actual trees that have no direction, the graph data
// structure does not use a single edge to represent no direction.
func isTree(_ graph: Graph) -> Bool {
    guard graph.nodes.count > 0 else { return false }
    var edges: [Edge] = []
    let queue: Queue<Vertex> = Queue<Vertex>()
    
    queue.enqueue(graph.nodes[0])
    graph.nodes[0].isVisited = true
    
    while !queue.isEmpty {
        if let node = queue.dequeue() {
            print(node)
            for edge in node.edges {
                if !edge.destination.isVisited {
                    edge.destination.isVisited = true
                    queue.enqueue(edge.destination)
                }
                if !edges.contains(edge) {
                    edges.append(edge)
                }
            }
        }
    }
    
    return edges.count == graph.nodes.count - 1
}


// MARK: -
// Count number of edges in a graph.
// BRUTE: Since Graph data structure creates 2 edges to represent bidirectional, then we only need
// to divide by half to get the actual count of edges. Use a breadth-first search for traversal.
func numberOfEdgesBrute(in graph: Graph) -> Int {
    guard graph.nodes.count > 0 else { return 0 }
    var edges: [Edge] = []
    let queue: Queue<Vertex> = Queue<Vertex>()
    
    queue.enqueue(graph.nodes[0])
    graph.nodes[0].isVisited = true
    
    while !queue.isEmpty {
        if let node = queue.dequeue() {
            for edge in node.edges {
                if !edge.destination.isVisited {
                    edge.destination.isVisited = true
                    queue.enqueue(edge.destination)
                }
                if !edges.contains(edge) {
                    edges.append(edge)
                }
            }
        }
    }
    
    return (edges.count / (graph.isDirected ? 1 : 2))
}


// MARK: -
// Find the shortest path between 2 vertices.
