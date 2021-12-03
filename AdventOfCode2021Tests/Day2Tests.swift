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
        
        printAnswer(day: 2, part: 1, answer: myInput.part1())
        measure {
            let _ = myInput.part1()
        }
    }
    
    func testPart2() {
        XCTAssertEqual(example.part2(), 900)
        
        printAnswer(day: 2, part: 2, answer: myInput.part2())
        measure {
            let _ = myInput.part2()
        }
    }

}
