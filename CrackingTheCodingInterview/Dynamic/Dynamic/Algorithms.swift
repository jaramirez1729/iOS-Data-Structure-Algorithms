//
//  Algorithms.swift
//  Dynamic
//
//  Created by J.A. Ramirez on 12/28/21.
//

import Foundation
import CoreImage

// MARK: - Triple Steps
/*
 A child is running up a staircase with n steps and can hop either 1 step, 2 steps, or 3 steps at a time. Implement a method to count how many possible ways the child can run up the stairs.
 
 Hints:
 - Approach this from the top down. What is the very last hop the child made?
 - If we knew the number of paths to each of the steps before step 100, could we compute the number of steps to 100?
 - We multiply the values when it's "we do this then this." We add them when it's "we do this or this."
 - What is the runtime of this method? Think carefully. Can you optimize it?
 - Try memoization as a way to optimize an inefficient recursive program.
 */
// LEBOWITS
// Sounds like a permutation problem. How many ways can you make N using 1s, 2s, and 3s?
// N = 1 -> [1] = 1 path
// N = 2 -> [1, 1], [2] = 2 paths
// N = 3 -> [1, 1, 1], [1, 2], [2, 1], [3] = 4 paths
// N = 4 -> [1, 1, 1, 1], [2, 1, 1], [1, 2, 1], [1, 1, 2], [2, 2], [1, 3], [3, 1] = 7 paths
// N = 5 -> [....] = 13 paths
// Brute: Make recursive calls to values of 1, 2, and 3 being removed from N. When it reaches 0, we found a permutation. Return that list, and continue again for the next number.
// N = 3
// f(3); i = 1; 3 - 1 = 2           [1]
//          i = 1; 2 - 1 = 1         [1]
//              i = 1; 1 - 1 = 0 => [1, 1, 1]
//          i = 2; 2 - 2 = 0 => [1, 2]
//        i = 2; 3 - 2 = 1
//          i = 1; 1 - 1 = 0 => [2, 1]
//        i = 3; 3 - 3 = 0 => [3]
// Answer: [1, 1, 1], [1, 2], [2, 1], [3]
//
func tripleStepsBrute(_ steps: Int) -> Int {
    var paths = [[Int]]()
    var tempPath = [Int]()
    countSteps(steps, paths: &paths, currentPath: &tempPath, step: 0)
    return paths.count
}

func countSteps(_ stepsRemaining: Int, paths: inout [[Int]], currentPath: inout [Int], step: Int) {
    // If it's negative, then return nothing.
    guard stepsRemaining > -1 else { return }
    
    if stepsRemaining == 0 {
        // If the steps are 0, then we reached a successful path.
        paths.append(currentPath)
    } else {
        // Looping from 1 to 3 ensures we only decrease the steps in increments of 1, 2, and 3 recursively.
        for skip in 1...3 {
            // Add the current value since we are still in a valid path.
            currentPath.append(skip)
            countSteps(stepsRemaining - skip, paths: &paths, currentPath: &currentPath, step: skip)
            // Remove the last value to backtrack.
            currentPath.removeLast()
        }
    }
}

// The above solution takes too much space. We don't actually need to record the paths that were traveled, instead we can just keep a count of the paths that were successful - as in paths that reached 0. This is still a bottom-up approach.
func tripleStepsBrute2(_ steps: Int) -> Int {
    var paths = 0
    countSteps(steps, paths: &paths)
    return paths
}

func countSteps(_ stepsRemaining: Int, paths: inout Int) {
    guard stepsRemaining > -1 else { return }
    if stepsRemaining == 0 {
        paths += 1
    } else {
        for skip in 1...3 {
            countSteps(stepsRemaining - skip, paths: &paths)
        }
    }
}

// Book Solution: Think from the top down. To get to the last step, the kid must've stepped 1, 2 or 3. So we know we will have countWays(n - 1) + countWays(n - 2) + countWays(n - 3). We just build up the total from the top-down. We can use an array to store the previously calculated values to avoid making additional recursive calls into an array.
func tripleSteps(_ steps: Int) -> Int {
    // Base case will always be 1.
    var cache: [Int: Int] = [1: 1]
    return countTripleSteps(steps, cache: &cache)
}

