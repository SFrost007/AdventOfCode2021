import XCTest
@testable import AdventOfCode2021

class Day13Tests: AoCTestCase {
    
    let example = Day13(inputURL: urlForExampleData(day: 13))
    let myInput = Day13(inputURL: urlForMyInputData(day: 13))
    
    func testPart1() {
        XCTAssertEqual(example.part1(), 17)
        
        printAnswer(day: 13, part: 1, answer: myInput.part1())
        measure { XCTAssertEqual(myInput.part1(), -1) }
    }
    
    func testPart2() {
        XCTAssertEqual(example.part2(), 123)
        
        printAnswer(day: 13, part: 2, answer: myInput.part2())
        measure { XCTAssertEqual(myInput.part2(), -1) }
    }

}
