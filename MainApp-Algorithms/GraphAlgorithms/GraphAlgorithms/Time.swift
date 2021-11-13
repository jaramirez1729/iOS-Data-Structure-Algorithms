//
//  Time.swift
//  GraphAlgorithms
//
//  Created by Jozeee on 1/31/20.
//  Copyright © 2020 AdaloveSoftware. All rights reserved.
//

import Foundation

class Time {
    func measure(_ block: () -> Void) {
        let date = Date()
        block()
        print("\(date.timeIntervalSinceNow * -1) seconds.")
    }
}
