//
//  main.swift
//  TreeAlgorithms
//
//  Created by Jozeee on 1/23/20.
//  Copyright © 2020 AdaloveSoftware. All rights reserved.
//

import Foundation

/*
 Tree Questions
 Find the height of a binary tree.
 Find the kth maximum value in a binary search tree.
 Find nodes at k distance from the root.
 Find ancestors of a given node in a binary tree.
 Implement breadth-first search.
 Implement depth-first search.
 Verify that a binary search tree is indeed a binary search tree.
 Write a method to compare if two binary trees are identical.
 Deep copy a tree.
 */


// MARK: - Height of Tree
// Find the height of a binary tree.
// LISTEN
// EXAMPLE
// BRUTE: Start at the root. Increase the depth counter by 1 for every recursive call.
// Store each depth in a dictionary to prevent it from being overwritten by other recursive calls.
// Return back the maximum key value from the dictionary.
// BUD; WALKTHROUGH; IMPLEMENT; TEST
// Time O(n): Traversal is linear; no work is done at each level.
// Space O(n): Space changes based on the size of the tree.
/// Uses a hash table to store the height of the tree. Since it doesn't replace the value, the highest value
/// in the hash table is the maximum height of the tree.
func hashFindHeightOfTree(_ tree: BinaryNode<Int>?) -> Int {
    var height: [Int: Int] = [:]
    getHeight(using: tree, counter: &height, depth: 1)
    return height.keys.max() ?? 0
}

private func getHeight(using node: BinaryNode<Int>?, counter: inout [Int: Int], depth: Int) {
    if node == nil { return }
    counter[depth] = 0
    getHeight(using: node?.right, counter: &counter, depth: depth + 1)
    getHeight(using: node?.left, counter: &counter, depth: depth + 1)
}


// MARK: - Height of Tree
// Find the height of a binary tree.
// EXAMPLE:             1
//              2               3
//          4       5
//                   26
/// Gets the height of the tree using recursion on each leaf.
func findHeightOfTree(_ tree: BinaryNode<Int>?) -> Int {
    if tree == nil { return 0 }
    // Compute the depth of each subtree and return the greatest one.
    let lHeight = findHeightOfTree(tree?.left)
    let rHeight = findHeightOfTree(tree?.right)
    return max(lHeight + 1, rHeight + 1)
}


// MARK: - Nth Maximum Value
// Find the nth maximum value in a binary search tree.
// LISTEN
// EXAMPLE:   10        [4, 6, 7, 8, 10, 23, 25, 30]
//         6     23
//       4    8    30
//           7   25
// BRUTE: Traverse the tree and save every value in an array, then get the nth value from the end of the array.
// OPTIMIZE: Traverse the tree starting from the right because they are the highest numbers.
//           When all right have been done, then start traversing the left.
func findMaxValue(_ n: Int, from root: BinaryNode<Int>?) {
    var counter = 0
    maxValue(counter: &counter, n: n, node: root)
}

private func maxValue(counter: inout Int, n: Int, node: BinaryNode<Int>?) {
    if node == nil {
        counter += 1
        return
    }
    maxValue(counter: &counter, n: n, node: node?.right)
    
    // If the counter has reached the nth node we're looking for.
    if counter == n {
        if let val = node?.val { print(val) }
    }
    // If it has not found it by going right first, then start going to the left nodes
    // after all right nodes have been visited.
    maxValue(counter: &counter, n: n, node: node?.left)
}


// MARK: - K Distance from Root
// Find nodes at k distance from the root.
// All values that are k distance will be in the same level.
// LISTEN; BRUTE: loop through the tree and store the level of the tree as a key in a hash map and save the values
// of the tree for values for that key. If the key matches the k, then return; no need to keep going.
// EXAMPLE:   10
//         6     23
//       4    8    30
//           7
// Time O(n): Assuming a full tree, each node is visited only once.
// Space O(n): Grows in relation to the data being operated on.
func findNodesDistance(_ k: Int, from node: BinaryNode<Int>?) {
    var hashMap: [Int: [Int]] = [:]
    findNodes(k, from: node, height: 0, hashMap: &hashMap)
    if let arr = hashMap[k] {
        print(arr)
    } else {
        print("No values found that are \(k) distance from the root.")
    }
}

private func findNodes(_ k: Int, from node: BinaryNode<Int>?, height: Int, hashMap: inout [Int: [Int]]) {
    if node == nil { return }
    // Store the value for the same height.
    if let val = node?.val {
        if hashMap[height] == nil {
            hashMap[height] = [val]
        } else {
            hashMap[height]?.append(val)
        }
    }
    // If it goes farther than k, there is no need anymore to store the remaining values.
    if height >= k { return }
    findNodes(k, from: node?.left, height: height + 1, hashMap: &hashMap)
    findNodes(k, from: node?.right, height: height + 1, hashMap: &hashMap)
}


