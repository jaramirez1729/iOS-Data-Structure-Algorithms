//
//  Interval.swift
//  GrokkingTheCodingInterview
//
//  Created by J.A. Ramirez on 2/21/22.
//

import Foundation

class Interval {
    var start: Int
    var end: Int
    
    init(_ start: Int, _ end: Int) {
        self.start = start
        self.end = end
    }
}

extension Interval: Equatable {
    static func == (lhs: Interval, rhs: Interval) -> Bool {
        return lhs.start == rhs.start && lhs.end == rhs.start
    }
}

extension Interval: CustomStringConvertible {
    var description: String {
        "[\(start), \(end)]"
    }
}

class Job {
    var start: Int
    var end: Int
    var cpuLoad: Int
    
    init(_ start: Int, _ end: Int, _ cpuLoad: Int) {
        self.start = start
        self.end = end
        self.cpuLoad = cpuLoad
    }
}
