//
//  Algorithms.swift
//  TreesAlgorithms
//
//  Created by J.A. Ramirez on 12/9/21.
//

import Foundation

// MARK: - Maximum Depth of Binary Tree
/*
 Given the root of a binary tree, return its maximum depth.

 A binary tree's maximum depth is the number of nodes along the longest path from the root node down to the farthest leaf node.
 */
// We can use recursion and a dictionary. The dictionary key will contain the level of depth. Since keys cannot have duplicates, it's good to use with recursion.
// O(N), O(N)
func maxDepth(_ root: TreeNode?) -> Int {
    var depth: [Int: Int] = [:]
    findMaxDepth(of: root, depth: &depth, count: 1)
    return depth.keys.max() ?? 0
}

func findMaxDepth(of node: TreeNode?, depth: inout [Int: Int], count: Int) {
    guard node != nil else { return }
    depth[count] = 0
    findMaxDepth(of: node?.left, depth: &depth, count: count + 1)
    findMaxDepth(of: node?.right, depth: &depth, count: count + 1)
}

// You can avoid using a dictionary by simply adding to the returned value of the original function but this is slower.
// O(N), O(N)
//func maxDepth(_ root: TreeNode?) -> Int {
//    guard root != nil else { return 0 }
//    let lhs = maxDepth(root?.left) + 1
//    let rhs = maxDepth(root?.right) + 1
//    return max(lhs, rhs)
//}

// MARK: - Validate Binary Search Tree
/*
 Given the root of a binary tree, determine if it is a valid binary search tree (BST).

 A valid BST is defined as follows:

 The left subtree of a node contains only nodes with keys less than the node's key.
 The right subtree of a node contains only nodes with keys greater than the node's key.
 Both the left and right subtrees must also be binary search trees.
 */
// Learn, Example, Brute, Optimize (BUD), Walkthrough, Implement, Test
//                  10
//          8                15
//       7     9         11     16
// We can compare the parent value with the left and right child with in-order traversal. This is because there is no need to go deeper if it's invalid at the current level. Only if it's true that the condition is met, do we go further. We also need to consider the previous value since the BST must satisfy at each level.
// 
func isValidBST(_ root: TreeNode?) -> Bool {
    var lastValue: Int?
    return verifyBST(root, lastValue: &lastValue)
}

func verifyBST(_ root: TreeNode?, lastValue: inout Int?) -> Bool {
    guard let current = root else { return true }
    
    // Since in-order traversal goes to the left most node first, we check that the
    // last value is greater than the current value, if available.
    if let prevValue = lastValue, prevValue >= current.val { return false }
    // Go left first.
    if !verifyBST(current.left, lastValue: &lastValue) { return false }
    // Compare and visit self.
    if let leftValue = lastValue, leftValue >= current.val { return false }
    lastValue = current.val
    // Go right.
    if !verifyBST(current.right, lastValue: &lastValue) { return false }
    
    return true
}

// MARK: - Symmetric Tree
/*
 Given the root of a binary tree, check whether it is a mirror of itself (i.e., symmetric around its center).
 */
// Approach #1: We can traverse the left tree in-order which goes left to right. The right tee is also in-order but beginning right to left. This ensures checking a mirror version of the tree.
//                  10
//          8                8
//       7     9         9      7
// O(N), O(N)
func isSymmetric(_ root: TreeNode?) -> Bool {
    var leftValues = [Int?]()
    var rightValues = [Int?]()
    traverseInOrder(root?.left, values: &leftValues, isLeft: true)
    traverseInOrder(root?.right, values: &rightValues)
    return leftValues == rightValues
}

func traverseInOrder(_ root: TreeNode?, values: inout [Int?], isLeft: Bool = false) {
    if let val = root?.val {
        values.append(val)
        if isLeft {
            traverseInOrder(root?.left, values: &values, isLeft: true)
            traverseInOrder(root?.right, values: &values, isLeft: true)                
        } else {
            traverseInOrder(root?.right, values: &values)    
            traverseInOrder(root?.left, values: &values)
        }
    } else {
        values.append(nil)
    }
}

// MARK: - Level Order Traversal
/*
 Given the root of a binary tree, return the level order traversal of its nodes' values. (i.e., from left to right, level by level).
 */
