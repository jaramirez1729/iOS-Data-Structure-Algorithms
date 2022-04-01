//
//  5-MergeIntervalsPattern.swift
//  GrokkingTheCodingInterview
//
//  Created by J.A. Ramirez on 2/21/22.
//

import Foundation

/*
 This pattern describes an efficient technique to deal with overlapping intervals. In a lot of problems involving intervals, we either need to find overlapping intervals or merge intervals if they overlap.

 Given two intervals (‘a’ and ‘b’), there will be six different ways the two intervals can relate to each other:
 - a and b do not overlap.
 - a and b overlap, b ends after a.
 - a completely overlaps b.
 - a and b overlap, a ends after b.
 - b completely overlaps a.
 - a and b do not overlap.
 */

// MARK: - Merge Intervals (Medium)
/*
 Given a list of intervals, merge all the overlapping intervals to produce a list that has only mutually exclusive intervals.
 */
// First, we sort the intervals based on their starting value. Store the first intervals values to start the comparisons with. Then, loop through the rest of the intervals and check if the values overlap by comparing the current start value with the interval's end value. If not, set the new start and end values to the next interval and loop.
// Time O(N * log N), Space O(N)
func mergeIntervals(_ intervals: [Interval]) -> [Interval] {
    guard intervals.count > 1 else { return [] }
    
    // First, sort the intervals by their starting interval. This will make it easy to compare values.
    let sortedIntervals = intervals.sorted(by: { $0.start < $1.start })
    var mergedIntervals = [Interval]()
    
    // Get the start and end of the first interval. This will be used to compare the next intervals. They will also be used for subsequent overlapping intervals.
    var start = sortedIntervals[0].start
    var end = sortedIntervals[0].end
    for i in 1..<sortedIntervals.endIndex {
        let interval = sortedIntervals[i]
        if interval.start <= end { // Overlapping intervals, adjust the end.
            end = max(interval.end, end)
        } else { // non-overlapping interval, add the previous interval that did overlap before we re-assign them.
            mergedIntervals.append(Interval(start, end))
            start = interval.start
            end = interval.end
        }
    }
    // Add the last one.
    mergedIntervals.append(Interval(start, end))
    return mergedIntervals
} 

// MARK: Similar Problem #1
/*
 Given a set of intervals, find out if any two intervals overlap.
 */
// Time O(N * log N), Space O(N)
func doIntervalsOverlap(_ intervals: [Interval]) -> Bool {
    guard !intervals.isEmpty else { return false }
    
    let sortedIntervals = intervals.sorted(by: { $0.start < $1.start })
    var end = sortedIntervals[0].end
    
    for i in 1..<sortedIntervals.endIndex {
        let interval = sortedIntervals[i]
        if interval.start <= end {
            return true
        } else {
            // Update the end interval to use it for comparison with the next value.
            end = interval.end
        }
    }
    return false
}

// MARK: - Insert Intervals (Medium)
/*
 Given a list of non-overlapping intervals sorted by their start time, insert a given interval at the correct position and merge all necessary intervals to produce a list that has only mutually exclusive intervals.
 */
// Time O(N), Space O(N)
func insertInterval(_ interval: Interval, into intervals: [Interval]) -> [Interval] {
    var mergedIntervals = [Interval]()
    var i = 0

    // Since intervals don't overlap, we can add all that come before the new one already.
    while i < intervals.count && intervals[i].end < interval.start {
        mergedIntervals.append(intervals[i])
        i += 1
    }
    // Create a new interval that includes any intervals that overlap with the new one.
    let newInterval = interval
    while i < intervals.count && intervals[i].start <= newInterval.end {
        newInterval.start = min(intervals[i].start, newInterval.start)
        newInterval.end = max(intervals[i].end, newInterval.end)
        i += 1
    }
    mergedIntervals.append(newInterval)
    // If there are any left, then they are already not overlapping, so just add the rest.
    while i < intervals.count {
        mergedIntervals.append(intervals[i])
        i += 1
    }
    
    return mergedIntervals
}

// MARK: - Intervals Intersection (Medium)
/*
 Given two lists of intervals, find the intersection of these two lists. Each list consists of disjoint intervals sorted on their start time.
 */
func findIntersection(_ list1: [Interval], _ list2: [Interval]) -> [Interval] {
    return []
}