func countTripleSteps(_ steps: Int, cache: inout [Int: Int]) -> Int {
    if steps < 0 {
        return 0
    } else if steps == 0 {
        return 1
    } else if let storedCount = cache[steps] {
        // If we have previously stored the result for that step, return it.
        return storedCount
    } else {
        // Store the calculated result so we don't compute it again.
        cache[steps] = countTripleSteps(steps - 1, cache: &cache) + 
                          countTripleSteps(steps - 2, cache: &cache) + 
                          countTripleSteps(steps - 3, cache: &cache)
        return cache[steps]!
    }
}

// MARK: - Robot in a Grid
/*
 Imagine a robot sitting on the upper left corner of grid with r rows and c columns. The robot can only move in two directions, right and down, but certain cells are "off limits" such that the robot cannot step on them. Design an algorithm to find a path for the robot from the top left to the bottom right.
 */
// LEBOWITS
// Example: 4x4 [row][column]; A "x" is not an accessible square. A "o" is accessible.
//  |r |  |x |  |
//  |  |  |  |x |
//  |  |  |x |  |
//  |x |  |  |e |
//
// Brute: Check if the robot can move right, and if it can, move right. Keep going until it hits a cell it can't move. Check if it can move down. if yes, move down. If it can't move down, backtrack to the last time before they moved right and down. We signify this as a dead-end. Repeat the process until eventually the robot is at the required square.
// Starting position is always [0][0]
// Going right means going [a][b + 1]
// Going down means [a + 1][b]
// We need to know the current position, and we need a reference to the grid.
// Optimize (BUD): 
// Walkthrough: f(grid, position)
// f(grid, (0, 0))
// Can we go to (0, 0 + 1)? Yes, go there. f(grid, (0, 1))
//      Can we go to (0, 1 + 1)? No. Check below.
//      Can we go to (0 + 1, 1)? Yes. go there. f(grid, (1, 1))
//              Can we go to (1, 1 + 1)? Yes. go there. f(grid, (1, 2))
//                      Can we go to (1, 2 + 1)? No. Check below.
//                      Can we go to (1 + 1, 2)? No. Backtrack, and check below.
//              Can we go to (1 + 1, 1)? Yes, go there. f(grid, (2, 1))
//              ...
//              Keep checking going right and then down,recursively.
//              Can we go to (3, 3)? Yes. go there. Is it the last grid position? Yes. We are done.
// Returning true ensures that the recursion does NOT keep going even after finding a solution.
//
// It's possible that the robot might visit a square that it previously has before if the path guides them there again. We can keep a reference.
@discardableResult
func moveRobotInGrid(_ grid: inout [[String]], pos: (row: Int, col: Int)) -> Bool {
    guard grid.indices.contains(pos.row) && grid[pos.row].indices.contains(pos.col) else { return false }
    
    grid[pos.row][pos.col] = "🤖"
    
    // Check if the current position is the target one.
    if pos.row == grid.count - 1 && pos.col == grid[pos.row].count - 1 {
        for row in grid { print(row) }
        print("Successfully reached the end at position (\(pos.row), \(pos.col)).")
        return true
    }
    
    // Check if the square to the right is accessible.
    let moveRightPos = (pos.row, pos.col + 1)
    if checkIfPossiblePath(grid, pos: moveRightPos) && moveRobotInGrid(&grid, pos: moveRightPos) {
        return true
    }
    
    // Check if the square to the bottom is accessible.
    let moveDownPos = (pos.row + 1, pos.col)
    if checkIfPossiblePath(grid, pos: moveDownPos) && moveRobotInGrid(&grid, pos: moveDownPos) {
        return true
    }
    
    grid[pos.row][pos.col] = "  "
    return false
}

func checkIfPossiblePath(_ grid: [[String]], pos: (row: Int, col: Int)) -> Bool {
    grid.indices.contains(pos.row) 
    && grid[pos.row].indices.contains(pos.col) 
    && grid[pos.row][pos.col] != "❌"
}

