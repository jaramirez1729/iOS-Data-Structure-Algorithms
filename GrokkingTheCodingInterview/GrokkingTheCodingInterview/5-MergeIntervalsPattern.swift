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
    
    // Start off at 0 to begin the comparisons in the loop.
    var start = sortedIntervals[0].start
    var end = sortedIntervals[0].end
    for i in 1..<sortedIntervals.endIndex {
        let interval = sortedIntervals[i]
        if interval.start <= end { // Overlapping intervals, adjust the end.
            end = max(interval.end, end)
        } else { // non-overlapping interval, add the previous interval and reset.
            mergedIntervals.append(Interval(start, end))
            start = interval.start
            end = interval.end
        }
    }
    // Add the last one.
    mergedIntervals.append(Interval(start, end))
    return mergedIntervals
} 

// MARK: - Merge Intervals (Medium)
/*
 Given a list of non-overlapping intervals sorted by their start time, insert a given interval at the correct position and merge all necessary intervals to produce a list that has only mutually exclusive intervals.
 */
func instertInterval(_ interval: Interval, into intervals: [Interval]) -> [Interval] {
    return []
}
