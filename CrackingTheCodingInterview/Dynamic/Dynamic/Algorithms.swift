//
//  Algorithms.swift
//  Dynamic
//
//  Created by J.A. Ramirez on 12/28/21.
//

import Foundation

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

// Optimize: Not very efficient because there is duplicate work being done. If we consider 2x6 which is (2+2)+(2+2)+(2+2) we have 2 groups of 2's that are being added. Which eventually become (4+4)+4 which we then see we have a group of 4. Can we cache the calculation?
// 2x6 = (2+2)+(2+2)+(2+2)+(0+0)
// 2x6 =         (4+4)+(4+0)
// 2x6 =            (8)+(4)
//                                  g(2, 3)
//                    f(2, 3)8                +        f(2, 3) 8
//          f(2, 2)4     +     4
//           2 + 2                           
// [1: 2, 2: 4, 3: 8]
//func multiply(_ a: Int, by b: Int) -> Int {
//    var cache = [1: a]
//    let result = multiplyCache(a, b: b / 2, cache: &cache)
//    return result 
//}
//
//func multiplyCache(_ a: Int, b: Int, cache: inout [Int: Int]) -> Int {
//    if let calculation = cache[b] {
//        return calculation
//    } else {
//        cache[b] = multiplyCache(a, b: b - 1, cache: &cache) + 
//                     multiplyCache(a, b: b - 1, cache: &cache)
//        return cache[b]!
//    }
//}

// Book Solution: Visualizes a grid and realize that only addition up until the half can be calculated and then added to itself. It also uses a cache to save what has previously been added.