// MARK: - Magic Index
/*
 A magic index in an array A[1...n-1] is defined to be an index such that A[i] = i. Given a sorted array of distinct integers, write a method to find a magic index, if one exists, in array A.
 */
// [-10, -5, 0, 3, 5, 6, 70, 80, 90, 100] valid indexes are 0...9.
// Brute: Loop through the array. Check if the current value matches the ith position. If yes, return true, otherwise continue until the entire array has been visited.
// Optimize (BUD): Looping through every element is a waste of time. 
// We know that the magic index must match an existing value, which means that we know the value must be a valid array index. The value must then be constrained to be 0 <= X <= N.
// Get the size of the array, which is N. Look for the value that is <= N - that is where we cut the array search at.
// If we find a value greater than N, we stop since anything after will just be larger. This reduces the work.
// Walkthrough:
// [-10, -5, 0, 3, 5, 6, 70, 80, 90, 100] valid indexes are 0...9.
// Value Upperbound = 9
// i = 3, return 3.
// Best Case O(1) if the upperbound is the same as the last position.
// Worst Case O(log n) checks from both ends in 1 loop.
// Space (1)
func findMagicIndex(in list: [Int]) -> Int {
    guard list.count > 0 else { return -1 }
    
    // No value in the list must exceed this since this is the last index.
    let valueUpperbound = list.count - 1
    if list[valueUpperbound] == valueUpperbound { return valueUpperbound }
    
    // We can check from both ends at the same time to cut down the work in half.
    for index in 0...(list.endIndex / 2) where (list[index] < valueUpperbound) {
        // Checking from the start of the list.
        if list[index] == index {
            return index
        }
        // Checking from the valid end of the list.
        let endIndex = valueUpperbound - index
        if list[endIndex] == endIndex {
            return endIndex
        }
    }
    
    return -1
}

// The book solution uses recursion. It starts by identifying the middle element and comparing it against the middle index. Then, it decides to look left or right recursively in the same way binary search works.

// MARK: - Power Set
/*
 Write a method to return all subsets of a set.
 */
// LEBOWITS
// The empty set must also be taken into account.
// The total number of subsets is 2^n where n is the size of the set.
// Example: {1} -> {1}, {}
// Example: {1, 2} -> {1, 2}, {1}, {2}, {}
// Example: {1, 2, 3} -> {1, 2, 3}, {1, 2}, {1}, {1, 3}, {3}, {2, 3}, {2}, {}
// We can see that the subsets of N will also include the subsets of (N-1).
// Brute Approach: Use a property to determine what element position to ignore as we are recurisively creating the subsets.
// Attempted but solution did not work in 45 minutes. Should not have coded without a solution.
// Book Solution: The book takes a bottom-up approach. It builds up first from the empty set, and as more sets are added, it takes the next element of the list and appends it to all the previously created subsets.
// O(n2^n), O(n2^n)
func createSubsets(of set: [Int], index: Int) -> [[Int]] {
    var allSubsets = [[Int]]()
    
    if set.count == index {
        // The base case, add the empty set.
        allSubsets.append([])
    } else {
        // Keep going. This will build up subsets starting from the last elements first.
        allSubsets = createSubsets(of: set, index: index + 1)
        // The next element in the set which will be added to the new set.
        let item = set[index]
        // For every set already in it, add the next element and then add that subset to itself.
        allSubsets.forEach { allSubsets.append($0 + [item]) }
    }
    
    return allSubsets
}

// MARK: - Recursive Multiply
/*
 Write a recursive function to multiply two positive integers without using the * operator (or / operator). You can use addition, subtraction, and bit shifting, but you should minimize the number of those operations.
 */
// LEBOWITS
// Example: 2x5 is the same as (2+2)+(2+2)+2.
// Brute: If we have AxB, we just add A a B number of times. We can use recursion to add it B times to the returned value.
// m(2, 5) => 10
//    m(2, 4) + 2 => 8
//       m(2, 3) + 2 => 6
//          m(2, 2) + 2 => 4
//             m(2, 1) => 2
// Time O(n), Space(n)
func multiply(_ a: Int, by b: Int) -> Int {
    if b == 1 { return a }
    return multiply(a, by: b - 1) + a
}

