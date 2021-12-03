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
        inputData = try! String(contentsOf: inputURL).components(separatedBy: .newlines).filter { !$0.isEmpty }
    }
    
    // MARK: - Problem cases
    
    func part1() -> Int {
        let gammaString = Self.calculateGammaRate(in: inputData)
        let epsilonString = Self.calculateEpsilonRate(from: gammaString)
        return Self.binaryToDecimal(gammaString) * Self.binaryToDecimal(epsilonString)
    }
    
    func part2() -> Int {
        let oxygenGeneratorRating = Self.findOxygenGeneratorRating(in: inputData)
        let co2ScrubberRating = Self.findCO2ScrubberRating(in: inputData)
        return Self.binaryToDecimal(oxygenGeneratorRating) * Self.binaryToDecimal(co2ScrubberRating)
    }
    
    // MARK: - Worker functions
    
    // Returns e.g. [123, 32, 45, 100, 42]
    static func findEnabledBitCounts(in input: [String]) -> [Int] {
        input
            .map { Array($0).map { Int(String($0)) } } // ["01101", "11111"] -> [ [0,1,1,0,1], [1,1,1,1,1] ]
            .reduce( input.first!.map({ _ in 0 }) ) { partialResult, thisValue in
                // Probably a neater way of doing this
                partialResult.enumerated().map { (index, item) in
                    item + thisValue[index]!
                }
            }
    }
    
    // Returns e.g. ["1", "0", "1", "0", "1"]
    static func findMostCommonValues(in input: [String]) -> [String] {
        findEnabledBitCounts(in: input)
            .map { $0 >= ((input.count + 1) / 2) ? "1" : "0" }
    }
    
    static func binaryToDecimal(_ binary: String) -> Int {
        Int(binary, radix: 2) ?? -1
    }
    
    // MARK: - Part 1
    
    static func calculateGammaRate(in input: [String]) -> String {
        findMostCommonValues(in: input)
            .joined()
    }
    
    static func calculateEpsilonRate(from gammaRate: String) -> String {
        gammaRate
            .replacingOccurrences(of: "0", with: "x")
            .replacingOccurrences(of: "1", with: "0")
            .replacingOccurrences(of: "x", with: "1")
    }
    
    // MARK: - Part 2
    
    static func findOxygenGeneratorRating(in input: [String]) -> String {
        var filteredInput = input
        for position in 0..<input.first!.count {
            let mostCommonValues = findMostCommonValues(in: filteredInput)
            filteredInput = filteredInput.filter { String($0[position]) == mostCommonValues[position] }
            if filteredInput.count == 1 { break }
        }
        return filteredInput.first!
    }
    
    static func findCO2ScrubberRating(in input: [String]) -> String {
        var filteredInput = input
        for position in 0..<input.first!.count {
            let mostCommonValues = findMostCommonValues(in: filteredInput)
            filteredInput = filteredInput.filter { String($0[position]) != mostCommonValues[position] }
            if filteredInput.count == 1 { break }
        }
        return filteredInput.first!
    }
    
}

// MARK: - Helpers

fileprivate extension StringProtocol {
    subscript(_ offset: Int)                     -> Element     { self[index(startIndex, offsetBy: offset)] }
    subscript(_ range: Range<Int>)               -> SubSequence { prefix(range.lowerBound+range.count).suffix(range.count) }
    subscript(_ range: ClosedRange<Int>)         -> SubSequence { prefix(range.lowerBound+range.count).suffix(range.count) }
    subscript(_ range: PartialRangeThrough<Int>) -> SubSequence { prefix(range.upperBound.advanced(by: 1)) }
    subscript(_ range: PartialRangeUpTo<Int>)    -> SubSequence { prefix(range.upperBound) }
    subscript(_ range: PartialRangeFrom<Int>)    -> SubSequence { suffix(Swift.max(0, count-range.lowerBound)) }
}
