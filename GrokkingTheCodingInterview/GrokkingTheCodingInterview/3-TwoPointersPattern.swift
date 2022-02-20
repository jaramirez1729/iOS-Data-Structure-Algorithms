//
//  TwoPointersPattern.swift
//  GrokkingTheCodingInterview
//
//  Created by J.A. Ramirez on 2/14/22.
//

import Foundation
/*
 The two pointer approach uses 2 pointers in a list and determines whether to move one up or move one down. One way is to have a pointer at the start and end. Another way is to have a pointer loop through the list and have 1 pointer slowly change position.
 */

// MARK: - Pair with Target Sum (Easy)
/*
 Given an array of sorted numbers and a target sum, find a pair in the array whose sum is equal to the given target. Write a function to return the indices of the two numbers (i.e. the pair) such that they add up to the given target.
 */
// Uses a start and end pointer. Checks if those 2 values are over, under, or equal to the sum and moves the pointers up or down depending on the total.
// Time O(N), Space O(1)
func pairWithTargetSum(_ sum: Int, in list: [Int]) -> [Int] {
    var leftPointer = 0
    var rightPointer = list.count - 1
    while leftPointer < rightPointer {
        let currentSum = list[leftPointer] + list[rightPointer]
        if currentSum == sum {
            return [leftPointer, rightPointer]
        }
        // Move the pointers up or down depending if we go over or under the sum.
        (sum > currentSum) ? (leftPointer += 1) : (rightPointer -= 1)
    }
    return [-1, -1] // Did not find anything.
}

// MARK: - Remove Duplicates (Easy)
/*
 Given an array of sorted numbers, remove all duplicates from it. You should not use any extra space; after removing the duplicates in-place return the length of the subarray that has no duplicate in it.
 */
// Uses a pointer to go down the list, and another pointer to keep the position of the location to replace the duplicate.
// Time O(N), Space O(1)
func removeDuplicates(in list: inout [Int]) -> Int {
    guard !list.isEmpty else { return 0 }
    // Keeps track of where the list with no duplicates ends. It also keeps track of where to put the next number found that isn't in the list yet.
    var nextNonDuplicatePointer = 1
    for i in 1..<list.endIndex {
        // Checks if the next number in the list matches the last one already in the list.
        if list[nextNonDuplicatePointer - 1] != list[i] {
            // We are not actually swapping, just copying the unrepeated number to the list.
            list[nextNonDuplicatePointer] = list[i]
            nextNonDuplicatePointer += 1
        }
    }
    return nextNonDuplicatePointer
}

/* A similar question is: Given an unsorted array of numbers and a target ‘key’, remove all instances of ‘key’ in-place and return the new length of the array.
 */
// Time O(N), Space O(1)
func removeDuplicates(in list: inout [Int], of key: Int) -> Int {
    guard !list.isEmpty else { return 0 }
    
    var nextElementIndex = 0
    for i in 0..<list.endIndex {
        // If the current number does not match the one we want to remove, we will insert it at the last location where the key was found, and thus override the number. The nextElementIndex ending value will contain the size of the list without the key values.
        if key != list[i] {
            list[nextElementIndex] = list[i]
            nextElementIndex += 1
        }
    }
    return nextElementIndex
}

// MARK: - Squaring a Sorted Array (Easy)
/*
 Given a sorted array, create a new array containing squares of all the numbers of the input array in the sorted order.
 */
// Uses a pointer at the start and a pointer at the end to calculate the squares of numbers. We use both ends to account for negative numbers in the list. We go down and up depending on which square was larger depends on which one we add next to the final list.
// Time O(N), Space O(N)
func makeSortedSquares(from list: [Int]) -> [Int] {
    guard !list.isEmpty else { return [] }
    
    let listSize = list.count
    // Prefill the array with zeroes so we can insert large numbers first going to smallest; also to avoid any invalid index errors.
    var squares = Array(repeating: 0, count: listSize)
    // The pointer that goes down from the top of the squares list. Used to determine the current position of where to put the next smallest square number.
    var highestSquareIndex = listSize - 1
    var leftPointer = 0 // Start from the beginning of the list.
    var rightPointer = listSize - 1 // Start from the end of the list.
    
    while leftPointer <= rightPointer {
        let leftSquare = list[leftPointer] * list[leftPointer]
        let rightSquare = list[rightPointer] * list[rightPointer]
        if leftSquare > rightSquare {
            squares[highestSquareIndex] = leftSquare
            leftPointer += 1
        } else {
            squares[highestSquareIndex] = rightSquare
            rightPointer -= 1
        }
        highestSquareIndex -= 1
    }
    return squares
}