// MARK: - Find Ancestors
// Find ancestors of a given node in a binary tree.
// EXAMPLE:       10
//            6        23
//         4     8   15  30
//        1 3   7 9     2
// BRUTE: Traverse the tree one side, and store each visited value in an array. When it can't go anymore, and has not found the value yet,
// remove the last element that was added before returning, that way it removes visited nodes that did not go to the given node. Once the node
// has been found, quit and return back the array of ancestors.
// Time O(n): Linear because it visits each node once.
func findAncestors(in node: BinaryNode<Int>?, for value: Int) {
    var ancestors: [Int] = []
    findAncestors(in: node, value: value, ancestors: &ancestors)
    // The last value is not part of the ancestry; only used to know when to stop recursion.
    _ = ancestors.popLast()
    print(ancestors)
}

private func findAncestors(in node: BinaryNode<Int>?, value: Int, ancestors: inout [Int]) {
    if node == nil || ancestors.contains(value)  { return }
    
    if let val = node?.val {
        ancestors.append(val)
    }
    
    findAncestors(in: node?.left, value: value, ancestors: &ancestors)
    findAncestors(in: node?.right, value: value, ancestors: &ancestors)
    
    // By this point, it has reached the end of left/right recursion to it's going back and it has not found the target
    // number yet, which means it should remove the last value visited to move on to the next node in the level.
    if !ancestors.contains(value) {
        _ = ancestors.popLast()
    }
}


// MARK: - Breadth First Search
// Implement breadth-first search for a binary tree.
// Traversal is done for all nodes in the same level before moving on to the next level. It goes from top to bottom, left to right.
// EXAMPLE:       10
//            6        23
//         4     8   15  30
//        1 3   7 9     2
// Creates a loop to get to a certain level of the tree. Once the targed level has been reached, it will print out the left and
// right elements. Then it will do the same for the next nodes in the same level.
// In order to print out objects in the same level, keep a copy of the height. You can use a loop to get to a certain level.
func breadthFirstSearch(node: BinaryNode<Int>?) {
    for i in 0..<findHeightOfTree(node) {
        printLevel(for: node, level: i)
    }
}

private func printLevel(for node: BinaryNode<Int>?, level: Int) {
    if node == nil { return }
    if level == 0, let value = node?.val {
        print(value)
    } else {
        printLevel(for: node?.left, level: level - 1)
        printLevel(for: node?.right, level: level - 1)
    }
}


// MARK: - Breadth First Search
// Implement breadth-first search for a binary tree.
// Traversal is done for all nodes in the same level before moving on to the next level. It goes from top to bottom, left to right.
// EXAMPLE:       10         Q -> Front []; print: 10, 6, 23, 4, 8, 15, 30, 1, 3, 7, 9, 2
//            6         23
//         4     8   15    30
//        1 3   7 9       2
// The queue is necessary to keep the order in which the nodes are visited in the same level because the traversal to
// the left side first, and the queue prevents printing the values only from the left side.
// Traversal node and a queue can be used to go through the entire tree without recursion. The queue holds a reference to the visited nodes.
// Then it pops it out and queues the its leaves.
// Time O(n): Traversing visits every node once.
// Space O(n): Size grows in relation to the tree side.
func breadthFirstSearchQueue(node: BinaryNode<Int>?) {
    var queue = Queue<BinaryNode<Int>?>()
    var temp: BinaryNode<Int>? = node
    queue.enqueue(temp)
    while !queue.isEmpty {
        if let nextNode = queue.dequeue() {
            temp = nextNode
        }
        if let val = temp?.val {
            print(val)
        }
        if temp?.left != nil {
            queue.enqueue(temp?.left)
        }
        if temp?.right != nil {
            queue.enqueue(temp?.right)
        }
    }
}


// MARK: - Depth First Search
// Implement inorder depth-first search for a binary tree. Inorder is left tree, node, and then right tree.
// EXAMPLE:       10
//            6        23
//         4     8   15  30
//        1 3   7 9     2
// Should print: 1, 4, 3, 6, 7, 8, 9, 10, 15, 23, 2, 30
func depthFirstSearchInorder(_ node: BinaryNode<Int>?) {
    depthFirstSearchInorderRecursive(node?.left)
    if let val = node?.val { print(val) }
    depthFirstSearchInorderRecursive(node?.right)
}

private func depthFirstSearchInorderRecursive(_ node: BinaryNode<Int>?) {
    if node == nil { return }
    depthFirstSearchInorderRecursive(node?.left)
    if let val = node?.val {
        print(val)
    }
    depthFirstSearchInorderRecursive(node?.right)
}


// MARK: - Depth First Search
// Implement preorder depth-first search for a binary tree. Preorder is root, left, right.
// EXAMPLE:       10
//            6        23
//         4     8   15  30
//        1 3   7 9     2
// Should print: 10, 6, 4, 1, 3, 8, 7, 9, 23, 15, 30, 2
func depthFirstSearchPreorder(_ node: BinaryNode<Int>?) {
    if let val = node?.val {
        print(val)
    }
    depthFirstSearchPreorderRecursive(node?.left)
    depthFirstSearchPreorderRecursive(node?.right)
}

