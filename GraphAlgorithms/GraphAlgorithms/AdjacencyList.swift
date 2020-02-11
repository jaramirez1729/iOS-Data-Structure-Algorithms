//
//  AdjacencyList.swift
//  GraphAlgorithms
//
//  Created by Jozeee on 1/29/20.
//  Copyright © 2020 AdaloveSoftware. All rights reserved.
//

import Foundation

class Graph {
    private(set) var nodes: [Vertex] = []
    
    /// Determines if the edges only go in one direction. False by default.
    var isDirected: Bool = false
    
    init() {}
    
    /// Creates a new vertex for every value in the array.
    init(values: [Int]) {
        for val in values {
            let vertex = Vertex(val: val)
            nodes.append(vertex)
        }
    }
    
    func addVertex(val: Int) {
        let newVertex = Vertex(val: val)
        nodes.append(newVertex)
    }
    
    func addEdge(source: Vertex, destination: Vertex, weight: Int = 0) {
        // Create an edge from the source and destination and then add that edge as part
        // of the source. This means that the source points to the destination.
        let newEdge = Edge(source: source, destination: destination, weight: weight)
        source.edges.append(newEdge)
        
        if !isDirected {
            // If it's not directed, that means it goes both ways. Create a new edge that shows it
            // points back to the source too and add it to the destination.
            let revEdge = Edge(source: destination, destination: source, weight: weight)
            destination.edges.append(revEdge)
        }
    }
}

extension Graph: CustomStringConvertible {
    var description: String {
        var str: String = ""
        let arrow: String = isDirected ? "->" : "<->"
        
        for node in nodes {
            str += "\(node.val) \(arrow) "
            for i in 0..<node.edges.count {
                str += "\(node.edges[i].destination.val)" + "\(i == node.edges.count - 1 ? "" : ", ")"
            }
            str += "\n"
        }
        
        return str
    }
}

class Vertex {
    var val: Int = 0
    var edges: [Edge] = []
    /// Used to check if the current vertex was visited or not when traversing.
    var isVisited: Bool = false
    
    init(val: Int) {
        self.val = val
    }
}

extension Vertex: CustomStringConvertible {
    var description: String {
        return "\(val)"
    }
}

extension Vertex: Equatable {
    static func == (lhs: Vertex, rhs: Vertex) -> Bool {
        return lhs.val == rhs.val && lhs.edges == rhs.edges && lhs.isVisited == rhs.isVisited
    }
}

class Edge {
    var source: Vertex
    var destination: Vertex
    var weight: Int = 0
    
    init(source: Vertex, destination: Vertex, weight: Int = 0) {
        self.source = source
        self.destination = destination
        self.weight = weight
    }
}

extension Edge: Equatable {
    static func == (lhs: Edge, rhs: Edge) -> Bool {
        return lhs.source == rhs.source && lhs.destination == rhs.destination && lhs.weight == rhs.weight
    }
}
