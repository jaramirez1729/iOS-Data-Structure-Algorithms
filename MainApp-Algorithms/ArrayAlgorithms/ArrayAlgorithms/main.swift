//
//  main.swift
//  ArrayAlgorithms
//
//  Created by Jozeee on 1/11/20.
//  Copyright © 2020 AdaloveSoftware. All rights reserved.
//

// MARK: - 2020 Questions
// Find the 2nd minimum element of an array.
// Find the first non-repeating integers in an array.
// Merge two sorted arrays.
// Given an array, return the number of non-zero elements.
// Given an array, move the non-zero elements to the beginning of the array.
// Given a string, return back all permutations.
// Implement a method that shifts an array to the left by n times.
// Loop through an array backwards using an index.
// Given a list of heights behind each other, return back the indexes in order of the buildings that can see the ocean: [] ~~~~
// Given an array that can contain integers/arrays, calculate the array depth.

// Algorithms to Implement:
// Merge Sort: A divide-and-conquer algorithm. Divides the array into 2 halves, and then calls itself for the 2 halves
// and then merges the two sorted halves. It keeps splitting up in half until only a single element are left in each array
// and then merges those in order.

// Quicksort: A divide-and-conquer algorithm. It chooses a pivot that splits the array into 2. Reorder the array based
// on the pivot. Then apply the same steps to the sub arrays before and after the pivot. The first part involves partitioning.
// Compare with the first element until you switch enough for that element to end in the middle as the pivot.

// MARK: - 2021 Questions
// Reverse an array.
// Given a list with n - 1 integers from 1 to n with no duplicates, find the missing number from the list.
// Find the minimum number of jumps needed to reach the end of a list from the start.

// MARK: -
// Find the 2nd minimum element of an array.
// O(n * log(n)): Because of the sort function.
// Space O(n)
func findSecondMinimumElementBrute(in nums: [Int]) -> Int? {
    // If the size is less than 2, then return nil.
    guard nums.count > 1 else { return nil }
    
    // First, convert it into a set to reduce duplicates.
    var uniqueNums = Array(Set(nums))
    
    // There is no point in sorting if all the elements were the same since it will only leave 1 element after the Set removed duplicates.
    if uniqueNums.count == 1 { return nil }
    uniqueNums.sort(by: <) // n * log(n) where n is the size of the array.
    return uniqueNums[1]
}


// MARK: -
// Find the 2nd minimum element of an array.
// O(n): Faster than the brute force one above.
// Space O(n)
func findSecondMinimumElementLinear(in nums: [Int]) -> Int? {
    // If the size is less than 2, then return nil.
    guard nums.count > 1 else { return nil }
    
    // First, convert it into a set to reduce duplicates.
    let uniqueNums: [Int] = Array(Set(nums))
    
    // There is no point in sorting if all the elements were the same since it will only leave 1 element
    // after the set removed duplicates.
    if uniqueNums.count == 1 { return nil }
    
    let min: Int = uniqueNums.min() ?? 0 // O(n)
    var secondMinNum: Int = uniqueNums.max() ?? 0 // O(n)
    // O(n)
    for num in uniqueNums {
        if num > min && num < secondMinNum {
            secondMinNum = num
        }
    }
    
    return secondMinNum
}


// MARK: -
// Find the non-repeating integers in an array.
// O(n + u + k)
// Space O(n)
func findNonRepeatingIntegers(in list: [Int]) -> [Int] {
    // The key is the number and value is the number of times it repeats.
    var dict: [Int: Int] = [:]
    // Add to the dictionary each unique value where the default count is 0.
    list.forEach({ dict[$0, default: 0] += 1 }) // O(n) where n is the size of the list.
    // Remove all keys that have a value greater than 1.
    return dict.filter({ $0.value == 1 }).map({ $0.key })
}

//print(findNonRepeatingIntegers(in: [1, 2, 3, 4, 3, 2, 1, 2, 12, 3, 2, 5, 7, 8]))

// MARK: -
// Find the non-repeating integers in an array.
func findNonRepeatingIntegersFilter(in list: [Int]) -> [Int] {
    var dict: [Int: Int] = [:]
    list.forEach({ dict[$0, default: 0] += 1 })
    return dict.filter({ $0.value == 1 }).map({ $0.key })
}


