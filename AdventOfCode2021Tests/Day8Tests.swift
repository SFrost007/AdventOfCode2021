import XCTest
@testable import AdventOfCode2021

class Day8Tests: AoCTestCase {
    
    let example = Day8(input: exampleInput(day: 8))
    let myInput = Day8(input: myInput(day: 8))
    
    func testPart1() {
        XCTAssertEqual(example.part1(), 26)
        
        printAnswer(day: 8, part: 1, answer: myInput.part1())
        measure { XCTAssertEqual(myInput.part1(), 392) }
    }
    
    func testPart2() {
        // Test each part in turn
        XCTAssertEqual(Day8.intArrayToInt([1,2,3]), 123)
        XCTAssertEqual(Day8.intArrayToInt([1,0]), 10)
        XCTAssertEqual(Day8.intArrayToInt([0,1,4]), 14)
        XCTAssertEqual(Day8.intArrayToInt([0,0,0]), 0)
        
        let exampleMapping: Day8.SegmentMapping = [
            "d": .horizTop,
            "f": .horizMid,
            "c": .horizBot,
            "e": .leftTop,
            "g": .leftBot,
            "a": .rightTop,
            "b": .rightBot
        ]
        let exampleInputString = "acedgfb cdfbe gcdfa fbcad dab cefabd cdfgeb eafb cagedb ab"
        XCTAssertEqual(Day8.outputDigits(mapping: exampleMapping, string: exampleInputString), [8,5,2,3,7,9,6,4,0,1])
        let exampleOutputString = "cdfeb fcadb cdfeb cdbaf"
        XCTAssertEqual(Day8.outputDigits(mapping: exampleMapping, string: exampleOutputString), [5,3,5,3])
        
        XCTAssertEqual(Day8.deduceMapping(input: exampleInputString), exampleMapping)
        
        XCTAssertEqual(Day8.solveLine(example.inputData[0]), 8394)
        
        // Test the whole thing
        XCTAssertEqual(example.part2(), 61229)
        
        printAnswer(day: 8, part: 2, answer: myInput.part2())
        measure { XCTAssertEqual(myInput.part2(), 1004688) }
    }

}