// Learn, Example, Brute, Optimize, Walkthrough, Implement, Test 
//                  10
//          8                15
//       7     9         11     16
// Approach #1: Use a mutable dictionary that will be passed into the methods by reference and record a new array of the node's at each level and eventually return the results at the end. Since keys cannot be overwritten, the level will be mantained by the dictionary.
// list: [1: [10], 2: [8, 15], 3: [7, 9], ...]
// O(N), O(N)
func levelOrderBrute(_ root: TreeNode?) -> [[Int]] {
    var list: [Int: [Int]] = [:]
    if let val = root?.val { list[1] = [val] }
    recordLevelOrder(root, list: &list, level: 2)
    
    var nodes: [[Int]] = []
    guard !list.isEmpty else { return [] }
    for i in 1...list.count {   // O(n)
        if let values = list[i] {
            nodes.append(values)
        }
    }
    
    return nodes
}

func recordLevelOrder(_ root: TreeNode?, list: inout [Int: [Int]], level: Int) {
    guard let root = root else { return }
    
    var values: [Int] = list[level] ?? [Int]()
    if let leftVal = root.left?.val {
        values.append(leftVal)
    }
    if let rightVal = root.right?.val {
        values.append(rightVal)
    }
    if values.isEmpty { return }
    list[level] = values
    
    recordLevelOrder(root.left, list: &list, level: level + 1)
    recordLevelOrder(root.right, list: &list, level: level + 1)
}

// Approach #2: We can avoid recursion by using a queue. We will add the root to the queue. While the queue is not empty, we will dequeue the first element, record its value, and than add the node's left and right child to the queue.
//           3
//     9         20
//           15      7
// Queue: [20]
// Level: 0, 1
// Levels: [[3], [9]]
// Level Length: 2, 
// Dequeued: 3, 9
func levelOrder(_ root: TreeNode?) -> [[Int]] {
    guard let root = root else { return [] }
    
    var queue: [TreeNode?] = [root]    
    var levels: [[Int]] = []
    var level: Int = 0
    
    while !queue.isEmpty {
        // Start the current level list.
        levels.append([Int]())
        
        // The number of elements in the current level.
        let levelLength = queue.count
        for _ in 0..<levelLength {
            if let node = queue.removeFirst() {
                levels[level].append(node.val)
                
                // Add the children of the current level into the queue for the next level.
                if node.left != nil { queue.append(node.left!) }
                if node.right != nil { queue.append(node.right!) }
            }
        }
        level += 1
    }
    
    return levels
}

// MARK: - Convert Sorted Array to Binary Search Tree
/*
 Given an integer array nums where the elements are sorted in ascending order, convert it to a height-balanced binary search tree.
 A height-balanced binary tree is a binary tree in which the depth of the two subtrees of every node never differs by more than one.
 */
// Input: nums = [-10, -3, 0, 5, 9]
// Output: [0, -3, 9, -10, null, 5]
//            0 
//      -3       9
//  -10       5
//
// Input: nums = [-5, -3, -2, 1, 2, 3, 5]
// [-5, -3, -2]- 1 -[2, 3, 5]
// [-5] -3 [-2]-  1 -[2] 3 [5]
//                      1
//                -3        3 
//            -5     -2  2    5
// Choose the center value to be the root of the tree. Then, split the array to the values left of the root and values to the right of the root. Then, set those center values as the left child and right child of that root node. Repeat recursively.
// [-5, -3, -2, 1, 2, 3, 5]: 1
//      LEFT [-5, -3, -2]: -3
//              LEFT [-5]: -5
//              RIGHT [-2]: -2
//      RIGHT [2, 3, 5]: 3
//              LEFT [2]
//              RIGHT [5]
//                  1 
//          -3           3
//     -5      -2    2      5
func sortedArrayToBST(_ nums: [Int]) -> TreeNode? {
    guard !nums.isEmpty else { return nil }
    
    let centerIndex = nums.count / 2
    let parentNode = TreeNode(nums[centerIndex])
    parentNode.left = sortedArrayToBST(Array(nums[0..<centerIndex]))
    parentNode.right = sortedArrayToBST(Array(nums[(centerIndex + 1)..<nums.endIndex]))
    
    return parentNode
}
