import XCTest
@testable import AdventOfCode2021

class Day11Tests: AoCTestCase {
    
    let example = Day11(input: exampleInput(day: 11))
    let myInput = Day11(input: myInput(day: 11))
    
    func testPart1() {
        XCTAssertEqual(example.part1(), 1656)
        
        printAnswer(day: 11, part: 1, answer: myInput.part1())
        measure { XCTAssertEqual(myInput.part1(), 1688) }
    }
    
    func testPart2() {
        XCTAssertEqual(example.part2(), 195)
        
        printAnswer(day: 11, part: 2, answer: myInput.part2())
        measure { XCTAssertEqual(myInput.part2(), 403) }
    }

}
