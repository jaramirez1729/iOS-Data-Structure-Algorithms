//
//  TwoPointersPattern.swift
//  GrokkingTheCodingInterview
//
//  Created by J.A. Ramirez on 2/14/22.
//

import Foundation
import DequeModule

/*
 COMPLETED
 
 The two pointer approach uses 2 pointers in a list. There are various ways to use them. One case is to have one at the end and one at the start. Another case is to have 1 traverse the list and another keep a reference of a certain position to do something with it. Another case is to use a pointer in 2 different collection and compare each collection.
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
    
    // Prefill the array with zeroes so we can insert large numbers first going to smallest; also to avoid any invalid index errors.
    let listSize = list.count
    var squares = Array(repeating: 0, count: listSize)
    // The pointer that goes down from the top of the squares list. Used to determine the current position of where to put the next smallest square number.
    var highestSquareIndex = listSize - 1
    var leftPointer = 0 // Start from the beginning of the list.
    var rightPointer = listSize - 1 // Start from the end of the list.
    
    // Calculates square from both ends and determines which one to add next to the list. Since the list is already sorted, we know that the end result will be sorted already.
    while leftPointer <= rightPointer {
        let leftSquare = list[leftPointer] * list[leftPointer]
        let rightSquare = list[rightPointer] * list[rightPointer]
        // If the square of the smaller number is larger, then put it at the right-most side of the list first.
        if leftSquare > rightSquare {
            squares[highestSquareIndex] = leftSquare
            leftPointer += 1
        } else { // Same but if the square of the higher number is higher, put it at the right-most side of the list.
            squares[highestSquareIndex] = rightSquare
            rightPointer -= 1
        }
        highestSquareIndex -= 1
    }
    return squares
}

// MARK: - Triplet Sum Close to Target (Medium)
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
        // The current number is the "-X" target from the equation, so we need to start looking for Y + Z an index after the current position.
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
            triplets.append([-targetSum, list[leftIndex], list[rightIndex]]) // -targetSum undoes the negative value we passed in.
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
// Similar to the previous problem: sort the list first. 
// Time O(N * log N + N^2), Space O(N)
func tripletSumCloseToTarget(in list: [Int], targetSum: Int) -> Int {
    guard list.count > 2 else { return Int.max }
    
    let sortedList = list.sorted()
    var smallestDiff = Int.max
    
    for i in 0..<sortedList.endIndex {
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

// MARK: - Triplets with Smaller Sum (Medium)
/*
 Given an array arr of unsorted numbers and a target sum, count all triplets in it such that arr[i] + arr[j] + arr[k] < target where i, j, and k are three different indices. Write a function to return the count of such triplets.
 */
// Sorts the list first, and loops through the array with the first index. Then, do another loop using that index as the starting point to search for the other 2 indices that adds up to less than the targetSum. The targetSum is the target minus the current value at index i. This is because it makes searching easier instead of having to search for 3 values, the while loop only needs to search for 2 values.
// Time O(N * log N + n^2), Space O(N)
func tripletWithSmallerSum(in list: [Int], targetSum: Int) -> Int {
    guard list.count > 2 else { return 0 }
    
    let sortedList = list.sorted()
    var count = 0
    
    for i in 0..<sortedList.endIndex {
        // targetSum - sortedList[i] gives us a difference. So we only need to find 2 other indices
        // instead of 3 in the searchPair method since one of them is index i.
        count += searchPair(in: sortedList, targetSum: targetSum - sortedList[i], currentIndex: i)
    }
    return count
}

private func searchPair(in list: [Int], targetSum: Int, currentIndex: Int) -> Int {
    var count = 0
    var leftIndex = currentIndex + 1 // Since currentIndex is already our first index for the triplet, if valid.
    var rightIndex = list.endIndex - 1
    
    while leftIndex < rightIndex {
        if list[leftIndex] + list[rightIndex] < targetSum { // Found the triplet.
            // It's already gauranteed that list[leftIndex] + list[rightIndex] is less than the target sum, that means that any values between them will also be smaller than the target sum.
            count += rightIndex - leftIndex
            leftIndex += 1 // Try the next index.
        } else {
            rightIndex -= 1 // We need a pair with a smaller sum.
        }
    }
    
    return count
}

/* A similar question is: Write a function to return the list of all such triplets instead of the count. How will the time complexity change in this case?
 */
// Time O(N * log N + N^3), Space O(N)
func tripletsWithSmallerSum(in list: [Int], targetSum: Int) -> [[Int]] {
    guard list.count > 2 else { return [] }
    
    let sortedList = list.sorted()
    var triplets = [[Int]]()

    for i in 0..<sortedList.endIndex {
        searchPair(in: sortedList, targetSum: targetSum - sortedList[i], currentIndex: i, triplets: &triplets)
    }
    return triplets
}

