import XCTest
@testable import AdventOfCode2021

class Day4Tests: AoCTestCase {
    
    let example = Day4(inputURL: urlForExampleData(day: 4))
    let myInput = Day4(inputURL: urlForMyInputData(day: 4))
    
    func testPart1() {
        XCTAssertEqual(example.part1(), 4512)
        
        printAnswer(day: 4, part: 1, answer: myInput.part1())
        measure { let _ = myInput.part1() }
    }
    
    func testPart2() {
        XCTAssertEqual(example.part2(), 123)
        
        printAnswer(day: 4, part: 2, answer: myInput.part2())
        measure { let _ = myInput.part2() }
    }

}
