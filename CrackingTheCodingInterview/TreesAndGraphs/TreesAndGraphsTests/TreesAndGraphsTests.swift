//
//  TreesAndGraphsTests.swift
//  TreesAndGraphsTests
//
//  Created by J.A. Ramirez on 12/26/21.
//

import XCTest
@testable import TreesAndGraphs

// MARK: - Route Between Nodes
class IsRouteBetweenNodesTests: XCTestCase {

    func test1() {
        let graph = Data.directedGraph()
        let nodeA = graph.getVertex("A")
        let nodeE = graph.getVertex("E")
        guard let nodeA = nodeA, let nodeE = nodeE else {
            XCTFail()
            return
        }
        let result = isRouteBetweenNodes(graph: graph, start: nodeA, end: nodeE)
        XCTAssertTrue(result)
    }
    
    func test2() {
        let graph = Data.directedGraph()
        let nodeA = graph.getVertex("A")
        let nodeD = graph.getVertex("D")
        guard let nodeA = nodeA, let nodeD = nodeD else {
            XCTFail()
            return
        }
        let result = isRouteBetweenNodes(graph: graph, start: nodeA, end: nodeD)
        XCTAssertTrue(result)
    }
    
    func test3() {
        let graph = Data.directedGraph()
        let nodeB = graph.getVertex("B")
        let nodeE = graph.getVertex("E")
        guard let nodeB = nodeB, let nodeE = nodeE else {
            XCTFail()
            return
        }
        let result = isRouteBetweenNodes(graph: graph, start: nodeB, end: nodeE)
        XCTAssertTrue(result)
    }
    
    func test4() {
        let graph = Data.directedGraph()
        let nodeD = graph.getVertex("D")
        let nodeA = graph.getVertex("A")
        guard let nodeD = nodeD, let nodeA = nodeA else {
            XCTFail()
            return
        }
        let result = isRouteBetweenNodes(graph: graph, start: nodeD, end: nodeA)
        XCTAssertFalse(result)
    }
    
    func test5() {
        let graph = Data.directedGraph()
        let nodeE = graph.getVertex("E")
        let nodeB = graph.getVertex("B")
        guard let nodeE = nodeE, let nodeB = nodeB else {
            XCTFail()
            return
        }
        let result = isRouteBetweenNodes(graph: graph, start: nodeE, end: nodeB)
        XCTAssertFalse(result)
    }
    
    func test6() {
        let graph = Data.directedGraphWithCycle()
        let nodeA = graph.getVertex("A")
        let nodeE = graph.getVertex("E")
        guard let nodeA = nodeA, let nodeE = nodeE else {
            XCTFail()
            return
        }
        let result = isRouteBetweenNodes(graph: graph, start: nodeA, end: nodeE)
        XCTAssertTrue(result)
    }
    
    func test7() {
        let graph = Data.directedGraphWithCycle()
        let nodeE = graph.getVertex("E")
        let nodeB = graph.getVertex("B")
        guard let nodeE = nodeE, let nodeB = nodeB else {
            XCTFail()
            return
        }
        let result = isRouteBetweenNodes(graph: graph, start: nodeE, end: nodeB)
        XCTAssertTrue(result)
    }
}

// MARK: - Minimal Tree
class CreateMinimalHeightTreeTests: XCTestCase {
    func test1() {
        let root = createMinimalHeightTree(from: [2, 4, 6])
        print(root!.description)
        let height = Helper().maxDepth(root)
        XCTAssertEqual(height, 2)
    }
    
    func test2() {
        let root = createMinimalHeightTree(from: [2, 4, 6, 8, 10, 11, 20, 400])
        print(root!.description)
        let height = Helper().maxDepth(root)
        XCTAssertEqual(height, 4)
    }
    
    func test3() {
        let root = createMinimalHeightTree(from: [2, 4, 6, 8])
        print(root!.description)
        let height = Helper().maxDepth(root)
        XCTAssertEqual(height, 3)
    }
    
    func test4() {
        let root = createMinimalHeightTree(from: [2, 4, 6, 8])
        print(root!.description)
        let height = Helper().maxDepth(root)
        XCTAssertEqual(height, 3)
    }
    
    func test5() {
        let root = createMinimalHeightTree(from: Array(1...20))
        print(root!.description)
        let height = Helper().maxDepth(root)
        XCTAssertEqual(height, 5)
    }
}

// MARK: - Check Balanced
class CheckBalancedTreeTests: XCTestCase {
    func test1() {
        //                 10  
        //           6             20
        //       4
        let leftTree = TreeNode<Int>(value: 6, TreeNode<Int>(value: 4), nil)
        let root = TreeNode<Int>(value: 10, leftTree, TreeNode<Int>(value: 20))
        print(root.description)
        let result = checkBalancedTree(root)
        XCTAssertTrue(result)
    }
    
