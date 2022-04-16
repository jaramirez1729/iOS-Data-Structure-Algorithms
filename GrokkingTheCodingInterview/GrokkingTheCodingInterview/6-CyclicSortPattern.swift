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
    let listSize = mList.count
    
    // Sort the elements first into their respective indices.
    while traversalIndex < listSize {
        let expectedIndex = mList[traversalIndex]
        // Less than listSize since the listSize value would be out of bounds for a valid array from 0..<n. If it's n, it will leave it alone to wherever it ends up after the rest of the list sorts itself.
        if expectedIndex < listSize && mList[traversalIndex] != mList[expectedIndex] {
            mList.swapAt(traversalIndex, expectedIndex)
        } else {
            traversalIndex += 1
        }
    }
    
    // Now that the list has been sorted, there is 1 number that was left in the wrong location because the array is not large enough to contain it.
    for i in 0..<listSize {
        if mList[i] != i { return i }
    }
    
    return listSize
}

// MARK: - Find all Missing Numbers (Easy)
/*
 We are given an unsorted array containing numbers taken from the range 1 to ‘n’. The array can have duplicates, which means some numbers will be missing. Find all those missing numbers.
 */
// If there is a 1, then it will be in position 0. So index 0 => 1.
// If 3 is in position 1, then the expected index for 3 is 2 since index 2 => 3
// We use a pointer to go down the list. Check if the current number is not in the right position. If it's not, swap the values. If it is, then increase the pointer and keep going. Then, check the sorted list for any value that does not match [i]=i + 1.
// Time O(N), Space O(N)
func findAllMissingNumber(in list: [Int]) -> [Int] {
    var traversalIndex = 0
    var mList = list
    var missingNumbers = [Int]()
    
    while traversalIndex < mList.count {
        // Since each number is in the n - 1, the expected index for any of the values will be in the n - 1 position.
        let expectedIndex = mList[traversalIndex] - 1
        // If the value in the current position does not equal to the expected value, then sort it.
        if mList[traversalIndex] != mList[expectedIndex] {
            mList.swapAt(traversalIndex, expectedIndex)
        } else {
            traversalIndex += 1
        }
    }
    
    for i in 0..<mList.count {
        if mList[i] != i + 1 {
            missingNumbers.append(i + 1)
        }
    }
    
    return missingNumbers
}

// MARK: - Find the Duplicate Number (Easy)
/*
 We are given an unsorted array containing ‘n + 1’ numbers taken from the range 1 to ‘n’. The array has only one duplicate but it can be repeated multiple times. Find that duplicate number without using any extra space. You are, however, allowed to modify the input array.
 */
// Since the numbers are from 1 to N, that means list[0] = 1
// 
// Time O(N), Space O(N)
func findDuplicateNumber(in list: [Int]) -> Int {
    var traversalIndex = 0 // Pointer that goes down the list.
    var mList = list
    
    while traversalIndex < mList.count {
        // Check if the current number is not in the right position. [i] != i + 1
        if mList[traversalIndex] != traversalIndex + 1 {
            let expectedIndex = mList[traversalIndex] - 1 // The expected index of the number in the wrong spot.
            // Swap and put the numbers in the right place if they are not. If this condition fails, it means that the current number is already in the expected position, and thus is a duplicate.
            if mList[traversalIndex] != mList[expectedIndex] {
                mList.swapAt(traversalIndex, expectedIndex)
            } else {
                return mList[traversalIndex]
            }
        } else {
            traversalIndex += 1
        }
    }
    
    // Should never happen if there is valid input.
    return -1
}

// MARK: Similar Problem 1: Can we solve the above problem in without modifying the input array?
// We can use the Slow and Fast pointer approach to find the cycle.
func findDuplicateNumberCycle(in list: [Int]) -> Int {
    guard list.count > 0 else { return -1 }
    
    var slow = list[0]
    var fast = list[list[0]]
    // Don't need to increment in the loop since the values themselves are i + 1 from the ith position. They are essentially incrementing themselves.
    while slow != fast {
        slow = list[slow]
        fast = list[list[fast]]
    }
    // Find the cycle lenght.
    var current = list[list[slow]]
    var cycleLength = 1
    while current != list[slow] {
        current = list[current]
        cycleLength += 1
    }
    return slow
    //return findCycleStart(in: list, lenght: cycleLength)
}

