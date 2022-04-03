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
    // Create a new interval that combines all intervals that overlap with the new one.
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
// First, figure out whether the interval in A intersects with B, or if B intersects with A. This will help us determine wether to make a new interval. Then, advance the pointer for the list in which the interval already ended since no other intervals can intersect with it. Keep going until it has reached the end of either list.
// Time O(A + B), Space O(N)
func findIntersection(_ intervalsA: [Interval], _ intervalsB: [Interval]) -> [Interval] {
    var mergedIntervals = [Interval]()
    var a = 0 // Pointer for intervalsA
    var b = 0 // Pointer for intervalsB
    
    while a < intervalsA.count && b < intervalsB.count {
        let intervalAStart = intervalsA[a].start
        let intervalBStart = intervalsB[b].start
        let intervalAEnd = intervalsA[a].end
        let intervalBEnd = intervalsB[b].end
        
        // Check if A is within B.
        let doesAOverlapB = intervalAStart >= intervalBStart && intervalAStart <= intervalBEnd
        // Check if B is within A.
        let doesBOverlapA = intervalBStart >= intervalAStart && intervalBStart <= intervalAEnd
        
        // Store the intersection part.
        if doesAOverlapB || doesBOverlapA {
            let start = max(intervalAStart, intervalBStart)
            let end = min(intervalAEnd, intervalBEnd)
            mergedIntervals.append(Interval(start, end))
        }
        
        // Move next for the interval which finishes first.
        (intervalsA[a].end < intervalsB[b].end) ? (a += 1) : (b += 1)
    }
    
    return mergedIntervals
}

// MARK: - Conflicting Appointments (Medium)
/*
 Given an array of intervals representing ‘N’ appointments, find out if a person can attend all the appointments.
 */
// Time O(N * log N), Space O(N)
func canAttendAppointments(_ appointments: [Interval]) -> Bool {
    let sortedIntervals = appointments.sorted(by: { $0.start < $1.start })
    for i in 1..<sortedIntervals.count {
        // We are not using <= since if an appointment starts when one ends, that is not a conflict. So it's a conflict if it's < only.
        if sortedIntervals[i].start < sortedIntervals[i - 1].end {
            return false
        }
    }
    return true
}

// MARK: - Problem Challenge 1: Minimum Meeting Rooms (Hard)
/*
 Given a list of intervals representing the start and end time of ‘N’ meetings, find the minimum number of rooms required to hold all the meetings.
 */
// Sort the intervals by their start time. We will use a minimum heap since the data structure must continue to keep the intervals we add sorted by the smallest end time. This is because we are keeping track of meetings that have ended or started. If the next meeting's start time is over the current meeting (minimum), then we will remove it. If it's not, then we will keep it in the heap. After the loop, we will increase the count of the rooms based on the size of the heap since it keeps a count of all currently progressing meetings.
// Time O(N * log N), Space O(N)
func minimumRoomsForMeetings(_ meetings: [Interval]) -> Int {
    let sortedMeetings = meetings.sorted(by: { $0.start < $1.start })
    var minRooms = 0
    // A minimum heap that sorts the meetings by the minimum end time. This is to keep track when checking the meetings to know if to remove any meetings that are past the meeting that has the smallest time (minimum).
    var minHeap = Heap<Interval>(sort: { $0.end < $1.end })
    
    for i in 0..<sortedMeetings.count {
        let currentMeeting = sortedMeetings[i]
        // Remove all the meetings that have ended.
        while minHeap.count > 0 && currentMeeting.start >= minHeap.peek()!.end {
            minHeap.remove()
        }
        // Add the current meeting into the minHeap.
        minHeap.insert(currentMeeting)
        // All active meetings are in the minHeap, so we need rooms for all of them.
        minRooms = max(minRooms, minHeap.count)
    }
    return minRooms
}

// MARK: - Problem Challenge 2: Maximum CPU Load (hard)
/*
 We are given a list of Jobs. Each job has a Start time, an End time, and a CPU load when it is running. Our goal is to find the maximum CPU load at any time if all the jobs are running on the same machine.
 */
func findMaxCPULoad(in jobs: [Interval]) -> Int {
    return 0
}
