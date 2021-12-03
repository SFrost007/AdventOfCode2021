//
//  Day3Tests.swift
//  AdventOfCode2021Tests
//
//  Created by Simon Frost on 3/12/2021.
//

import XCTest
@testable import AdventOfCode2021

class Day3Tests: AoCTestCase {
    
    let example = Day3(inputURL: urlForExampleData(day: 3))
    let myInput = Day3(inputURL: urlForMyInputData(day: 3))
    
    func testPart1() {
        XCTAssertEqual(Day3.calculateGammaRate(in: example.inputData), "10110")
        XCTAssertEqual(Day3.calculateEpsilonRate(from: "10110"), "01001")
        XCTAssertEqual(Day3.binaryToDecimal("10110"), 22)
        XCTAssertEqual(Day3.binaryToDecimal("01001"), 9)
        XCTAssertEqual(example.part1(), 198)
        
        print("Answer for Day 3 Part 1: \(myInput.part1())")
        measure {
            let _ = myInput.part1()
        }
    }
    
    func testPart2() {
        XCTAssertEqual(example.part2(), 123)
        
        print("Answer for Day 3 Part 2: \(myInput.part2())")
        measure {
            let _ = myInput.part2()
        }
    }

}