private func searchPair(in list: [Int], targetSum: Int, currentIndex: Int, triplets: inout [[Int]]) {
    var leftIndex = currentIndex + 1 // Since currentIndex is already our first index for the triplet, if valid.
    var rightIndex = list.endIndex - 1
    
    while leftIndex < rightIndex {
        if list[leftIndex] + list[rightIndex] < targetSum { // Found the triplet.
            for i in stride(from: rightIndex, to: leftIndex, by: -1) {
                triplets.append([list[currentIndex], list[leftIndex], list[i]])
            }
            leftIndex += 1 // Try the next index.
        } else {
            rightIndex -= 1 // We need a pair with a smaller sum.
        }
    }
}

// MARK: - Subarrays with Product Less than a Target (Medium)
/*
 Given an array with positive numbers and a positive target number, find all of its contiguous subarrays whose product is less than the target number.
 */
// Utilizies the sliding window and two pointers approach. The sliding window is used because we cannot sort the list, and it will be used to loop through each value in the list. The start of the window is used to shrink it if the product becomes too high. 
// Time O(N^3), Space O(N^3)
func findSubarraysLessThanTarget(target: Int, in list: [Int]) -> [[Int]] {
    var result = [[Int]]()
    var product = 1
    var leftIndex = 0
    
    for rightIndex in 0..<list.endIndex {
        product *= list[rightIndex]
        // If the product is too high, keep dividing it by the next number from the start of the window until we get a valid product.
        while product >= target && leftIndex < list.count {
            product /= list[leftIndex]
            leftIndex += 1
        }
        
        // Since the product of all numbers from left to right is less than the target, then all subarrays from left to right will have a product less than the target too. To avoid duplicates, we will start with a subarray containing only the list[rightIndex] and extend it.
        var tempList = Deque<Int>()
        for i in stride(from: rightIndex, to: leftIndex - 1, by: -1) {
            tempList.prepend(list[i])
            result.append(Array(tempList))
        }
    }
    return result
}

// MARK: - Dutch National Flag Problem (Medium)
/*
 Given an array containing 0s, 1s and 2s, sort the array in-place. You should treat numbers of the array as objects, hence, we can’t count 0s, 1s, and 2s to recreate the array.

 The flag of the Netherlands consists of three colors: red, white and blue; and since our input array also consists of three different numbers that is why it is called Dutch National Flag problem.
 */
// Moves all 0s to the left, and all 2s to the right. The 1s will just end up in the middle unchanged.
// O(N), Space O(1)
func dutchFlagSort(_ list: inout [Int]) {
    // All elements less than lowPointer are 0, and all elements over highPointer are 2.
    var lowPointer = 0
    var highPointer = list.endIndex - 1
    
    var i = 0
    while i <= highPointer {
        if list[i] == 0 { // Swap at i with the lowPointer position.
            list.swapAt(i, lowPointer)
            i += 1
            lowPointer += 1
        } else if list[i] == 1 { // Do nothing, keep going.
            i += 1
        } else { // Swap at i with the highPointer position.
            list.swapAt(i, highPointer)
            highPointer -= 1
        }
        print(list)
    }
}

// MARK: - Problem Challenge 1: Quadruple Sum to Target (Medium)
/*
 Given an array of unsorted numbers and a target number, find all unique quadruplets in it, whose sum is equal to the target number.
 */
// Instead of having 4 nested loops, it has a nested loop that uses the 2 pointer approach to find 2 other numbers that add up to the given sum. This reduces the time from O^4 to O^3.
// Time O(N * log N + N^3), Space O(N)
func quadrupletsEqualToSum(sum: Int, in list: [Int]) -> [[Int]] {
    guard list.count > 3 else { return [] }
    
    let sortedList = list.sorted()
    var quadruplets = [[Int]]()
    
    for i in 0..<sortedList.endIndex - 3 {
        // Skip if it's the same number as before to avoid duplicate quadruplets.
        if i > 0 && sortedList[i] == sortedList[i - 1] { continue }
        
        for j in (i + 1)..<sortedList.endIndex - 2 {
            // Skip if it's the same number as before to avoid duplicate quadruplets.
            if j > i + 1 && sortedList[j] == sortedList[j - 1] { continue }
            
            // Now that we have an i and j, we only need to look for 2 other values that add up.
            searchPair(in: sortedList, targetSum: sum, firstIndex: i, secondIndex: j, quadruplets: &quadruplets)
        }
    }
    return quadruplets
}

