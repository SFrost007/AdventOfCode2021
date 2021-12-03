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
        fatalError("Not yet implemented")
    }
    
    // MARK: - Worker functions
    
    static func findMostCommonValues(in input: [String]) -> [Int] {
        input
            .map { Array($0).map { Int(String($0)) } } // ["01101", "11111"] -> [ [0,1,1,0,1], [1,1,1,1,1] ]
            .reduce( input.first!.map({ _ in 0 }) ) { partialResult, thisValue in
                // Probably a neater way of doing this
                partialResult.enumerated().map { (index, item) in
                    item + thisValue[index]!
                }
            }
    }
    
    static func binaryToDecimal(_ binary: String) -> Int {
        Int(binary, radix: 2) ?? -1
    }
    
    // MARK: - Part 1
    
    static func calculateGammaRate(in input: [String]) -> String {
        findMostCommonValues(in: input)
            .map { $0 >= (input.count / 2) ? "1" : "0" }
            .joined()
    }
    
    static func calculateEpsilonRate(from gammaRate: String) -> String {
        gammaRate
            .replacingOccurrences(of: "0", with: "x")
            .replacingOccurrences(of: "1", with: "0")
            .replacingOccurrences(of: "x", with: "1")
    }
    
}