// Doesn't seem like this is needed.
//func findCycleStart(in list: [Int], lenght: Int) -> Int {
//    var mLenght = lenght
//    var pointer1 = list[0]
//    var pointer2 = list[0]
//    while mLenght > 0 {
//        pointer2 = list[pointer2]
//        mLenght -= 1
//    }
//    while pointer1 != pointer2 {
//        pointer1 = list[pointer1]
//        pointer2 = list[pointer2]
//    }
//    return pointer1
//}

// MARK: - Find All Duplicate Numbers (Easy)
/*
 We are given an unsorted array containing n numbers taken from the range 1 to n. The array has some numbers appearing twice, find all these duplicate numbers using constant space.
 */
// The number 1 will be at index 0, so list[0] = 1. That means that the expected index for a given n is at n - 1.
// Sort the numbers into their final positions, then just check which ones don't meet the condition.
// Time O(N), Space O(1)
func findAllDuplicateNumbers(in list: [Int]) -> [Int] {
    var traverseIndex = 0
    var mList = list
    while traverseIndex < mList.count {
        // The expected index for the current number.
        let expectedIndex = mList[traverseIndex] - 1
        // Check if the number in mList[traverseIndex] is already in the final position. If not, swap them.
        if mList[traverseIndex] != mList[expectedIndex] {
            mList.swapAt(traverseIndex, expectedIndex)
        } else {
            traverseIndex += 1
        }
    }
    
    // Get all the numbers in the wrong position.
    var duplicateNumbers = [Int]()
    for i in 0..<mList.count {
        if mList[i] != i + 1 {
            duplicateNumbers.append(mList[i])
        }
    }
    
    return duplicateNumbers
}

// MARK: - Problem Challenge 1: Find the Corrupt Pair (Easy)
/*
 We are given an unsorted array containing ‘n’ numbers taken from the range 1 to ‘n’. The array originally contained all the numbers from 1 to ‘n’, but due to a data error, one of the numbers got duplicated which also resulted in one number going missing. Find both these numbers.
 */
// The number at index 0 will be 1, so list[index] = index + 1.
// Sort the list as usual to put each number in their final position. Then, check the list for the value that is not in the final position. The number in that position will be the duplicate, and the index + 1 value will be the mising number.
// Time O(N), Space O(N)
func findCorruptPair(in list: [Int]) -> [Int] {
    var traverseIndex = 0
    var mList = list
    
    while traverseIndex < mList.count {
        // The expected index for the number in traverseIndex.
        let expectedIndex = mList[traverseIndex] - 1
        // Check if the number in traverseIndex is already in its final position. If not, swap them.
        if mList[traverseIndex] != mList[expectedIndex] {
            mList.swapAt(traverseIndex, expectedIndex)
        } else {
            traverseIndex += 1
        }
    }
    
    for i in 0..<mList.count {
        if mList[i] != i + 1 {
            return [mList[i], i + 1]
        }
    }
    
    return [-1, -1]
}

// MARK: - Problem Challenge 2: Find the Smallest Missing Positive Number (Medium)
/*
 Given an unsorted array containing numbers, find the smallest missing positive number in it.
 
 Note: Positive numbers starts from '1'.
 */
// We can use cyclic sort to sort the list, and put the positive values in their final position while ignoring all the other values. Since positive numbers start at 1, we can try to put it in index 0 (n - 1), etc. Since we have to find the missing number, after the sort, we just check the list for the value that is in the wrong position.
// Time O(N), Space O(N)
func findMinMissingPositiveNumber( in list: [Int]) -> Int {
    var traverseIndex = 0
    var mList = list
    
    while traverseIndex < mList.count {
        // The number should be at the index that is 1 less than it.
        let expectedIndex = mList[traverseIndex] - 1
        // We only put it in its final position if it's a positive number within the array bounds. If the value is not in its final position, then we will swap the values. The array will eventually contain all positive numbers in their respective locations.
        if mList[traverseIndex] > 0 
            && mList[traverseIndex] <= mList.count 
            && mList[expectedIndex] != mList[traverseIndex] {
            mList.swapAt(expectedIndex, traverseIndex)
        } else {
            traverseIndex += 1
        }
    }
    
    for i in 0..<mList.count {
        if mList[i] != i + 1 {
            return i + 1
        }
    }
    
    return mList.count + 1
}

// MARK: - Problem Challenge 3: Find the First K Missing Positive Numbers (Hard)
/*
 Given an unsorted array containing numbers and a number ‘k’, find the first ‘k’ missing positive numbers in the array.
 */
func findMissingPositiveNumbers(in list: [Int], ofSize k: Int) -> [Int] {
    
}