// MARK: -
// Merge 2 sorted arrays.
// O(n^2) if both arrays are the same size, otherwise it's O(a*b).
func mergeSortedArraysBrute(firstNums: [Int], secondNums: [Int]) -> [Int] {
    var sortedMerged: [Int] = []
    // Stores the last position that was checked in the 2nd array to prevent repetition.
    var bStart: Int = 0
    // The size of the inner loop gets smaller each iteration. Let b represent the count of the inner loop for
    // items that are looked in. Let a be the size of the first loop. So O(a*b) which is still not optimal.
    for a in 0..<firstNums.count {
        for b in bStart..<secondNums.count {
            if firstNums[a] <= secondNums[b] {
                sortedMerged.append(firstNums[a])
                bStart = b
                // Add the last element of the 2nd array.
                if a == firstNums.count - 1 && bStart == secondNums.count - 1 {
                    sortedMerged.append(secondNums[bStart])
                }
                break
            } else if secondNums[b] < firstNums[a] {
                sortedMerged.append(secondNums[b])
            }
        }
    }
    return sortedMerged
}


// MARK: -
// Merge 2 sorted arrays.
// O(n * log(n))
func mergeSortedArrays(firstNums: [Int], secondNums: [Int]) -> [Int] {
    return (firstNums + secondNums).sorted()
}


// MARK: -
// Merge Sort: A divide-and-conquer algorithm. Recursively divides the array into 2 parts until it can't anymore. Then sorts
// back those arrays with each other and returns them to then again be sorted.
func mergeSort(_ nums: [Int]) -> [Int] {
    if nums.count == 1 { return nums }
    
    // Get the center index to split the array into 2 by the middle index.
    let middleIndex: Int = nums.count / 2
    let leftNums: [Int] = Array(ArraySlice(nums[0..<middleIndex]))
    let rightNums: [Int] = Array(ArraySlice(nums[middleIndex..<nums.count]))
    
    // Keep splitting the arrays down.
    let splitLeft = mergeSort(leftNums)
    let splitRight = mergeSort(rightNums)
    
    // After the arrays can't be split anymore, then compare each one and return back a sorted array of the 2.
    return (splitLeft + splitRight).sorted() // O(n * log(n))
}


// MARK: -
// Quicksort: A divide-and-conquer algorithm. It chooses a pivot that splits the array into 2. Reorder the array
// based on the pivot. Then apply the same steps to the sub arrays before and after the pivot. The first part
// involves partitioning.
// O(n) where n is the number of elements.
func quicksort(_ list: inout [Int], low: Int, high: Int) {
    // First, make sure that the range is valid.
    if low < high {
        // Get the pivot index.
        let pivot: Int = partition(&list, low: low, high: high)
        // Recursively partition the array to the left side of the pivot.
        quicksort(&list, low: low, high: pivot - 1)
        // Recursively partition the array to the right side of the pivot.
        quicksort(&list, low: pivot + 1, high: high)
    }
}

func partition(_ list: inout [Int], low: Int, high: Int) -> Int {
    // Take the last element as the pivot.
    let pivotItem: Int = list[high]
    // Create an index of the smaller element - 1 because the loop will increment it.
    var i = low - 1
    var j: Int = low
    
    while j <= high - 1 {
        // If the current element is smaller than the pivot item, switch them.
        if list[j] < pivotItem {
            i += 1
            list.swapAt(i, j)
        }
        j += 1
    }
    // If the i + 1 is equal to high, then they don't switch.
    list.swapAt(i + 1, high)
    return i + 1
}


// MARK: -
// Given an array, return the number of non-zero elements. [23, 0, -12, 0, 0]
// O(n) where n is the number of elements.
func numberOfNonZero(in list: [Int]) -> Int {
    return list.filter({ $0 != 0 }).count
}


// MARK: -
// Given an array, move the non-zero elements to the beginning of the array.
// O(n) where n is the number of elements in the list.
func moveNonZeroToBeginning(in list: [Int]) -> [Int] {
    var newList: [Int] = list
    newList.forEach({
        if $0 == 0 {
            newList.insert(0, at: 0)
            if let i = newList.lastIndex(of: $0) {
                newList.remove(at: i)
            }
        }
    })
    return newList
}


// MARK: -
// Given a string, return back all permutations.
func permutateString(_ str: String) {
    var mStr: String = str
    permutate(&mStr, 0, str.count - 1)
}

