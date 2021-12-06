import XCTest
@testable import AdventOfCode2021

class Day6Tests: AoCTestCase {
    
    let example = Day6(inputURL: urlForExampleData(day: 6))
    let myInput = Day6(inputURL: urlForMyInputData(day: 6))
    
    func testPart1() {
        XCTAssertEqual(example.inputData, [3,4,3,1,2]) // Check parsing
        XCTAssertEqual(example.part1(), 5934)
        
        printAnswer(day: 6, part: 1, answer: myInput.part1())
        measure { XCTAssertEqual(myInput.part1(), 376194) }
    }
    
    func testPart2() {
        XCTAssertEqual(example.part2(), 26984457539)
        
        printAnswer(day: 6, part: 2, answer: myInput.part2())
        measure { XCTAssertEqual(myInput.part2(), -1) }
    }

}
