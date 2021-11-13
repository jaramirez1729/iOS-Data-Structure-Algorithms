//
//  main.swift
//  HashTableAlgorithms
//
//  Created by Jozeee on 2/2/20.
//  Copyright © 2020 AdaloveSoftware. All rights reserved.
//

import Foundation

// MARK: - 2020 Questions
// Hash Table Questions
// Check if an array is a subset of another array.
// Create an intersection and union from 2 linked lists.
// Find four elements a, b, c and d in an array such that a + b = c + d and a, b, c, and d are unique.

// MARK: - 2021 Questions
// Given an array of pairs, find all symmetric pairs in it. All first elements of pairs are unique.
// Given a list of numbers, print all subarrays with 0 sum.

// MARK: -
// Check if an array is a subset of another array.
// Time O(n + m): It takes n times for the first array to be filled into the dictionary, and at most m times
// for the 2nd array to be looped through to check if the value exists in the dictionary.
// Space O(n)
func isArraySubset(arr1: [Int], arr2: [Int]) -> Bool {
    var dict: [Int: Int] = [:]
    arr1.forEach({ dict[$0, default: 0] += 1 })
    
    for item in arr2 {
        if dict[item] == nil {
            return false
        } else if let count = dict[item] {
            dict.updateValue(count - 1, forKey: item)
            if count - 1 <= 0 {
                dict.removeValue(forKey: item)
            }
        }
    }
    return true
}


// MARK: -
// Create an intersection and union from 2 linked lists.
// LISTEN; EXAMPLE: [1, 3, 5, 6], [1, 3, 7, 6]
// BRUTE: Add all the elements of the first list into a dictionary.
// OPTIMIZE (BUD); WALKTROUGH;
// Time O(n + m + z): Traversing list1 if n is size; traversing list2 if m is size.
// Space O(n):
func createIntersectionAndUnion(for list1: SingleLinkedList<Int>, list2: SingleLinkedList<Int>) {
    var uDict: [Int: Int] = [:]
    var iDict: [Int: Int] = [:]
    let unionList: SingleLinkedList<Int> = SingleLinkedList<Int>()
    let intersectionList: SingleLinkedList<Int> = SingleLinkedList<Int>()
    
    var tNode = list1.first
    while tNode != nil { // n times where n is the size of list1
        if let val = tNode?.value {
            uDict[val] = 0
            iDict[val] = 0
        }
        tNode = tNode?.next
    }
    
    tNode = list2.first
    while tNode != nil { // m times where m is the size of list2
        if let val = tNode?.value {
            uDict[val] = 0
            
            // If the value already exits in the intersection dictionary, then add it to the array
            // and remove the key.
            if iDict[val] != nil {
                intersectionList.append(value: val)
                iDict.removeValue(forKey: val)
            }
        }
        tNode = tNode?.next
    }
    
    uDict.forEach({ unionList.append(value: $0.key) }) // z times since it does not have duplicates
    
    print("Union: \(unionList)")
    print("Intersection: \(intersectionList)")
}


// MARK: -
// Find four elements a, b, c and d in an array such that a + b = c + d where a, b, c, and d are unique.
// LISTEN; EXAMPLE [3, 4, 7, 1, 2, 9, 8]; [7: [(3, 4)], 10: [(3, 7), (1, 9)], ...]
// BRUTE: Outer loop loops through every value. Inner loop loops trough the next starting value
// to prevent recording the same numbers. Add up the 2 numbers and add them as a key in a dictionary.
// This will prevent duplicates.
func findSum(in list: [Int]) {
    guard !list.isEmpty else { return }
    
    var dict: [Int: [(Int, Int)]] = [:]
    
    for a in 0..<list.count {
        for b in (a + 1)..<list.count {
            // If the sum already exists as a key, then read the first pair in the list.
            if let arr = dict[list[a] + list[b]], let existingPair = arr.first {
                // They must all be unique values so make sure none of their digits match with any other.
                if list[a] != existingPair.0 && list[a] != existingPair.1 && list[b] != existingPair.0 && list[b] != existingPair.1 {
                    print("\((list[a], list[b])), \(existingPair) = \(list[a] + list[b])")
                }
            } else {
                // If it does not exist, add the pair into an empty array with the total as a key.
                dict[list[a] + list[b]] = [(list[a], list[b])]
            }
        }
    }
}

