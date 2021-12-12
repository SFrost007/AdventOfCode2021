import XCTest
@testable import AdventOfCode2021

class Day12Tests: AoCTestCase {
    
    let example1 = Day12(inputURL: urlForExampleData(day: 12, partSuffix: "1a"))
    let example2 = Day12(inputURL: urlForExampleData(day: 12, partSuffix: "1b"))
    let example3 = Day12(inputURL: urlForExampleData(day: 12, partSuffix: "1c"))
    let myInput = Day12(inputURL: urlForMyInputData(day: 12))
    
    func testParsing() {
        XCTAssertEqual(example1.nodeLookup.count, 6)
        XCTAssertEqual(example1.nodeLookup["start"]!.connections.count, 2)
        XCTAssertEqual(example1.nodeLookup["A"]!.connections.count, 4)
        XCTAssertEqual(example1.nodeLookup["b"]!.connections.count, 4)
        XCTAssertEqual(example1.nodeLookup["c"]!.connections.count, 1)
        XCTAssertEqual(example1.nodeLookup["d"]!.connections.count, 1)
        XCTAssertEqual(example1.nodeLookup["end"]!.connections.count, 2)
    }
    
    func testPart1() {
        XCTAssertEqual(example1.part1(), 10)
        XCTAssertEqual(example2.part1(), 19)
        XCTAssertEqual(example3.part1(), 226)
        
        printAnswer(day: 12, part: 1, answer: myInput.part1())
        measure { XCTAssertEqual(myInput.part1(), 3410) }
    }
    
    func testPart2() {
        XCTAssertEqual(example1.part2(), 123)
        
        printAnswer(day: 12, part: 2, answer: myInput.part2())
        measure { XCTAssertEqual(myInput.part2(), -1) }
    }

}
