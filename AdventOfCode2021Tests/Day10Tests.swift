import XCTest
@testable import AdventOfCode2021

class Day10Tests: AoCTestCase {
    
    let example = Day10(inputURL: urlForExampleData(day: 10))
    let myInput = Day10(inputURL: urlForMyInputData(day: 10))
    
    func testPart1() {
        XCTAssertEqual(example.part1(), 26397)
        
        printAnswer(day: 10, part: 1, answer: myInput.part1())
        measure { XCTAssertEqual(myInput.part1(), 367059) }
    }
    
    func testPart2() {
        XCTAssertEqual(example.part2(), 123)
        
        printAnswer(day: 10, part: 2, answer: myInput.part2())
        measure { XCTAssertEqual(myInput.part2(), -1) }
    }

}
