import XCTest
@testable import AdventOfCode2021

class Day11Tests: AoCTestCase {
    
    let example = Day11(inputURL: urlForExampleData(day: 11))
    let myInput = Day11(inputURL: urlForMyInputData(day: 11))
    
    func testPart1() {
        XCTAssertEqual(example.part1(), 1656)
        
        printAnswer(day: 11, part: 1, answer: myInput.part1())
        measure { XCTAssertEqual(myInput.part1(), 1688) }
    }
    
    func testPart2() {
        XCTAssertEqual(example.part2(), 123)
        
        printAnswer(day: 11, part: 2, answer: myInput.part2())
        measure { XCTAssertEqual(myInput.part2(), -1) }
    }

}
