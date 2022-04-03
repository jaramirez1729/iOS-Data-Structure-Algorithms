//
//  5-MergeIntervalsPatternTests.swift
//  GrokkingTheCodingInterviewTests
//
//  Created by J.A. Ramirez on 2/21/22.
//

import XCTest
@testable import GrokkingTheCodingInterview

// MARK: - Merge Intervals (Medium)
class MergeIntervalsTests: XCTestCase {
    func test1() {
        let input = [Interval(1, 4), Interval(2, 5), Interval(7, 9)]
        let result = mergeIntervals(input)
        XCTAssertEqual(result.description, "[[1, 5], [7, 9]]")
    }
    
    func test2() {
        let input = [Interval(6, 7), Interval(2, 4), Interval(5, 9)]
        let result = mergeIntervals(input)
        XCTAssertEqual(result.description, "[[2, 4], [5, 9]]")
    }
    
    func test3() {
        let input = [Interval(1, 4), Interval(2, 6), Interval(3, 5)]
        let result = mergeIntervals(input)
        XCTAssertEqual(result.description, "[[1, 6]]")
    }
    
    func test4() {
        let input = [Interval(1, 4), Interval(5, 6)]
        let result = mergeIntervals(input)
        XCTAssertEqual(result.description, "[[1, 4], [5, 6]]")
    }
    
    func test5() {
        let input = [Interval(1, 4)]
        let result = mergeIntervals(input)
        XCTAssertEqual(result.description, "[]")
    }
}

// MARK: Similar Problem #1
class DoIntervalsOverlapTests: XCTestCase {
    func test1() {
        let input = [Interval(1, 4), Interval(2, 5), Interval(7, 9)]
        let result = doIntervalsOverlap(input)
        XCTAssertTrue(result)
    }
    
    func test2() {
        let input = [Interval(10, 12), Interval(1, 2), Interval(3, 5)]
        let result = doIntervalsOverlap(input)
        XCTAssertFalse(result)
    }
    
    func test3() {
        let input = [Interval(1, 5), Interval(5, 9)]
        let result = doIntervalsOverlap(input)
        XCTAssertTrue(result)
    }
    
    func test4() {
        let input = [Interval(1, 3), Interval(4, 5)]
        let result = doIntervalsOverlap(input)
        XCTAssertFalse(result)
    }
}

// MARK: - Insert Intervals (Medium)
class InsertIntervalTests: XCTestCase {
    func test1() {
        let intervals = [Interval(1, 3), Interval(5, 7), Interval(8, 12)]
        let newInterval = Interval(4, 6)
        let result = insertInterval(newInterval, into: intervals)
        XCTAssertEqual(result.description, "[[1, 3], [4, 7], [8, 12]]")
    }
    
    func test2() {
        let intervals = [Interval(1, 3), Interval(5, 7), Interval(8, 12)]
        let newInterval = Interval(4, 10)
        let result = insertInterval(newInterval, into: intervals)
        XCTAssertEqual(result.description, "[[1, 3], [4, 12]]")
    }
    
    func test3() {
        let intervals = [Interval(2, 3), Interval(5, 7)]
        let newInterval = Interval(1, 4)
        let result = insertInterval(newInterval, into: intervals)
        XCTAssertEqual(result.description, "[[1, 4], [5, 7]]")
    }
}

// MARK: - Intervals Intersection (Medium)
class FindIntersectionTests: XCTestCase {
    func test1() {
        let list1 = createIntervals([1, 5, 7], [3, 6, 9])
        let list2 = createIntervals([2, 5], [3, 7])
        let result = findIntersection(list1, list2)
        let answer = createIntervals([2, 5, 7], [3, 6, 7])
        XCTAssertEqual(result, answer)
    }
    
    func test2() {
        let list1 = createIntervals([1, 5, 9], [3, 7, 12])
        let list2 = [Interval(5, 10)]
        let result = findIntersection(list1, list2)
        let answer = createIntervals([5, 9], [7, 10])
        XCTAssertEqual(result, answer)
    }
}

// MARK: - Conflicting Appointments (Medium)
class CanAttendAppointmentsTests: XCTestCase {
    func test1() {
        let list = createIntervals([1, 2, 7], [4, 5, 9])
        let result = canAttendAppointments(list)
        XCTAssertFalse(result)
    }
    
    func test2() {
        let list = createIntervals([6, 2, 8], [7, 4, 12])
        let result = canAttendAppointments(list)
        XCTAssertTrue(result)
    }
    
    func test3() {
        let list = createIntervals([4, 2, 3], [5, 3, 6])
        let result = canAttendAppointments(list)
        XCTAssertFalse(result)
    }
}

// MARK: - Problem Challenge 1: Minimum Meeting Rooms (Hard)
class MinimumRoomsForMeetingsTests: XCTestCase {
    
    func test1() {
        let meetings = createIntervals([4, 2, 2, 3], [5, 3, 4, 5])
        let rooms = minimumRoomsForMeetings(meetings)
        let result = 2
        XCTAssertEqual(rooms, result)
    }
    
    func test2() {
        let meetings = createIntervals([6, 2, 8], [7, 4, 12])
        let rooms = minimumRoomsForMeetings(meetings)
        let result = 1
        XCTAssertEqual(rooms, result)
    }
    
    func test3() {
        let meetings = createIntervals([1, 2, 3], [4, 3, 6])
        let rooms = minimumRoomsForMeetings(meetings)
        let result = 2
        XCTAssertEqual(rooms, result)
    }
    
    func test4() {
        let meetings = createIntervals([4, 2, 2, 3], [5, 3, 4, 5])
        let rooms = minimumRoomsForMeetings(meetings)
        let result = 2
        XCTAssertEqual(rooms, result)
    }
}

// MARK: - Problem Challenge 2: Maximum CPU Load (hard)
class findMaxCPULoadTests: XCTestCase {
    func test1() {
        
    }
}

// MARK: - Helpers
func createIntervals(_ starts: [Int], _ ends: [Int]) -> [Interval] {
    guard starts.count == ends.count else { return [Interval]() }
    
    var intervals = [Interval]()
    for i in 0..<starts.count {
        intervals.append(Interval(starts[i], ends[i]))
    }
    return intervals
}
