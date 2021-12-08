import XCTest
@testable import AdventOfCode2021

class Day7Tests: AoCTestCase {
    
    let example = Day7(inputURL: urlForExampleData(day: 7))
    let myInput = Day7(inputURL: urlForMyInputData(day: 7))
    
    func testPart1() {
        XCTAssertEqual(example.part1(), 37)

        printAnswer(day: 7, part: 1, answer: myInput.part1())
        measure { XCTAssertEqual(myInput.part1(), 356992) }
    }
    
    func testPart2() {
        XCTAssertEqual(example.part2(), 168)

        printAnswer(day: 7, part: 2, answer: myInput.part2())
        measure { XCTAssertEqual(myInput.part2(), 101268110) }
    }

}
