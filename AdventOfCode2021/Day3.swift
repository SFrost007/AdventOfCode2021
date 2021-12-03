//
//  Day3.swift
//  AdventOfCode2021
//
//  Created by Simon Frost on 3/12/2021.
//

import Foundation

class Day3 {
    
    // MARK: - Initialisation
    
    let inputData: [String]
    
    init(inputURL: URL) {
        inputData = try! String(contentsOf: inputURL).components(separatedBy: .newlines)
    }
    
    // MARK: - Problem cases
    
    func part1() -> Int {
        let gammaString = Self.calculateGammaRate(in: inputData)
        let epsilonString = Self.calculateEpsilonRate(from: gammaString)
        return Self.binaryToDecimal(gammaString) * Self.binaryToDecimal(epsilonString)
    }
    
    func part2() -> Int {
        fatalError("Not yet implemented")
    }
    
    // MARK: - Worker functions
    
    static func calculateGammaRate(in input: [String]) -> String {
        return ""
    }
    
    static func calculateEpsilonRate(from gammaRate: String) -> String {
        return ""
    }
    
    static func binaryToDecimal(_ binary: String) -> Int {
        return -1
    }
    
}
