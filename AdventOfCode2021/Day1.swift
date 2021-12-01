//
//  Day1.swift
//  AdventOfCode2021
//
//  Created by Simon Frost on 1/12/2021.
//

import Foundation

class Day1 {
    
    // MARK: - Initialisation
    
    let inputData: [Int]
    
    init(inputURL: URL) {
        inputData = try! String(contentsOf: inputURL).components(separatedBy: .newlines)
            .compactMap { Int($0) }
    }
    
    // MARK: - Problem cases
    
    func part1() -> Int {
        return Self.countIncrements(in: inputData)
    }
    
    func part2() -> Int {
        fatalError("Not yet implemented")
    }
    
    // MARK: - Worker functions
    
    static func countIncrements(in input: [Int]) -> Int {
        return -1
    }
    
}
