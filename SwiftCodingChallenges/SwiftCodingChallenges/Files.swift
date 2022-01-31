//
//  main.swift
//  SwiftCodingChallenges
//
//  Created by Jozeee on 2/7/20.
//  Copyright © 2020 AdaloveSoftware. All rights reserved.
//

import Foundation

// MARK: - Problem #27
// Read a file and print the last N lines in reverse order all on a single line separated by commas.
func printLastLines(upTo n: Int) {
    guard let input = try? String(contentsOfFile: "Challenge27.txt") else {
        print("File \"Challenge27.txt\" not found.")
        return
    }
    
    let lines: [String] = input.components(separatedBy: "\n").reversed()
    
    guard lines.count > 0 else { return }
    
    var output: [String] = []
    
    // In case n is too large.
    for i in 0..<min(n, lines.count) {
        output.append(lines[i])
    }
    
    print(output.joined(separator: ", "))
}


// MARK: - Problem #28
// Create a method that logs messages to a file. Create the file if it doesn't exist.
func logMessage(_ message: String) {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "MM/dd/yyyy"
    
    let message: String = "\(dateFormatter.string(from: Date())): \(message)"
    var contents: String = ""
    
    if let fileContents = try? String(contentsOfFile: "Challenge28.txt") {
        contents += fileContents + "\n" + message
    } else {
        contents = message
    }
    
    do {
        try contents.write(toFile: "Challenge28.txt", atomically: true, encoding: .utf8)
    } catch {
        print("Failed to write to log: \(error.localizedDescription)")
    }
}


// MARK: - Problem #29
// Write a function that returns a URL to the user's document directory.
func documentURL() -> URL {
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    return paths[0]
}


// MARK: - Problem #30
// Write a method that returns all jpg, jpeg files that were created in the last 48 hours.
func getNewImages(for path: String) -> [String] {
    let fm = FileManager.default
    let dirUrl = URL(fileURLWithPath: path)
    guard let files = try? fm.contentsOfDirectory(at: dirUrl, includingPropertiesForKeys: nil) else { return [] }
    
    var jpegs: [String] = []
    
    for file in files {
        if file.pathExtension == "jpg" || file.pathExtension == "jpeg" {
            guard let attributes = try? fm.attributesOfItem(atPath: file.path) else { continue }
            guard let creationDate = attributes[.creationDate] as? Date else { continue }
            if creationDate > Date(timeIntervalSinceNow: -60 * 60 * 48) {
                jpegs.append(file.lastPathComponent)
            }
        }
    }
    
    return jpegs
}


// MARK: - Problem #31
//
