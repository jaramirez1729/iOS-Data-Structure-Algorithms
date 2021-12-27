//
//  Data.swift
//  TreesAndGraphs
//
//  Created by J.A. Ramirez on 12/26/21.
//

struct Helper {
    func maxDepth<T>(_ root: TreeNode<T>?) -> Int {
        var depth: [Int: Int] = [:]
        findMaxDepth(of: root, depth: &depth, count: 1)
        return depth.keys.max() ?? 0
    }
    
    func findMaxDepth<T>(of node: TreeNode<T>?, depth: inout [Int: Int], count: Int) {
        guard node != nil else { return }
        depth[count] = 0
        findMaxDepth(of: node?.leftChild, depth: &depth, count: count + 1)
        findMaxDepth(of: node?.rightChild, depth: &depth, count: count + 1)
    }
}

struct Data {
    /// A -> B, D, C
    /// B -> C, D
    /// C -> E
    /// D -> E
    static func directedGraph() -> AdjacencyList<String> {
        let graph = AdjacencyList<String>()
        
        let a = graph.createVertex(data: "A")
        let b = graph.createVertex(data: "B")
        let c = graph.createVertex(data: "C")
        let d = graph.createVertex(data: "D")
        let e = graph.createVertex(data: "E")
        
        graph.add(.directed, from: a, to: b, weight: 0)
        graph.add(.directed, from: a, to: d, weight: 0)
        graph.add(.directed, from: a, to: c, weight: 0)
        graph.add(.directed, from: b, to: c, weight: 0)
        graph.add(.directed, from: b, to: d, weight: 0)
        graph.add(.directed, from: d, to: e, weight: 0)
        graph.add(.directed, from: c, to: e, weight: 0)
        
        return graph
    }
    
    /// A -> B, D, C
    /// B -> C, D
    /// C -> E, D
    /// D -> E
    /// E -> A
    static func directedGraphWithCycle() -> AdjacencyList<String> {
        let graph = AdjacencyList<String>()
        
        let a = graph.createVertex(data: "A")
        let b = graph.createVertex(data: "B")
        let c = graph.createVertex(data: "C")
        let d = graph.createVertex(data: "D")
        let e = graph.createVertex(data: "E")
        
        graph.add(.directed, from: a, to: b, weight: 0)
        graph.add(.directed, from: a, to: d, weight: 0)
        graph.add(.directed, from: a, to: c, weight: 0)
        graph.add(.directed, from: b, to: c, weight: 0)
        graph.add(.directed, from: b, to: d, weight: 0)
        graph.add(.directed, from: c, to: d, weight: 0)
        graph.add(.directed, from: c, to: e, weight: 0)
        graph.add(.directed, from: d, to: e, weight: 0)
        graph.add(.directed, from: e, to: a, weight: 0)
        
        return graph
    }
}
