//
//  GrokkingTheCodingInterviewTests.swift
//  GrokkingTheCodingInterviewTests
//
//  Created by J.A. Ramirez on 2/5/22.
//

import XCTest
@testable import GrokkingTheCodingInterview

// MARK: - Maximum Sum Subarray of Size K (Easy)
class FindMaxSumSubArrayTests: XCTestCase {
    func test1() {
        let list = [2, 1, 5, 1, 3, 2]
        let k = 3
        XCTAssertEqual(findMaxSumSubArray(in: list, size: k), 9)
    }
    
    func test2() {
        let list = [2, 3, 4, 1, 5]
        let k = 2
        XCTAssertEqual(findMaxSumSubArray(in: list, size: k), 7)
    }
}

// MARK: - Smallest Subarray with a Greater Sum (Easy) 
class FindMinSumSubArrayTests: XCTestCase {
    func test1() {
        let list = [2, 1, 5, 2, 3, 2] 
        let s = 7
        XCTAssertEqual(findMinSumSubArray(in: list, target: s), 2)
    }
    
    func test2() {
        let list = [2, 1, 5, 2, 8]
        let s = 7
        XCTAssertEqual(findMinSumSubArray(in: list, target: s), 1)
    }
    
    func test3() {
        let list = [3, 4, 1, 1, 6]
        let s = 8
        XCTAssertEqual(findMinSumSubArray(in: list, target: s), 3)
    }
}

// MARK: - Longest Substring with K Distinct Characters (Medium)
class FindLongestSubstringWithDistinctTests: XCTestCase {
    func test1() {
        let str = "araaci"
        let k = 2
        XCTAssertEqual(FindLongestSubstring(in: str, withDistinct: k), 4)
    }
    
    func test2() {
        let str = "araaci"
        let k = 1
        XCTAssertEqual(FindLongestSubstring(in: str, withDistinct: k), 2)
    }
    
    func test3() {
        let str = "cbbebi"
        let k = 3
        XCTAssertEqual(FindLongestSubstring(in: str, withDistinct: k), 5)
    }
}

// MARK: - Fruits into Baskets (Medium)
class FruitsIntoBasketsTests: XCTestCase {
    func test1() {
        let fruits = ["A", "B", "C", "A", "C"]
        XCTAssertEqual(fruitsIntoBaskets(fruits), 3)
    }
    
    func test2() {
        let fruits = ["A", "B", "C", "B", "B", "C"]
        XCTAssertEqual(fruitsIntoBaskets(fruits), 5)
    }
}

// MARK: - Longest Substring with Distinct Characters (Hard)
class FindLongestDistinctSubstringTests: XCTestCase {
    func test1() {
        let input = "aabccbb"
        XCTAssertEqual(FindLongestDistinctSubstring(in: input), 3)
    }
    
    func test2() {
        let input = "abbbb"
        XCTAssertEqual(FindLongestDistinctSubstring(in: input), 2)
    }
    
    func test3() {
        let input = "abccde"
        XCTAssertEqual(FindLongestDistinctSubstring(in: input), 3)
    }
    
    func test4() {
        let input = "abcdcfeghijk"
        XCTAssertEqual(FindLongestDistinctSubstring(in: input), 9)
    }
}

// MARK: - Longest Substring with Same Letters after Replacement (Hard)
class FindLongestReplacementSubstringTests: XCTestCase {
    func test1() {
        let input = "aabccbb"
        let k = 2
        XCTAssertEqual(findLongestReplacementSubstring(in: input, replacements: k), 5)
    }
    
    func test2() {
        let input = "abbcb"
        let k = 1
        XCTAssertEqual(findLongestReplacementSubstring(in: input, replacements: k), 4)
    }
    
    func test3() {
        let input = "abccde"
        let k = 1
        XCTAssertEqual(findLongestReplacementSubstring(in: input, replacements: k), 3)
    }
}

// MARK: - Longest Subarray with Ones after Replacement (Hard)
class FindLongestReplacementSubarrayTests: XCTestCase {
    func test1() {
        let nums = [0, 1, 1, 0, 0, 0, 1, 1, 0, 1, 1]
        let k = 2
        XCTAssertEqual(findLongestReplacementSubarray(in: nums, replacements: k), 6)
    }
    
