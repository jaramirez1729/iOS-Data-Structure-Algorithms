//
//  Graph.swift
//  GraphAlgorithms
//
//  Created by Jozeee on 1/28/20.
//  Copyright © 2020 AdaloveSoftware. All rights reserved.
//

import Foundation

// MARK: - Graphable
protocol RWGraphable {
    // Allows it to be generic so it can hold any type.
    associatedtype Element: Hashable
    // Allows custom printing to console.
    var description: CustomStringConvertible { get }
    
    func createVertex(data: Element) -> RWVertex<Element>
    func add(_ type: RWEdgeType, from source: RWVertex<Element>, to destination: RWVertex<Element>, weight: Double?)
    func weight(from source: RWVertex<Element>, to destination: RWVertex<Element>) -> Double?
    func edges(from source: RWVertex<Element>) -> [SWEdge<Element>]?
}

// MARK: - Adjacency List
class RWAdjacencyList<T: Hashable> {
    public var adjacencyDict: [RWVertex<T>: [SWEdge<T>]] = [:]
    
    init() {}
    
    fileprivate func addDirectedEdge(from source: RWVertex<T>, to destination: RWVertex<T>, weight: Double?) {
      let edge = SWEdge(source: source, destination: destination, weight: weight)
      adjacencyDict[source]?.append(edge)
    }
    
    fileprivate func addUndirectedEdge(vertices: (RWVertex<T>, RWVertex<T>), weight: Double?) {
      let (source, destination) = vertices
      addDirectedEdge(from: source, to: destination, weight: weight)
      addDirectedEdge(from: destination, to: source, weight: weight)
    }
}

extension RWAdjacencyList: RWGraphable {
    public typealias Element = T
    
    public var description: CustomStringConvertible {
        var result = ""
        for (vertex, edges) in adjacencyDict {
            var edgeString = ""
            for (index, edge) in edges.enumerated() {
                if index != edges.count - 1 {
                    edgeString.append("\(edge.destination), ")
                } else {
                    edgeString.append("\(edge.destination)")
                }
            }
            result.append("\(vertex) ---> [ \(edgeString) ] \n ")
        }
        return result
    }
    
    func createVertex(data: T) -> RWVertex<T> {
        let vertex = RWVertex(data: data)
        if adjacencyDict[vertex] == nil {
            adjacencyDict[vertex] = []
        }
        return vertex
    }
    
    func add(_ type: RWEdgeType, from source: RWVertex<T>, to destination: RWVertex<T>, weight: Double?) {
        switch type {
        case .directed: addDirectedEdge(from: source, to: destination, weight: weight)
        case .undirected: addUndirectedEdge(vertices: (source, destination), weight: weight)
        }
    }
    
    func weight(from source: RWVertex<T>, to destination: RWVertex<T>) -> Double? {
        guard let edges = adjacencyDict[source] else {
            return nil
        }
        
        for edge in edges {
            if edge.destination == destination {
                return edge.weight
            }
        }
        
        return nil
    }
    
    func edges(from source: RWVertex<T>) -> [SWEdge<T>]? {
        return adjacencyDict[source]
    }
}

// MARK: - Vertex
/// Represents a node in a graph. It must comform to the hashable protocol in order to be
/// stored as a key in a dictionary.
public class RWVertex<T: Hashable> {
    var data: T
    
    init(data: T) {
        self.data = data
    }
}

extension RWVertex: Hashable {
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(data.hashValue)
    }
    
    // Required because Hashable inherits from Equatable.
    public static func == (lhs: RWVertex<T>, rhs: RWVertex<T>) -> Bool {
        return lhs.data == rhs.data
    }
}

extension RWVertex: CustomStringConvertible {
    public var description: String {
        return "\(data)"
    }
}

// MARK: - Edge
public enum RWEdgeType {
    case directed, undirected
}

public class SWEdge<T: Hashable> {
    public var source: RWVertex<T>
    public var destination: RWVertex<T>
    public let weight: Double?
    
    init(source: RWVertex<T>, destination: RWVertex<T>, weight: Double?) {
        self.source = source
        self.destination = destination
        self.weight = weight
    }
}

extension SWEdge: Hashable {
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine("\(source)\(destination)\(weight ?? 0)".hashValue)
    }
    
    public static func == (lhs: SWEdge<T>, rhs: SWEdge<T>) -> Bool {
        return lhs.source == rhs.source && lhs.destination == rhs.destination && lhs.weight == rhs.weight
    }
}
