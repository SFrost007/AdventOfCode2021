import XCTest
@testable import AdventOfCode2021

class Day14Tests: AoCTestCase {
    
    let example = Day14(inputURL: urlForExampleData(day: 14))
    let myInput = Day14(inputURL: urlForMyInputData(day: 14))
    
    func testPart1() {
        XCTAssertEqual(example.part1(), 1588)
        
        printAnswer(day: 14, part: 1, answer: myInput.part1())
        measure { XCTAssertEqual(myInput.part1(), -1) }
    }
    
    func testPart2() {
        XCTAssertEqual(example.part2(), 123)
        
        printAnswer(day: 14, part: 2, answer: myInput.part2())
        measure { XCTAssertEqual(myInput.part2(), -1) }
    }

}