// O(n * n!) where n is the number of characters. It takes n times to print a value and n! times for permutations.
private func permutate(_ str: inout String, _ startIndex: Int, _ endIndex: Int) {
    // Once the left index matches the right index, it means there is nothing more
    // to switch, so print the string.
    if startIndex == endIndex {
        print(str)
    } else {
        // Start a loop beginning with the next start index until it reaches the end.
        // This ensures that characters that are under the start index are fixed and not touched.
        for i in startIndex...endIndex {
            // Change the characters beginning with the starting index to the next one until the end is reached.
            str = swapCharacters(in: str, startIndex, i)
            // Recursive call to the next set of characters starting + 1 more to not touch fixed characters.
            // This will cause the recursive tree to grow on one side until it can't anymore.
            permutate(&str, startIndex + 1, endIndex)
            // Undue the swap so the next loop can start again where it previously left off with the fixed
            // indexes untouched and can then create its permutations. This is to have the original configuration
            // for the next loop.
            str = swapCharacters(in: str, startIndex, i)
        }
    }
}

private func swapCharacters(in str: String, _ l: Int, _ r: Int) -> String {
    var characters: [String.Element] = Array(str)
    guard characters[l] != characters[r] else { return str }
    characters.swapAt(l, r)
    return String(characters)
}


// MARK: -
// Implement a method that shifts an array to the left by n times.
// Listen
// Example [3, 4, 123, 5] -> [3, 4, 123, 5, 3, 4] -> [123, 5, 3, 4]
// Example [1, 2, 3] -> [1, 2, 3, 1, 2] -> [3, 1, 2]
// Brute Force
// Optimize (Bottlenecks? Unnecessary work? Duplicate work?)
// O(n) where n is the number of times to shift.
func leftShiftArray(_ list: [Int], by shift: Int) -> [Int] {
    guard shift >= 0 else { return [] }
    guard list.count > 1 else { return list }
    
    var shiftedList: [Int] = list
    for _ in 1...shift {
        shiftedList.append(shiftedList[0])
        shiftedList.remove(at: 0)
    }
    return shiftedList
}


// MARK: -
// Loop through an array backwards using an index.
func backwardLoop(_ list: [Int]) {
    for i in (0..<list.count).reversed() {
        print(list[i])
    }
    
    // Using stride(from: a, through: b, by: -1)
    for i in stride(from: list.count - 1, through: 0, by: -1) {
        print(list[i])
    }
}


// MARK: -
// Given a list of heights behind each other, return back the indexes in order of the buildings that can see the ocean
// Example: [2, 2, 1, 3, 2, 1] ~~~~ ; should return [3, 4, 5]
func indexOfOceanViews(from heights: [Int]) -> [Int] {
    guard !heights.isEmpty else { return [] }
    
    // We only need to loop until the index of the highest element is reached.
    let highestHeight: Int = heights.max() ?? 0
    let lowerIndex: Int = heights.lastIndex(of: highestHeight) ?? 0
    
    var highestFound: Int = heights[heights.count - 1]
    var indexes: [Int] = []
    
    // Add the last element since it's in front of the ocean.
    indexes.append(heights.count - 1)
    for i in (lowerIndex...heights.count - 2).reversed() {
        if heights[i] > highestFound {
            indexes.append(i)
            highestFound = heights[i]
        }
    }
    
    return indexes.reversed()
}

// Given an array that can contain integers/arrays, calculate the array depth.
// LISTEN; EXAMPLE [1, 2, [3, 4], 5] = (1+2) + 2(3+4) + 5 = 22
func getDepth(from list: [Any], multiplier: Int = 1) -> Int {
    guard !list.isEmpty else { return 0 }
    var total: Int = 0
    for item in list {
        if let num = item as? Int {
            total += num
        } else if let nums = item as? [Any] {
            total += getDepth(from: nums, multiplier: multiplier + 1)
        }
    }
    return total * multiplier
}

// (1+2)+2(3+3(4+4))+5 = 3+2(3+3(8))+5 = 3+2(3+24)+5 = 3+2(27)+5 = 3+54+5 = 62
//print(getDepth(from: [1, 2, [3, [4, 4]], 5]))

// Given an array of integers, return true or false if 2 numbers exist such that they equal the target number.
func findDifference(ofTarget target: Int, in list: [Int]) -> Bool {
    for num in list {
        let diff = num - target
        if list.contains(diff) {
            return true
        }
    }
    return false
}

// MARK: -
// LISTEN, EXAMPLE, BRUTE (BCR), OPTIMIZE, IMPLEMENT, TEST
// [2, 3, 4, 1, 5, 3, 7, 4, 9, 124, -4]; [1, 2]
// O(n)
// Reverse an array.
func reverseArray(_ array: [Int]) -> [Int] {
    guard array.count > 1 else { return array }
    
    var reversedArray: [Int] = array
    var startIndex: Int = 0
    var lastIndex: Int = reversedArray.count - 1
    
    while startIndex < lastIndex {
        reversedArray.swapAt(startIndex, lastIndex)
        startIndex += 1
        lastIndex -= 1
    }
    
    return reversedArray
}