private func searchPair(in list: [Int], targetSum: Int, firstIndex: Int, secondIndex: Int, quadruplets: inout [[Int]]) {
    var leftIndex = secondIndex + 1
    var rightIndex = list.endIndex - 1
    
    while leftIndex < rightIndex {
        let sum = list[firstIndex] + list[secondIndex] + list[leftIndex] + list[rightIndex]
        if sum == targetSum { // Found a quadruplet.
            quadruplets.append([list[firstIndex], list[secondIndex], list[leftIndex], list[rightIndex]])
            leftIndex += 1
            rightIndex -= 1
            
            while leftIndex < rightIndex && list[leftIndex] == list[leftIndex - 1] {
                leftIndex += 1 // Skip same elements from the left to avoid duplicatea.
            }
            while leftIndex < rightIndex && list[rightIndex] == list[rightIndex + 1] {
                rightIndex -= 1 // Skip same elements from the right to avoid duplicatea.
            }
        } else if sum < targetSum {
            leftIndex += 1 // We need a pair with a bigger sum.
        } else {
            rightIndex -= 1 // We need a pair with a smaller sum.
        }
    }
}

// MARK: - Problem Challenge 2: Comparing Strings containing Backspaces (Medium) 
/*
 Given two strings containing backspaces (identified by the character ‘#’), check if the two strings are equal.
 */
// Uses a 2-pointer approach for each string. 
// Time O(M + N), Space O(1)
func backspaceCompare(firstStr: String, with secondStr: String) -> Bool {
    // Looping both strings from the end because of the backspaces.
    var firstIndex = firstStr.count - 1
    var secondIndex = secondStr.count - 1
    
    while firstIndex >= 0 || secondIndex >= 0 {
        // Get the next valid index that is a character after the backspaces have been applied.
        let firstNextCharIndex = getNextValidCharIndex(in: firstStr, index: firstIndex)
        let secondNextCharIndex = getNextValidCharIndex(in: secondStr, index: secondIndex)
        
        // Reached the end of both strings.
        if firstNextCharIndex < 0 && secondNextCharIndex < 0 { return true }
        // Reached the end of one of the strings so we already know both strings aren't the same.
        if firstNextCharIndex < 0 || secondNextCharIndex < 0 { return false }
        // Check if both characters are the same.
        if firstStr[firstStr.index(firstStr.startIndex, offsetBy: firstNextCharIndex)] != secondStr[secondStr.index(secondStr.startIndex, offsetBy: secondNextCharIndex)] {
            return false
        }
        // Put the pointers at the next position after the valid character. 
        firstIndex = firstNextCharIndex - 1
        secondIndex = secondNextCharIndex - 1
    }
    return true
}

private func getNextValidCharIndex(in str: String, index: Int) -> Int {
    var backspaceCount = 0
    var nextIndex = index
    
    while nextIndex >= 0 {
        if str[str.index(str.startIndex, offsetBy: nextIndex)] == "#" {
            backspaceCount += 1 // Found a backspace character.
        } else if backspaceCount > 0 {
            backspaceCount -= 1 // A non-backspace character.
        } else {
            break
        }
        nextIndex -= 1 // Skip a backspace or a valid character.
    }
    return nextIndex
}

// MARK: - Problem Challenge 3: Minimum Window Sort (Medium)
/*
 Given an array, find the length of the smallest subarray in it which when sorted will sort the whole array.
 */
// Uses 2 pointers. One at the start and one at the end. It finds the first instances in which the numbers are not sorted from both ends. Then, it gets the maximum and minimum of the subarray in order to extend the pointers because there might 
// Time O(N), Space O(1)
func ShortestWindowSort(for list: [Int]) -> Int {
    var lowIndex = 0
    var highIndex = list.endIndex - 1
    // Find the first number out of sorting order from the beginning.
    while lowIndex < highIndex && list[lowIndex] <= list[lowIndex + 1] { lowIndex += 1 }
    if lowIndex == highIndex { return 0 } // Then the array is already sorted.
    // Find the first number out of sorting order from the end.
    while highIndex > 0 && list[highIndex] >= list[highIndex - 1] { highIndex -= 1 }
    
    // Swift error if the range is not valid.
    guard lowIndex <= highIndex else { return 0 }
    // The max and min of the subarray.
    let subarrayMax = list[lowIndex...highIndex].max()
    let subarrayMin = list[lowIndex...highIndex].min()
    guard let max = subarrayMax, let min = subarrayMin else { return 0 }

    // Because the entire array might still be out of order after ordering the subarray, we need to extend the pointers back out.
    // Extend the subarray to include any number which is bigger than the minimum of the subarray.
    while lowIndex > 0 && list[lowIndex - 1] > min { lowIndex -= 1 }
    // Extend the subarray to include any number which is smaller than the maximum of the subarray.
    while highIndex < list.endIndex - 1 && list[highIndex + 1] < max { highIndex += 1 }
    
    return highIndex - lowIndex + 1
}
