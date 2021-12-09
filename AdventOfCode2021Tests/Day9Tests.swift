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
        // Test helper function                0 1 2 3 4 5 6 7 8 9
        XCTAssertEqual(Day9.nonNineRanges(in: [1,2,3,9,4,5,9,9,2,9]), [(0..<3), (4..<6), (8..<9)])
        XCTAssertEqual(Day9.nonNineRanges(in: [9,2,3,9,4,5,9,9,2,1]), [(1..<3), (4..<6), (8..<10)])
        
        // Test main part 2
        XCTAssertEqual(example.part2(), 1134)
        
        printAnswer(day: 9, part: 2, answer: myInput.part2())
        measure { XCTAssertEqual(myInput.part2(), -1) }
    }

}
