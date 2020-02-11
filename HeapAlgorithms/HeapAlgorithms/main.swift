//
//  main.swift
//  HeapAlgorithms
//
//  Created by Jozeee on 2/3/20.
//  Copyright © 2020 AdaloveSoftware. All rights reserved.
//

import Foundation

/*
 Heap Questions
 Given an array, check if it represents a binary max-heap.
 Given a binary tree, check if it represents a binary max-heap.
 Convert a min-heap to a max-heap.
 */


// MARK: -
// Given an array, check if it represents a binary max-heap.
// LISTEN; EXAMPLE: heap: 100 (30 (10, 15); 50 (40, 45) )
// Array of above heap: [100, 30, 50, 10, 15, 40, 45]
// Index mapping: 0 -> 1, 2; 1 -> 3, 4; 2 -> 5, 6 ...
// Left child: Multiply index by 2 and add 1.
// Right child: Multiply index by 2 and add 2.
// It will only be a heap IFF (2k + 1) and (2k + 2) are less than kth element.
// BRUTE: Loop through the list. Check if (2k + 1) and (2k + 2) are less than
// the current element. if true, then continue. if false, then quit.
// Have to make sure that (2k + 1) and (2k + 2) are valid indexes first.
// Time O(n): where n is the size of the list.
// Space O(1): the space does not grow in relation to input.
func isBinaryMaxHeapForArray(_ list: [Int]) -> Bool {
    guard !list.isEmpty else { return false }
    
    var isBinaryMaxHeap: Bool = true
    
    for i in 0..<list.count {
        // There must always be a left node since it's a compact tree.
        guard list.indices.contains((2 * i) + 1) else { break }
        
        // Check first if the parent is greater than the left child.
        if list[i] >= list[(2 * i) + 1] {
            
            // Check if it's greater than the right child, if it exists.
            if list.indices.contains((2 * i) + 2), list[i] < list[(2 * i) + 2] {
                isBinaryMaxHeap = false
                break
            }
        } else {
            isBinaryMaxHeap = false
            break
        }
    }
    
    return isBinaryMaxHeap
}


// MARK: -
// Given a binary tree, check if it represents a binary heap.
// LISTEN; EXAMPLE: 97 (46 (12 (6, 9), 3), 37 (7, 31) ); isBinaryFlag = true
// BRUTE: Traverse the tree and create an array from it, then check the array using index math.
// OPTIMIZE (BUD): Do not create an array. Traverse the tree beginning at the node. The traversal
// does not matter. Use depth-first-search. Compare if the child nodes are smaller than the parent
// node. Then continue until the entire tree is traversed. Use a reference flag.
// WALKTHROUGH;
// Time O(n): Traversal into each node once.
// Space (n): Space of calling recursive calls grows in relation to size of tree.
func isBinaryMaxHeapForTree(_ tree: BinaryNode<Int>) -> Bool {
    var isBinaryMaxHeap: Bool = true
    traverseTree(tree, flag: &isBinaryMaxHeap)
    return isBinaryMaxHeap
}

private func traverseTree(_ node: BinaryNode<Int>?, flag: inout Bool) {
    guard node != nil else { return }
    guard flag else { return }
    
    if let nodeValue = node?.val {
        if let leftChild = node?.left {
            if nodeValue >= leftChild.val {
                // It can only have a right node if a left node exists because it's a complete tree.
                if let rightChild = node?.right, nodeValue < rightChild.val {
                    flag = false
                    return
                }
            } else {
                flag = false
                return
            }
        }
    }
    
    traverseTree(node?.left, flag: &flag)
    traverseTree(node?.right, flag: &flag)
}


// MARK: -
// Convert a min-heap to a max-heap.
// LISTEN; EXAMPLE [3, 5, 9, 6, 8, 20, 10, 12, 18, 9]
// Left node is 2k + 1, and right node is 2k + 2 of kth element.
// BRUTE: Look for the biggest element and insert into the heap. Find the next biggest
// element and append to the list. Continue until there are no more elements.
// WALKTHROUGH: []; [20, 18, 12, 10, 9, 9, 8, 6, 5, 3]; [20 (18 (10 (6, 5), 9 (3)), 12 (9, 8))
//                              20
//                      18              12
//                 10        9      9       8
//               6    5    3
// OPTIMIZE (BUD): Could we swap elements in place instead?
// Time O(n) to traverse the array of elements.
// Space O(n) new array takes space related to the size of the original list.
func convertToMaxHeap(_ minHeap: [Int]) {
    var elements = minHeap
    var maxHeap = [Int]()
    for _ in elements {
        if let max = elements.max() {
            elements.remove(at: elements.firstIndex(of: max) ?? 0)
            maxHeap.append(max)
        }
    }
    print(maxHeap)
}


// MARK: -
// Convert a min-heap to a max-heap.
// Time O(n)
func convertToMaxHeapOptimized(_ minHeap: inout [Int]) {
    // Start from the bottommost and eightmost internal node and heapify all internal
    // nodes in bottom up way. This traverses through the subtree that excludes leafs.
    var i = (minHeap.count - 2) / 2
    while i >= 0 {
        heapify(&minHeap, i: i)
        i -= 1
    }
}

private func heapify(_ list: inout [Int], i: Int) {
    let l = (2 * i) + 1
    let r = (2 * i) + 2
    var largest = i
    
    // Check which leaf is greater than the parent node.
    if (l < list.count && list[l] > list[i]) {
        largest = l
    }
    if (r < list.count && list[r] > list[largest]) {
        largest = r
    }
    if largest != i {
        // Swap leaf node with the parent node depending on which leaf was bigger.
        list.swapAt(i, largest)
        // Repeat the same for the node that just became a leaf.
        heapify(&list, i: largest)
    }
}