    func test2() {
        let nums = [0, 1, 0, 0, 1, 1, 0, 1, 1, 0, 0, 1, 1]
        let k = 3
        XCTAssertEqual(findLongestReplacementSubarray(in: nums, replacements: k), 9)
    }
}

// MARK: - Problem Challenge #1: Permutation in a String (Hard)
class FindPatternTests: XCTestCase {
    func test1() {
        let input = "oidbcaf"
        let pattern = "abc"
        XCTAssertTrue(findPattern(in: input, pattern: pattern))
    }
    
    func test2() {
        let input = "oidbcaf"
        let pattern = "dio"
        XCTAssertTrue(findPattern(in: input, pattern: pattern))
    }
    
    func test3() {
        let input = "odicf"
        let pattern = "dc"
        XCTAssertFalse(findPattern(in: input, pattern: pattern))
    }
    
    func test4() {
        let input = "bcdxabcdy"
        let pattern = "bcdyabcdx"
        XCTAssertTrue(findPattern(in: input, pattern: pattern))
    }
    
    func test5() {
        let input = "aaacb"
        let pattern = "abc"
        XCTAssertTrue(findPattern(in: input, pattern: pattern))
    }
    
    func test6() {
        let input = "aaacb"
        let pattern = "aabe"
        XCTAssertFalse(findPattern(in: input, pattern: pattern))
    }
    
    func test7() {
        let input = "a"
        let pattern = "a"
        XCTAssertTrue(findPattern(in: input, pattern: pattern))
    }
}

// MARK: - Problem Challenge #2: String Anagrams (Hard)
class FindAnagramsTests: XCTestCase {
    func test1() {
        let input = "ppqp"
        let pattern = "pq"
        XCTAssertEqual(findAnagrams(in: input, pattern: pattern), [1, 2])
    }
    
    func test2() {
        let input = "abbcabc"
        let pattern = "abc"
        XCTAssertEqual(findAnagrams(in: input, pattern: pattern), [2, 3, 4])
    }
    
    func test3() {
        let input = "acbbbcabbbca"
        let pattern = "ac"
        XCTAssertEqual(findAnagrams(in: input, pattern: pattern), [0, 5, 10])
    }
    
    func test4() {
        let input = "bbbbb"
        let pattern = "a"
        XCTAssertEqual(findAnagrams(in: input, pattern: pattern), [])
    }
    
    func test5() {
        let input = "d"
        let pattern = "aaa"
        XCTAssertEqual(findAnagrams(in: input, pattern: pattern), [])
    }
}

// MARK: - Problem Challenge 3: Smallest Window containing Substring (Hard)
class FindSmallestSubstring: XCTestCase {
    func test1() {
        let input = "aabdec"
        let pattern = "abc"
        XCTAssertEqual(findSmallestSubstring(in: input, pattern: pattern), "abdec")
    }
    
    func test2() {
        let input = "abdbca"
        let pattern = "abc"
        XCTAssertEqual(findSmallestSubstring(in: input, pattern: pattern), "bca")
    }
    
    func test3() {
        let input = "adcad"
        let pattern = "abc"
        XCTAssertEqual(findSmallestSubstring(in: input, pattern: pattern), "")
    }
}

// MARK: - Problem Challenge #4: Words Concatenation (Hard)
class FindSubstringIndicesTests: XCTestCase {
    func test1() {
        let str = "catfoxcat"
        let words = ["cat", "fox"]
        XCTAssertEqual(findSubstringIndices(in: str, with: words), [0, 3])
    }
    
    func test2() {
        let str = "catcatfoxfox"
        let words = ["cat", "fox"]
        XCTAssertEqual(findSubstringIndices(in: str, with: words), [3])
    }
    
    func test3() {
        let str = "oohelloworldwarz"
        let words = ["ell", "owo", "ooh"]
        XCTAssertEqual(findSubstringIndices(in: str, with: words), [0])
    }
    
    func test4() {
        let str = "hello"
        let words = ["oka"]
        XCTAssertEqual(findSubstringIndices(in: str, with: words), [])
    }
    
    func test5() {
        let str = "hello"
        let words = ["l"]
        XCTAssertEqual(findSubstringIndices(in: str, with: words), [2, 3])
    }
    
    func test6() {
        let str = "catfoxcat"
        let words = ["atf", "oxc"]
        XCTAssertEqual(findSubstringIndices(in: str, with: words), [1])
    }
}
