import XCTest
@testable import AdventOfCode2021

class Day8Tests: AoCTestCase {
    
    let example = Day8(inputURL: urlForExampleData(day: 8))
    let myInput = Day8(inputURL: urlForMyInputData(day: 8))
    
    func testPart1() {
        XCTAssertEqual(example.part1(), 26)
        
        printAnswer(day: 8, part: 1, answer: myInput.part1())
        measure { XCTAssertEqual(myInput.part1(), 392) }
    }
    
    func testPart2() {
        XCTAssertEqual(example.part2(), 123)
        
        printAnswer(day: 8, part: 2, answer: myInput.part2())
        measure { XCTAssertEqual(myInput.part2(), -1) }
    }

}
