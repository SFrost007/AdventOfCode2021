//
//  Day2Tests.swift
//  AdventOfCode2021Tests
//
//  Created by Simon Frost on 2/12/2021.
//

import XCTest
@testable import AdventOfCode2021

class Day2Tests: AoCTestCase {
    
    let example = Day2(inputURL: urlForExampleData(day: 2))
    let myInput = Day2(inputURL: urlForMyInputData(day: 2))
    
    func testPart1() {
        XCTAssertEqual(example.part1(), 150)
        
        print("Answer for Day 2 Part 1: \(myInput.part1())")
        measure {
            let _ = myInput.part1()
        }
    }
    
    func testPart2() {
        XCTAssertEqual(example.part2(), 900)
        
        print("Answer for Day 2 Part 2: \(myInput.part2())")
        measure {
            let _ = myInput.part2()
        }
    }

}
