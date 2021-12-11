import XCTest
@testable import AdventOfCode2021

class Day9Tests: AoCTestCase {
    
    let example = Day9(inputURL: urlForExampleData(day: 9))
    let myInput = Day9(inputURL: urlForMyInputData(day: 9))
    
    func testPart1() {
        XCTAssertEqual(example.part1(), 15)
        
        printAnswer(day: 9, part: 1, answer: myInput.part1())
        measure { XCTAssertEqual(myInput.part1(), 500) }
    }
    
    func testPart2() {
        XCTAssertEqual(example.part2(), 1134)
        
        printAnswer(day: 9, part: 2, answer: myInput.part2())
        measure { XCTAssertEqual(myInput.part2(), 970200) }
    }

}
