//
//  TreesAlgorithmsTests.swift
//  TreesAlgorithmsTests
//
//  Created by J.A. Ramirez on 12/9/21.
//

import XCTest
@testable import TreesAlgorithms

// MARK: - Maximum Depth of Binary Tree
class MaxDepthTests: XCTestCase {
    
    func test1() {
        let root = TreeNode(3, TreeNode(9), TreeNode(20, TreeNode(15), TreeNode(7)))
        let result = maxDepth(root)
        XCTAssertEqual(result, 3)
    }
    
    func test2() {
        let root = TreeNode(1, TreeNode(2), TreeNode(3))
        let result = maxDepth(root)
        XCTAssertEqual(result, 2)
    }
    
    func test3() {
        let root = TreeNode(1)
        let result = maxDepth(root)
        XCTAssertEqual(result, 1)
    }
    
    func test4() {
        let result = maxDepth(nil)
        XCTAssertEqual(result, 0)
    }
    
    func test5() {
        let root = TreeNode(3, TreeNode(9), TreeNode(20, TreeNode(15), TreeNode(7, nil, TreeNode(5))))
        let result = maxDepth(root)
        XCTAssertEqual(result, 4)
    }
}

// MARK: - Validate Binary Search Tree
class IsValidBSTTests: XCTestCase {
    func test1() {
        let root = TreeNode(2, TreeNode(1), TreeNode(3))
        let result = isValidBST(root)
        XCTAssertTrue(result)
    }
    
    func test2() {
        let root = TreeNode(5, TreeNode(1), TreeNode(3))
        let result = isValidBST(root)
        XCTAssertFalse(result)
    }
    
    func test3() {
        let leftTree = TreeNode(8, TreeNode(7), TreeNode(9))
        let rightTree = TreeNode(15, TreeNode(11), TreeNode(16))
        let root = TreeNode(10)
        root.left = leftTree
        root.right = rightTree
        let result = isValidBST(root)
        XCTAssertTrue(result)
    }
    
    func test4() {
        let rightTree = TreeNode(6, TreeNode(3), TreeNode(7))
        let root = TreeNode(5, TreeNode(4), rightTree)
        root.right = rightTree
        let result = isValidBST(root)
        XCTAssertFalse(result)
    }   
    
    func test5() {
        let root = TreeNode(2, TreeNode(2), TreeNode(2))
        let result = isValidBST(root)
        XCTAssertFalse(result)
    }
    
    func test6() {
        let root = TreeNode(2, TreeNode(2), TreeNode(5))
        let result = isValidBST(root)
        XCTAssertFalse(result)
    }
}

// MARK: - Is Symmetric
class IsSymmetricTests: XCTestCase {
    func test1() {
        let leftTree = TreeNode(8, TreeNode(7), TreeNode(9))
        let rightTree = TreeNode(8, TreeNode(9), TreeNode(7))
        let root = TreeNode(10)
        root.left = leftTree
        root.right = rightTree
        let result = isSymmetric(root)
        XCTAssertTrue(result)
    }
    
    func test2() {
        let root = TreeNode(2, TreeNode(2), TreeNode(2))
        let result = isSymmetric(root)
        XCTAssertTrue(result)
    }
    
    func test3() {
        let root = TreeNode(2, TreeNode(2), TreeNode(5))
        let result = isSymmetric(root)
        XCTAssertFalse(result)
    }
    
    func test4() {
        let leftTree = TreeNode(8, TreeNode(7), TreeNode(9))
        let rightTree = TreeNode(15, TreeNode(11), TreeNode(16))
        let root = TreeNode(10)
        root.left = leftTree
        root.right = rightTree
        let result = isSymmetric(root)
        XCTAssertFalse(result)
    }
    
    func test5() {
        let rightTree = TreeNode(2, TreeNode(2), nil)
        let root = TreeNode(1, TreeNode(2, TreeNode(2), nil), rightTree)
        let result = isSymmetric(root)
        XCTAssertFalse(result)
    }
}

// MARK: - Level Order Traversal
class levelOrderTests: XCTestCase {
    func test1() {
        //                  10
        //          8                15
        //       7     9         11     16
        let leftTree = TreeNode(8, TreeNode(7), TreeNode(9))
        let rightTree = TreeNode(15, TreeNode(11), TreeNode(16))
        let root = TreeNode(10)
        root.left = leftTree
        root.right = rightTree
        let result = levelOrder(root)
        XCTAssertEqual(result, [[10], [8, 15], [7, 9, 11, 16]])
    }
    
    func test2() {
        //                  10
        //          8               8
        //      7       9       9       7
        let leftTree = TreeNode(8, TreeNode(7), TreeNode(9))
        let rightTree = TreeNode(8, TreeNode(9), TreeNode(7))
        let root = TreeNode(10)
        root.left = leftTree
        root.right = rightTree
        let result = levelOrder(root)
        XCTAssertEqual(result, [[10], [8, 8], [7, 9, 9, 7]])
    }
    
    func test3() {
        //           3
        //     9         20
        //           15      7
        let leftTree = TreeNode(9)
        let rightTree = TreeNode(20, TreeNode(15), TreeNode(7))
        let root = TreeNode(3)
        root.left = leftTree
        root.right = rightTree
        let result = levelOrder(root)
        XCTAssertEqual(result, [[3], [9, 20], [15, 7]])
    }
    
    func test4() {
        let root = TreeNode(1)
        let result = levelOrder(root)
        XCTAssertEqual(result, [[1]])
    }
    
    func test5() {
        let result = levelOrder(nil)
        XCTAssertEqual(result, [])
    }
}