// MARK: - // MARK: - Triplet Sum Close to Target (Medium)
/*
 Given an array of unsorted numbers, find all unique triplets in it that add up to zero.
 */
// It's easier to sort the array first so we can avoid duplicates. It also makes it easier to traverse. Then, we need to find X + Y + Z = 0, or Y + Z = -X. So we just need to find 2 elements now instead of 3. We will use the first loop to be the -X, and then use another loop to find Y + Z that equals -X.
// Time O(N * log N + N^2) ~ O(N^2), Space(N)
func tripletsWithZeroSum(in list: [Int]) -> [[Int]] {
    let sortedList = list.sorted()
    var triplets = [[Int]]()
    for i in 0..<sortedList.endIndex {
        // Skip and proceed if the next sum -X to check is the same as the previous answer.
        if i > 0 && sortedList[i] == sortedList[i - 1] { continue }
        // The current number is the -X target, so we need to start looking for Y + Z an index after the current position.
        searchPair(in: sortedList, targetSum: -sortedList[i], nextIndex: i + 1, triplets: &triplets)
    }
    return triplets
}

// Uses 2 pointers to traverse the rest of the list from the (nextIndex - 1) position since that is the target sum. Keep moving the left and right pointers up and down until we find a sum. We also ensure there are no duplicates.
private func searchPair(in list: [Int], targetSum: Int, nextIndex: Int, triplets: inout [[Int]]) {
    var rightIndex = list.endIndex - 1
    var leftIndex = nextIndex
    
    while leftIndex < rightIndex {
        let currentSum = list[leftIndex] + list[rightIndex]
        if currentSum == targetSum { // Found a triplet.
            triplets.append([-targetSum, list[leftIndex], list[rightIndex]])
            leftIndex += 1
            rightIndex -= 1
            // Skip same elements to avoid duplicates from both ends of the sorted list.
            while leftIndex < rightIndex && list[leftIndex] == list[leftIndex - 1] { leftIndex += 1 }
            while leftIndex < rightIndex && list[rightIndex] == list[rightIndex + 1] { rightIndex -= 1 }
        } else if targetSum > currentSum {
            leftIndex += 1 // We need a pair with a bigger sum.
        } else {
            rightIndex -= 1 // We need a pair with a smaller sum.
        }
    }
}

// MARK: - Triplet Sum Close to Target (Medium)
/*
 Given an array of unsorted numbers and a target number, find a triplet in the array whose sum is as close to the target number as possible, return the sum of the triplet. If there are more than one such triplet, return the sum of the triplet with the smallest sum.
 */
// Time O(N * log N + N^2), Space O(N)
func tripletSumCloseToTarget(in list: [Int], targetSum: Int) -> Int {
    guard list.count > 2 else { return Int.max }
    
    let sortedList = list.sorted()
    var smallestDiff = Int.max
    
    for i in 0..<sortedList.endIndex - 2 {
        var leftIndex = i + 1
        var rightIndex = sortedList.endIndex - 1
        while leftIndex < rightIndex {
            // Get the difference from the target sum minus the triplet numbers we are considering.
            let targetDiff = targetSum - sortedList[i] - sortedList[leftIndex] - sortedList[rightIndex]
            // Found a triplet that equals exactly the total so return the sum.
            if targetSum == 0 { return targetSum }
            
            // We have a new smallest difference.
            let isNewDiff = abs(targetDiff) < abs(smallestDiff)
            // Handles the smallest sum when we have more than one solution.
            let ifNoAbsoluteDiff = (abs(targetDiff) == abs(smallestDiff) && targetDiff > smallestDiff)
            // Update the smallest differerence with the new lowest target difference.
            if isNewDiff || ifNoAbsoluteDiff { smallestDiff = targetDiff }
            
            if targetDiff > 0 {
                leftIndex += 1 // We need a triplet with a bigger sum.
            } else {
                rightIndex -= 1 // We need a triplet with a smaller sum.
            }
        }
    }
    return targetSum - smallestDiff
}
