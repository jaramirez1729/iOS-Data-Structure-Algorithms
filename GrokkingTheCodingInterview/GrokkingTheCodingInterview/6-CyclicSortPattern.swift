//
//  6-CyclicSortPattern.swift
//  GrokkingTheCodingInterview
//
//  Created by J.A. Ramirez on 2/22/22.
//

import Foundation

/*
 This pattern describes an interesting approach to deal with problems involving arrays containing numbers in a given range. For example, take the following problem:

 You are given an unsorted array containing n numbers taken from the range 1 to n. The array can have duplicates, which means that some numbers will be missing. Find all the missing numbers.
 
 To efficiently solve this problem, we can use the fact that the input array contains numbers in the range of 1 to n. For example, to efficiently sort the array, we can try placing each number at its correct place, i.e., placing 1 at index '0', placing 2 at index ‘1’, and so on. Once we are done with the sorting, we can iterate the array to find all indices missing the correct numbers. These will be our required numbers.

 Let’s jump on to our first problem to understand the Cyclic Sort pattern in detail.
 */

// MARK: - Cyclic Sort (Easy)
/*
 We are given an array containing n objects. Each object, when created, was assigned a unique number from the range 1 to n based on their creation sequence. This means that the object with sequence number 3 was created just before the object with sequence number 4.

 Write a function to sort the objects in-place on their creation sequence number in O(n) and without using any extra space. For simplicity, let’s assume we are passed an integer array containing only the sequence numbers, though each number is actually an object.
 */
// Uses a single pointer and swapping to put the elements in their final position.
// Time O(N), Space(1)
func cyclicSort(_ list: inout [Int]) {
    var traversalIndex = 0
    // Go down the list from the start each time to ensure each swap makes a valid sort. Only increase the traversal index when a number is already in its final position.
    while traversalIndex < list.count {
        // Since each number N should be in the N - 1 index, get the expected index for the current value.
        let expectedIndex = list[traversalIndex] - 1
        // Check if the current number is already in its final position.
        if list[traversalIndex] != list[expectedIndex] {
            list.swapAt(traversalIndex, expectedIndex)
        } else {
            traversalIndex += 1
        }
    }
}

// MARK: - Find the Missing Number (Easy)
/*
 We are given an array containing N distinct numbers taken from the range 0 to N. Since the array has only N numbers out of the total N + 1 numbers (since it includes 0...N), find the missing number.
 */
// Time O(N), Space O(N) (O(1) but Swift cannot mutate arguments without changing the original)
func findMissingNumber(in list: [Int]) -> Int {
    var traversalIndex = 0
    var mList = list
    let n = mList.count
    
    // Sort the elements first into their respective indices.
    while traversalIndex < n {
        let expectedIndex = mList[traversalIndex]
        // Less than n since the n value would be out of bounds for a valid array from 0..<n. If it's n, it will leave it alone to wherever it ends up after the rest of the list sorts itself.
        if mList[traversalIndex] < n && mList[traversalIndex] != mList[expectedIndex] {
            mList.swapAt(traversalIndex, expectedIndex)
        } else {
            traversalIndex += 1
        }
    }
    
    // Find the first number missing from its index.
    for i in 0..<n {
        if mList[i] != i { return i }
    }
    
    return n
}
