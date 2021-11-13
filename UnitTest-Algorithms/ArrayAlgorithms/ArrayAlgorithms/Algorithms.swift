//
//  Algorithms.swift
//  ArrayAlgorithms
//
//  Created by J.A. Ramirez on 11/13/21.
//

import Foundation

// MARK: - Find the Union of 2 Sorted Arrays
// Listen: The union should only have 1 element of every occurence. 
// Example: A = [2, 4, 6, 8, 12] and B = [3, 5, 4, 43, 100, 8]
// Brute: Loop through A and check if that value exists in B. If it does, then add it to the
//         new list only if that list does not already contain it. Return that list.
// Optimize (BUD), Walkthrough, Implement, Test
// Time: O(a * b + u) Space: O(u)
func findUnionOfArrays(a: [Int], b: [Int]) -> [Int]  {
    var union = [Int]()
    // O(a)
    for val in a {
        // O(b) and O(u)
        if b.contains(val) && !union.contains(val) {
            union.append(val)
        }
    }
    return union
}

// MARK: - Find the Factorials of a Given N
// Time: O(n); Space: O(1)
func findFactorial(of n: Int) -> Int {
    if n == 0 { return 1 }
    
    var ans = 1
    for i in 1...n  {
        ans *= i
    }
    return ans
}


// MARK: - Find the Maximum Index
/* Given an array A[] of N positive integers. The task is to find the maximum of j - i subjected to the constraint of A[i] < A[j] and i < j.
 */
// Listen, Example: [1, 3, 0, 8, 10]
// Brute: Use 2 pointers. The first pointer starts at the begining and the second pointer starts at the 2nd value. We compare A[i] < A[j] and if it's true and if it's greater than the stored result, store it and store the difference i - j. Whe have to have an inner loop to incremement j to allow every comparison between each index. When i has reached the last value in the array, we are done.
// Optimize (BUD): 
// Walkthrough: i = 0, 1; j = 1; diff = 0, 1; 1 < 3? 1 - 0 > 0? ;; 1 < 0? 1 < 8? 1 < 10? ;; 
// Implement, Test
// Time: O(a * j)?; Space: O(1)
func findMaximumIndex(in a: [Int]) -> Int {
    var indexDiff = 0
    
    for i in 0..<(a.count - 1) { // O(a)
        // If the list size is 5...
        // If i = 0; j = 1, 2, 3, 4; 4 times
        // If i = 1; j = 2, 3, 4; 3 times
        // If i = 2; j = 3, 4; 2 times
        // If i = 3; j = 4; 1 time
        for j in (i + 1)..<a.count { // O(j)
            if a[i] <= a[j] && j - i >= indexDiff {
                indexDiff = j - i
            }
        }
    }
    return indexDiff
}