// MARK: -
// LISTEN, EXAMPLE, BRUTE (BCR), OPTIMIZE, IMPLEMENT, TEST
// [8, 5, 3, 2, 4, 12, 10, 1, 6, 9, 13, 11]
// 1. Sort the array, and then find the missing number. O(n*Log(n))
// 2. Create a new array from 1 to n with a conv. init. Compare the lists and see what's missing. O(n) + O(n)
// 3. OPTIMIZE: [3, 2, 1, 5]. The total must be 1+...+n, but we only know part of the total.
// Given a list with n - 1 integers from 1 to n with no duplicates, find the missing number from the list.
func findMissingNumber(in list: [Int]) -> Int {
    let listTotal: Int = list.reduce(0, +)  // O(n)
    // While this gives the total, it's not very efficient.
    // let correctTotal: Int = Array(1...list.count + 1).reduce(0, +)  // O(n)
    
    // OPTIMIZE: The supposed total can be found using the formula: [n * (n + 1)]/ 2
    let n: Int = list.count + 1
    let correctTotal: Int = (n * (n + 1)) / 2
    return correctTotal - listTotal
}

// MARK: -
// LISTEN: The jump does not have to specifically end exactly at the last element, it can go past it.
//         You can choose what to jump to if the steps allow you to.
// EXAMPLE: [1, 3, 5, 8, 9, 2, 6, 7, 6, 8, 9]; 3 steps (1 -> 3 -> 8/9) since 8/9 will go past the list.
//          [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1], 10 steps.
// BRUTE: Get the choices given. Always choose the last number that is allowed by the step.
// OPTIMIZE: Get the choices given. Always choose the largest number that is allowed by the step.
// IMPLEMENT,
// Find the minimum number of jumps needed to reach the end of a list from the start.
/* Given an array of integers where each element represents the max number of steps that can be made forward from that element.
 Write a function to return the minimum number of jumps to reach the end of the array (starting from the first element).
 If an element is 0, they cannot move through that element. If the end isn’t reachable, return -1. */
func minimumStepsToReachEnd(of list: [Int]) -> Int {
    guard list.count > 0 else { return 0 }
    
    var steps: Int = 0
    // We will keep checking from this the more we advance.
    let jumpsUntilEnd: Int = list.count - 1
    // To know how many steps we took already to check against the end.
    var jumpsTaken: Int = 0
    // To track where we are in the list.
    var jumpIndex: Int = 0
    // The first jump size we can do is based on the first element, where we start.
    var jumpSize: Int = list[jumpIndex]
    
    // If the difference between how far we've gone and how many steps have been taken is greater than 0, we are not done yet.
    while (jumpsUntilEnd - jumpsTaken) > 0 {
        // We have to check first if (jumpIndex + jumpSize) will exceed the list or not. If it does, that is another step.
        // This also prevents the next line from going out of bounds.
        if !list.indices.contains(jumpIndex + jumpSize) {
            return steps + 1
        }
        
        let possibleJumps: [Int] = Array(list[(jumpIndex + 1)...(jumpIndex + jumpSize)])
        let possibleIndexes: [Int] = Array((jumpIndex + 1)...(jumpIndex + jumpSize))
        // Create a dictionary with the index being the key so we know what the position is when we chose a jump.
        var possibleChoices: [Int: Int] = [:]
        for i in 0..<possibleJumps.count {
            possibleChoices[possibleIndexes[i]] = possibleJumps[i]
        }
        // Get the largest value from the possible jumps.
        jumpSize = possibleJumps.max() ?? 0
        
        if jumpSize == 0 {
            // If the only possible value is 0, that means we cannot proceed further.
            return -1
        } else {
            // Get all the values from the dictionary that match the new jumpSize, and pick the one with the biggest index.
            // We pick the one with the biggest index so we advance farther on the list faster.
            let indexes: [Int] = possibleChoices.filter { $1 == jumpSize }.map { $0.0 }
            let jumpSizeIndex = indexes.max() ?? 0
            jumpsTaken += jumpSizeIndex - jumpIndex
            jumpIndex = jumpSizeIndex
            steps += 1
        }
    }
    
    return steps
}
