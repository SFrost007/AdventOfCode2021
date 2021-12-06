import XCTest
@testable import AdventOfCode2021

class Day6Tests: AoCTestCase {
    
    let example = Day6(inputURL: urlForExampleData(day: 6))
    let myInput = Day6(inputURL: urlForMyInputData(day: 6))
    
    func testPart1() {
        XCTAssertEqual(Day6.findSomething(in: example.inputData[0]), 123)
        XCTAssertEqual(example.part1(), 123)
        
        printAnswer(day: 6, part: 1, answer: myInput.part1())
        measure { XCTAssertEqual(myInput.part1(), -1) }
    }
    
    func testPart2() {
        XCTAssertEqual(Day6.findSomething(in: example.inputData[0]), 123)
        XCTAssertEqual(example.part2(), 123)
        
        printAnswer(day: 6, part: 2, answer: myInput.part2())
        measure { XCTAssertEqual(myInput.part2(), -1) }
    }

}