// Book Solution: Visualizes a grid and realize that only addition up until the half can be calculated and then added to itself. It also uses a cache to save what has previously been added.

// MARK: - Permutations without Dups
/*
 Write a method to compute all permutations of a string of unique characters.
 */
// LEBOWITS
// A string S can be represented by characters a1a2 ... an.
// P(a1) = a1
// P(a1a2) = a1a2, a2a1
// P(a1a2a3) = a1a2a3, a1a3a2, a2a1a3, a2a3a1, a3a1a2, a3a2a1
// How can we generate P(a1a2a3a4) from P(a1a2a3)?
// Every arrangement is the same order as the previous string without a4 in it. It would essentially just be a4 in every position.
// 
// Book Solution: Keep removing the first character and pass the remaining string recursively to the function.
// After the permutations are obtained, it will loop through every word and insert the first character at various positions
// for those words. Every new word will be added to the array and then eventually returned.
func getPermutations(of str: String) -> [String] {
    var permutations = [String]()
    
    // The base case to build from.
    if str.count == 0 {
        permutations.append("")
        return permutations
    }
    
    // Get the first character of the string. This will be used to keep track of which character we will be adding at each position after getting all the permutations of the remaining string without the character.
    if let firstChar = str.first {
        // We will create all permutations for the remaining string.
        let remainder = String(str[str.index(str.startIndex, offsetBy: 1)..<str.endIndex])
        let words = getPermutations(of: remainder)
        
        // For every word in the permutation, we will add the first character at each location.
        for word in words {
            for i in  0..<str.count {
                var newWord = word
                newWord.insert(firstChar, at: word.index(word.startIndex, offsetBy: i))
                permutations.append(newWord)
            }
        }
    }
    return permutations
}

// MARK: - Parens
/*
 Implement an algorithm to print all valid (e.g., properly opened and closed) combinations of n pairs of parentheses.
 */
// Approach: We will use a bottom-up approach. We will start with the base case. From that base case, we will build up each permutation by adding "()" at every position for every pair. Since we are builidng on top of f(n-1), we will eventually fill in each position for every pair available.
// 
func printAllParenthesis(for numOfPairs: Int) -> [String] {
    var newPairs = [String]()
    // The base case - this is a bottom-up approach.
    if numOfPairs == 1 {
        newPairs.append("()")
    } else {
        // We will get a list of all pairs for that number of pairs.
        let pairs = printAllParenthesis(for: numOfPairs - 1)
        //Go through every pair from the f(n-1) case.
        for pair in pairs {
            // Go through every character from start to after the end.
            for i in 0...pair.count {
                var newPair = pair
                // ! This is unnecessary work if the string already exists in the array.
                newPair.insert(contentsOf: "()", at: pair.index(pair.startIndex, offsetBy: i))
                guard !newPairs.contains(newPair) else { continue }
                newPairs.append(newPair)
            }
        }
    }
    return newPairs
}

// MARK: - Coins
/*
 Given an infinite number of quarters (25 cents), dimes (1O cents), nickels (5 cents), and pennies (1 cent), write code to calculate the number of ways of representing n cents.
 */
// Consider the relation hip that n has compared to its subproblems.
// Start with the biggest denominations and check what is left to compute after subtracting it from n.
// With the next smaller denomination, it will have to apply for every permutation of the previous computation.
// Makes several recursive cals with a loop that computes a previous total and remainder.

// MARK: - Eight Queens
/*
 Write an algorithm to print all ways of arranging eight queens on an 8x8 chess board so that none of them share the same row, column, or diagonal. In this case, "diagonal" means all diagonals, not just the two that bisect the board.
 */
// Consider that there are 8 possibilities each queen can be on for each column.
// Consider the cases when the queen is at column X at position Y. Write down the cases. Is there a pattern?
// The algorithm loops through the entire grid checking if a valid queen can be placed at a column or row for the i'th column. The check ensures that no queen i on the same row, column, or hitting each other diagonally. If placed correctly, it will make a recursive call again to the next row and clumns.