    func test2() {
        //                 10  
        //           6             20
        //       4
        //    1
        let innerLeftTree = TreeNode<Int>(value: 4, TreeNode<Int>(value: 1), nil)
        let leftTree = TreeNode<Int>(value: 6, innerLeftTree, nil)
        let root = TreeNode<Int>(value: 10, leftTree, TreeNode<Int>(value: 20))
        print(root.description)
        let result = checkBalancedTree(root)
        XCTAssertFalse(result)
    }
    
    func test3() {
        //                 10  
        //           6             20
        //       4      5      6        7
        //    1
        let node4 = TreeNode<Int>(value: 4, TreeNode<Int>(value: 1), nil)
        let node6 = TreeNode<Int>(value: 6, node4, TreeNode<Int>(value: 5))
        let node20 = TreeNode<Int>(value: 20, TreeNode<Int>(value: 6), TreeNode<Int>(value: 7))
        let root = TreeNode<Int>(value: 10, node6, node20)
        print(root.description)
        let result = checkBalancedTree(root)
        XCTAssertTrue(result)
    }
    
    func test4() {
        //                 10
        let root = TreeNode<Int>(value: 10)
        print(root.description)
        let result = checkBalancedTree(root)
        XCTAssertTrue(result)
    }
    
    func test5() {
        //                 10
        //             1
        let root = TreeNode<Int>(value: 10, TreeNode<Int>(value: 1))
        print(root.description)
        let result = checkBalancedTree(root)
        XCTAssertTrue(result)
    }
    
    func test6() {
        //                 10
        //             1
        //         3
        let root = TreeNode<Int>(value: 10, TreeNode<Int>(value: 1, TreeNode<Int>(value: 3), nil))
        print(root.description)
        let result = checkBalancedTree(root)
        XCTAssertFalse(result)
    }
    
    func test7() {
        //                 10  
        //           6             20
        //       4      5      6        7
        //    1                             100
        //                                12
        let node4 = TreeNode<Int>(value: 4, TreeNode<Int>(value: 1), nil)
        let node6 = TreeNode<Int>(value: 6, node4, TreeNode<Int>(value: 5))
        let node12 = TreeNode<Int>(value: 12, nil, nil)
        let node7 = TreeNode<Int>(value: 7, nil, TreeNode<Int>(value: 100, node12))
        let node20 = TreeNode<Int>(value: 20, TreeNode<Int>(value: 6), node7)
        let root = TreeNode<Int>(value: 10, node6, node20)
        print(root.description)
        let result = checkBalancedTree(root)
        XCTAssertFalse(result)
    }
    
    func test8() {
        //                 10  
        //           6             20
        //       4             55        7
        //    1                             100
        //                                12
        let node4 = TreeNode<Int>(value: 4, TreeNode<Int>(value: 1), nil)
        let node6 = TreeNode<Int>(value: 6, node4, nil)
        let node12 = TreeNode<Int>(value: 12, nil, nil)
        let node7 = TreeNode<Int>(value: 7, nil, TreeNode<Int>(value: 100, node12))
        let node20 = TreeNode<Int>(value: 20, TreeNode<Int>(value: 55), node7)
        let root = TreeNode<Int>(value: 10, node6, node20)
        print(root.description)
        let result = checkBalancedTree(root)
        XCTAssertFalse(result)
    }
    
    func test9() {
        //                 10  
        //           6             20
        //       4      5               7
        //    1                             100
        //                                12
        let node4 = TreeNode<Int>(value: 4, TreeNode<Int>(value: 1), nil)
        let node6 = TreeNode<Int>(value: 6, node4, TreeNode<Int>(value: 5))
        let node12 = TreeNode<Int>(value: 12, nil, nil)
        let node7 = TreeNode<Int>(value: 7, nil, TreeNode<Int>(value: 100, node12))
        let node20 = TreeNode<Int>(value: 20, nil, node7)
        let root = TreeNode<Int>(value: 10, node6, node20)
        print(root.description)
        let result = checkBalancedTree(root)
        XCTAssertFalse(result)
    }
    
    func test10() {
        //                 10  
        //           6             20
        //       4      5      88        7
        let node4 = TreeNode<Int>(value: 4)
        let node6 = TreeNode<Int>(value: 6, node4, TreeNode<Int>(value: 5))
        let node20 = TreeNode<Int>(value: 20, TreeNode<Int>(value: 88), TreeNode<Int>(value: 7))
        let root = TreeNode<Int>(value: 10, node6, node20)
        print(root.description)
        let result = checkBalancedTree(root)
        XCTAssertTrue(result)
    }
    
    func test11() {
        //                 10  
        //           6             20
        //       4                       7
        let node4 = TreeNode<Int>(value: 4)
        let node6 = TreeNode<Int>(value: 6, node4, nil)
        let node20 = TreeNode<Int>(value: 20, nil, TreeNode<Int>(value: 7))
        let root = TreeNode<Int>(value: 10, node6, node20)
        print(root.description)
        let result = checkBalancedTree(root)
        XCTAssertTrue(result)
    }
}
