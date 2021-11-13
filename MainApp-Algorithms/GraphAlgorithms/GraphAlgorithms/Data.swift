//
//  SampleData.swift
//  GraphAlgorithms
//
//  Created by Jozeee on 1/31/20.
//  Copyright © 2020 AdaloveSoftware. All rights reserved.
//

import Foundation

class Data {
    // MARK: - Undirected Graph
    /*                      1
                           / \
                          2   3
                          | \ |
                          4   5
                           \ /
                            6
     */
    var undirectedGraph: Graph {
        let graph = Graph(values: [1, 2, 3, 4, 5, 6])
        graph.addEdge(source: graph.nodes[0], destination: graph.nodes[1])
        graph.addEdge(source: graph.nodes[0], destination: graph.nodes[2])
        graph.addEdge(source: graph.nodes[1], destination: graph.nodes[3])
        graph.addEdge(source: graph.nodes[1], destination: graph.nodes[4])
        graph.addEdge(source: graph.nodes[2], destination: graph.nodes[4])
        graph.addEdge(source: graph.nodes[3], destination: graph.nodes[5])
        graph.addEdge(source: graph.nodes[4], destination: graph.nodes[5])
        return graph
    }
    
    // MARK: - Undirected Weighted Graph
    /*                      1
                           / \       10, 12
                          2   3
                          | \ |      20, 1, 5
                          4   5
                           \ /       2, 1
                            6
     */
    var undirectedWeightedGraph: Graph {
        let graph = Graph(values: [1, 2, 3, 4, 5, 6])
        graph.addEdge(source: graph.nodes[0], destination: graph.nodes[1], weight: 10)
        graph.addEdge(source: graph.nodes[0], destination: graph.nodes[2], weight: 12)
        graph.addEdge(source: graph.nodes[1], destination: graph.nodes[3], weight: 20)
        graph.addEdge(source: graph.nodes[1], destination: graph.nodes[4], weight: 1)
        graph.addEdge(source: graph.nodes[2], destination: graph.nodes[4], weight: 5)
        graph.addEdge(source: graph.nodes[3], destination: graph.nodes[5], weight: 2)
        graph.addEdge(source: graph.nodes[4], destination: graph.nodes[5], weight: 1)
        return graph
    }

    // MARK: - Directed Graph
    /*                  1 > 2 > 5 <
                        ^   v   ^
                          3     4
     */
    var directedGraph: Graph {
        let graph = Graph(values: [1, 2, 3, 4, 5])
        graph.isDirected = true
        graph.addEdge(source: graph.nodes[0], destination: graph.nodes[1])
        graph.addEdge(source: graph.nodes[1], destination: graph.nodes[2])
        graph.addEdge(source: graph.nodes[2], destination: graph.nodes[0])
        graph.addEdge(source: graph.nodes[1], destination: graph.nodes[4])
        graph.addEdge(source: graph.nodes[4], destination: graph.nodes[4])
        graph.addEdge(source: graph.nodes[3], destination: graph.nodes[4])
        return graph
    }
    
    // MARK: - Small Graph
    /*                      0
                          /   \
                         2 --- 1
     */
    var smallGraph: Graph {
        let graph = Graph(values: [0, 1, 2])
        graph.addEdge(source: graph.nodes[0], destination: graph.nodes[1])
        graph.addEdge(source: graph.nodes[1], destination: graph.nodes[2])
        graph.addEdge(source: graph.nodes[2], destination: graph.nodes[0])
        return graph
    }

    // MARK: - Tree Graph
    /*                       1
                    2        3       10
                  4        6   7
     */
    var treeGraph: Graph {
        let graph = Graph(values: [1, 2, 3, 4, 6, 7, 10])
        graph.isDirected = true
        graph.addEdge(source: graph.nodes[0], destination: graph.nodes[1])
        graph.addEdge(source: graph.nodes[0], destination: graph.nodes[2])
        graph.addEdge(source: graph.nodes[0], destination: graph.nodes[6])
        graph.addEdge(source: graph.nodes[1], destination: graph.nodes[3])
        graph.addEdge(source: graph.nodes[2], destination: graph.nodes[4])
        graph.addEdge(source: graph.nodes[2], destination: graph.nodes[5])
        return graph
    }
    
    // MARK: - Tree Graph
    /*                      1
                           / \
                          2   3
                          |   |
                          4   5
     */
    var tree2Graph: Graph {
        let graph = Graph(values: [1, 2, 3, 4, 5])
        graph.isDirected = true
        graph.addEdge(source: graph.nodes[0], destination: graph.nodes[1])
        graph.addEdge(source: graph.nodes[0], destination: graph.nodes[2])
        graph.addEdge(source: graph.nodes[1], destination: graph.nodes[3])
        graph.addEdge(source: graph.nodes[2], destination: graph.nodes[4])
        return graph
    }
}
