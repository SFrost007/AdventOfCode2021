import XCTest
@testable import AdventOfCode2021

class Day1Tests: AoCTestCase {
    
    let example = Day1(inputURL: urlForExampleData(day: 1))
    let myInput = Day1(inputURL: urlForMyInputData(day: 1))
    
    func testPart1() {
        XCTAssertEqual(example.part1(), 7)
        
        printAnswer(day: 1, part: 1, answer: myInput.part1())
        measure {
            let _ = myInput.part1()
        }
    }
    
    func testPart2() {
        XCTAssertEqual(example.part2(), 5)
        
        printAnswer(day: 1, part: 2, answer: myInput.part2())
        measure {
            let _ = myInput.part2()
        }
    }

}