private func depthFirstSearchPreorderRecursive(_ node: BinaryNode<Int>?) {
    if node == nil { return }
    if let val = node?.val {
        print(val)
    }
    depthFirstSearchPreorderRecursive(node?.left)
    depthFirstSearchPreorderRecursive(node?.right)
}


// MARK: - Depth First Search
// Implement postorder depth-first search for a binary tree. Postorder is left, right, root.
// EXAMPLE:       10
//            6        23
//         4     8   15  30
//        1 3   7 9     2
// Should print:
func depthFirstSearchPostorder(_ node: BinaryNode<Int>?) {
    depthFirstSearchPostorderRecursive(node?.left)
    depthFirstSearchPostorderRecursive(node?.right)
    if let val = node?.val {
        print(val)
    }
}

private func depthFirstSearchPostorderRecursive(_ node: BinaryNode<Int>?) {
    if node == nil { return }
    depthFirstSearchPostorderRecursive(node?.left)
    depthFirstSearchPostorderRecursive(node?.right)
    if node == nil { return }
    if let val = node?.val {
        print(val)
    }
}


// MARK: - Verify BST
// Verify that a binary search tree is indeed a binary search tree.
// LISTEN
// EXAMPLE:               30
//              25               40
//          20       28      35      50
//        10  23   26  29          45
// BRUTE: Use BST inorder; if the given list is not sorted, than it is not a binary search tree.
// Time O(n log n)
func isBinarySearchTree(_ node: BinaryNode<Int>?) -> Bool {
    var list: [Int] = []
    isBinarySearchTreeDFSInorder(node?.left, list: &list)
    if let val = node?.val { list.append(val) }
    isBinarySearchTreeDFSInorder(node?.right, list: &list)
    return list == list.sorted()
}

private func isBinarySearchTreeDFSInorder(_ node: BinaryNode<Int>?, list: inout [Int]) {
    if node == nil { return }
    isBinarySearchTreeDFSInorder(node?.left, list: &list)
    if let val = node?.val {
        list.append(val)
    }
    isBinarySearchTreeDFSInorder(node?.right, list: &list)
}


// MARK: -
// Write a method to compare if two binary trees are identical.
// EXAMPLE:             1
//              2               3
//          4       5
//                   26
// ALGORITHM: Create 3 boolean values that are based on the equality of the root, the left subtree, and right subtree.
// Recursively go through each tree and check their values.
func areTreesEqual(_ tree1: BinaryNode<Int>?, tree2: BinaryNode<Int>?) -> Bool {
    var isLeftEqual: Bool = false
    var isRightEqual: Bool = false
    var isRootEqual: Bool = false
    
    if tree1 == nil && tree2 == nil { return true }
    
    if let tree1V = tree1?.val, let tree2V = tree2?.val, tree1V == tree2V {
        isRootEqual = true
        isLeftEqual = areTreesIdenticalSearch(tree1?.left, tree2: tree2?.left)
        isRightEqual = areTreesIdenticalSearch(tree1?.right, tree2: tree2?.right)
    }
    return isRootEqual && isLeftEqual && isRightEqual
}

private func areTreesIdenticalSearch(_ tree1: BinaryNode<Int>?, tree2: BinaryNode<Int>?) -> Bool {
    // If they both don't have a value for that leaf, then they are equal.
    if tree1 == nil && tree2 == nil { return true }
    
    // Check the values of both leafs and then traverse again the left and right.
    if let tree1V = tree1?.val, let tree2V = tree2?.val, tree1V == tree2V {
        return areTreesIdenticalSearch(tree1?.left, tree2: tree2?.left) && areTreesIdenticalSearch(tree1?.right, tree2: tree2?.right)
    } else {
        return false
    }
}

// MARK: -
// Create a method that copies a tree/subtree.
// LISTEN; EXAMPLE; BRUTE FORCE; OPTIMIZE (BOTTLENECKS? UNNECESSARY WORK? DUPLICATE WORK?); WALKTHROUGH; IMPLEMENT; TEST
// Time O(); Space O(n)
extension BinaryNode {
    func copy() -> BinaryNode {
        let copyHead = BinaryNode(value: self.val)
        copyHead.left = copyChild(self.left)
        copyHead.right = copyChild(self.right)
        return copyHead
    }
    
    private func copyChild(_ node: BinaryNode?) -> BinaryNode? {
        if let val = node?.val {
            let copy = BinaryNode(value: val)
            copy.left = copyChild(node?.left)
            copy.right = copyChild(node?.right)
            return copy
        }
        return nil
    }
}

// EXAMPLE:             1
//              2               3
//          4       5
//                   26
let tree1 = BinaryNode<Int>(value: 1)
tree1.left = BinaryNode<Int>(value: 2)
tree1.right = BinaryNode<Int>(value: 3)
tree1.left?.left = BinaryNode<Int>(value: 4)
tree1.left?.right = BinaryNode<Int>(value: 5)
tree1.left?.right?.right = BinaryNode<Int>(value: 26)
