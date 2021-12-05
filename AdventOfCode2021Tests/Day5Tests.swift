import XCTest
@testable import AdventOfCode2021

class Day5Tests: AoCTestCase {
    
    let example = Day5(inputURL: urlForExampleData(day: 5))
    let myInput = Day5(inputURL: urlForMyInputData(day: 5))
    
    func testPart1() {
        XCTAssertEqual(example.part1(), 5)
        
        printAnswer(day: 5, part: 1, answer: myInput.part1())
        measure { XCTAssertEqual(myInput.part1(), 4655) }
    }
    
    func testPart2() {
        // Test diagonal handling
        XCTAssertEqual(Day5.Line("2,3 -> 4,5").coordsCovered, [
            Day5.Line.Coord(x: 2, y: 3),
            Day5.Line.Coord(x: 3, y: 4),
            Day5.Line.Coord(x: 4, y: 5)
        ])
        XCTAssertEqual(Day5.Line("4,5 -> 2,3").coordsCovered, [
            Day5.Line.Coord(x: 4, y: 5),
            Day5.Line.Coord(x: 3, y: 4),
            Day5.Line.Coord(x: 2, y: 3)
        ])
        XCTAssertEqual(Day5.Line("4,3 -> 2,5").coordsCovered, [
            Day5.Line.Coord(x: 4, y: 3),
            Day5.Line.Coord(x: 3, y: 4),
            Day5.Line.Coord(x: 2, y: 5)
        ])
        XCTAssertEqual(Day5.Line("2,5 -> 4,3").coordsCovered, [
            Day5.Line.Coord(x: 2, y: 5),
            Day5.Line.Coord(x: 3, y: 4),
            Day5.Line.Coord(x: 4, y: 3)
        ])
        
        XCTAssertEqual(example.part2(), 12)
        
        printAnswer(day: 5, part: 2, answer: myInput.part2())
        measure { XCTAssertEqual(myInput.part2(), 20500) }
    }

}
