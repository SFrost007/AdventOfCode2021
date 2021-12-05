import XCTest
@testable import AdventOfCode2021

class Day5Tests: AoCTestCase {
    
    let example = Day5(inputURL: urlForExampleData(day: 5))
    let myInput = Day5(inputURL: urlForMyInputData(day: 5))
    
    func testPart1() {
        XCTAssertEqual(example.part1(), 5)
        
        printAnswer(day: 5, part: 1, answer: myInput.part1())
        measure { XCTAssertEqual(myInput.part1(), -1) }
    }
    
    func testPart2() {
        XCTAssertEqual(Day5.findSomething(in: example.inputData[0]), 123)
        XCTAssertEqual(example.part2(), 123)
        
        printAnswer(day: 5, part: 2, answer: myInput.part2())
        measure { XCTAssertEqual(myInput.part2(), -1) }
    }

}
