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
// 
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
    mergedIntervals.append(Interval(start, end))
    return mergedIntervals
} 