// MARK: -
// LISTEN
// EXAMPLE: [(11, 20), (40, 30), (2, 5), (20, 11), (10, 5), (30, 40)]. The following have pairs (11, 20) and (40, 30).
// BRUTE: Loop through the array with 2 loops and checking each element. O(n^2)
//        Loop through the array and store each as key-value pairs, but check if the value exists as a key first. O(n)
// IMPLEMENT:
// Given an array of pairs, find all symmetric pairs in it. All first elements of pairs are unique.
func findPairs(in list: [(Int, Int)]) -> [(Int, Int)] {
    var dict: [Int: Int] = [:]
    var pairs: [(Int, Int)] = []
    
    for item in list {
        // Check if the dictionary already contains that value, then check if the value for that key matches the item key.
        if let existingValue = dict[item.1], existingValue == item.0 {
            // This returns the pairs found at the end of the list.
            // pairs.append(item)
            // This returns the pairs found first on the list.
            pairs.append((item.1, item.0))
        } else {
            dict[item.0] = item.1
        }
    }
    
    return pairs
}

// MARK: -
// LISTEN: Contains both positive and negative numbers, not just negative.
//         A subarray is a continuous section of the array, not a subset of elements.
// EXAMPLE: [6, 3, -1, -3, 4, -2, 2, 4, 6, -12, -7], index 2-4, 2-6, 5-6, 6-9, 0-10.
// BRUTE: 1. Loop through the list. Add the current element with each one ahead. If a 0 total is found, print the indexes.
//        Keep going to the next element until all values have been traversed. O(n^2)
// Given a list of numbers, print all subarrays with 0 sum.
func findSubarraysWithZeroTotalBrute(in list: [Int]) {
    var total: Int = 0
    
    for (i, item) in list.enumerated() {
        total = item
        //print("Starting total is: \(total).")
        var secondIndex: Int = 0
        for (j, val) in list.enumerated() {
            // We should only start counting from forward after the i position.
            // This ignores previous values we already looked at.
            if j > i {
                total += val
                secondIndex = j
                if total == 0 {
                    print("Subarray found from \(i) to \(secondIndex).")
                }
            }
        }
    }
}

// EXAMPLE: [6, 3, -1, -3, 4, -2, 2], 2-4, 2-6, 5-6.
// IMPLEMENT: Keep a running total as keys in a dictionary. If the sum does not exist, then add the sum as a
//            key and the current index as the value. If the sum does exist, that means that the next value after that position
//            to the current position would sum up to 0 (since it subtracts the same amount previously added),
//            so that indicates a subarray equaling 0.
func findSubarraysWithZeroTotal(in list: [Int]) {
    var sum: Int = 0
    var dict: [Int: [Int]] = [:]
    for (index, value) in list.enumerated() {
        sum += value
        // Each key represents the sum so far.
        if dict[sum] == nil {
            dict[sum] = [index]
        } else {
            // If the sum exists, then add the index for that total.
            dict[sum]?.append(index)
            dict[sum]?.forEach {
                if $0 != index {
                    print("Found a subarray from index \($0 + 1) to \(index).")
                }
            }
        }
    }
    
    // Check the entire list.
    if list.reduce(0, +) == 0 {
        print("Found a subarray from index 0 to \(list.count - 1).")
    }
}

findSubarraysWithZeroTotal(in: [6, 3, -1, -3, 4, -2, 2, 4, 6, -12, -7])
