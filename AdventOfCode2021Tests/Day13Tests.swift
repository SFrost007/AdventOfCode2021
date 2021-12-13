import XCTest
@testable import AdventOfCode2021

class Day13Tests: AoCTestCase {
    
    let example = Day13(inputURL: urlForExampleData(day: 13))
    let myInput = Day13(inputURL: urlForMyInputData(day: 13))
    
    func testParsing() {
        XCTAssertEqual(example.dots.count, 18)
        XCTAssertEqual(example.instructions.count, 2)
    }
    
    func testPart1() {
        XCTAssertEqual(example.part1(), 17)
        
        printAnswer(day: 13, part: 1, answer: myInput.part1())
        measure { XCTAssertEqual(myInput.part1(), 827) }
    }
    
    func testPart2() {
        // Note: This isn't really unit testable due to outputting ascii art, but my answer was "EAHKRECP"
        printAnswer(day: 13, part: 2, answer: myInput.part2())
        measure { XCTAssertEqual(myInput.part2(), 0) }
    }

}
