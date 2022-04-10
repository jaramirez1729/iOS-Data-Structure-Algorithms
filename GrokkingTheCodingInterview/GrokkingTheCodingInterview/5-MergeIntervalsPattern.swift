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
        // Overlapping intervals, adjust the end. This will eventually create a big interval until the condition is not met.
        if interval.start <= end {
            end = max(interval.end, end)
        } else { // non-overlapping interval, add the previous merged intervals that did overlap before we re-assign them.
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
        // All we need to do is check if the previous interval's end is greater than the next interval's start.
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
    // A minimum heap that sorts the meetings by the minimum end time. This is to keep track when checking the meetings to know if to remove any meetings that are past the meeting that has the smallest time (minimum). If a heap was not available, we could use a structure that contains an array that arranges each time a new element is added.
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
// The question is asking: At what interval will the highest CPU load time be. So when we find out what is overlapping, we can add their CPU load to get a total. We can use the same approach as the previous problem. Use a minimum heap arranged by the smallest end time to keep track of the current overlapping intervals.
// Time O(N * log N), Space O(N)
func findMaxCPULoad(in jobs: [Job]) -> Int {
    let sortedJobs = jobs.sorted(by: { $0.start < $1.start })
    var maxCPULoad = 0
    var currentCPULoad = 0
    // Sorted by the smallest end interval.
    var minHeap = Heap<Job>(sort: { $0.end < $1.end })
    
    for j in 0..<sortedJobs.count {
        let currentJob = sortedJobs[j]
        // Remove all the jobs that have ended that are past the current job's start time and remove their CPU time.
        while minHeap.count > 0 && currentJob.start >= minHeap.peek()!.end {
            currentCPULoad -= minHeap.remove()!.cpuLoad
        }
        // Add the current job to the heap.
        minHeap.insert(currentJob)
        // Increase the current CPU load with the current job.
        currentCPULoad += currentJob.cpuLoad
        maxCPULoad = max(maxCPULoad, currentCPULoad)
    }
    
    return maxCPULoad
}

// MARK: - Problem Challenge 3: Employee Free Time (Hard)
/*
 For ‘K’ employees, we are given a list of intervals representing each employee’s working hours. Our goal is to determine if there is a free interval which is common to all employees. You can assume that each list of employee working hours is sorted on the start time.
 */
// The schedule is an array or arrays where each inner array represents an employee's schedule. So array at [0] will be the first employee. etc.
//
// A simple solution is to put all the intervals into a list, and use 2 pointers to traverse and compare each one with each other one. When there are intervals that don't overlap, create a new interval. We can find a faster solution since each employee's schedule is already sorted. Instead, we can use a minimum heap. We can put the first interval of every employee into the heap and then compare with the next one in the heap. The we compare and create a new interval or not. 

// Time O(N * log K), Space O(K)
func findEmployeeFreeTime(in schedule: [[Interval]]) -> [Interval] {
    if schedule.isEmpty { return [] }
    
    var result = [Interval]()
    var minHeap = Heap<EmployeeInterval>(sort: { $0.interval.start < $1.interval.start })
    // Insert the first schedule of each employee to the queue first (will add the rest later).
    for i in 0..<schedule.count {
        minHeap.insert(EmployeeInterval(schedule[i][0], employeeIndex: i, intervalIndex: 0))
    }
    
    var previousInterval = minHeap.peek()!.interval
    while minHeap.count > 0 {
        let queueTop = minHeap.remove()!
        // If the previous interval we took off the heap (which has the lowest start) is less than the next interval's start, that mean the schedules don't overlap and there is space to add a free interval, so make a new one.
        if previousInterval.end < queueTop.interval.start {
            result.append(Interval(previousInterval.end, queueTop.interval.start))
            previousInterval = queueTop.interval
        } else {
            // Overlapping intervals, so reassign the previous interval to the current one. This step always ensures that the next minimum interval will eventually be after all overlapping intervals have been considered.
            if previousInterval.end < queueTop.interval.end {
                previousInterval = queueTop.interval
            }
        }
        
        // If there are more intervals available for the current employee, add their next interval.
        let employeeSchedule = schedule[queueTop.employeeIndex]
        if employeeSchedule.count > queueTop.intervalIndex + 1 {
            minHeap.insert(EmployeeInterval(employeeSchedule[queueTop.intervalIndex + 1], 
                                            employeeIndex: queueTop.employeeIndex, 
                                            intervalIndex: queueTop.intervalIndex + 1))
        }
    }
    return result
}
