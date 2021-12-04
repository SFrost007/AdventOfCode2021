import XCTest
@testable import AdventOfCode2021

class Day4Tests: AoCTestCase {
    
    let example = Day4(inputURL: urlForExampleData(day: 4))
    let myInput = Day4(inputURL: urlForMyInputData(day: 4))
    
    func testPart1() {
        // Parsing tests
        XCTAssertEqual(example.calledNumbers, [7,4,9,5,11,17,23,2,0,14,21,24,10,16,13,6,15,25,12,22,18,20,8,19,3,26,1])
        XCTAssertEqual(example.bingoBoards.count, 3)
        XCTAssertEqual(example.bingoBoards.first!.numberGrid.first!.map { $0.number }, [22,13,17,11,0])
        XCTAssertEqual(example.bingoBoards.last!.numberGrid.last!.map { $0.number }, [2,0,12,3,7])
        // Algorithm tests
        XCTAssertEqual(example.part1(), 4512)
        
        printAnswer(day: 4, part: 1, answer: myInput.part1())
        measure { XCTAssertEqual(myInput.part1(), 55770) }
    }
    
    func testPart2() {
        XCTAssertEqual(example.part2(), 1924)
        
        printAnswer(day: 4, part: 2, answer: myInput.part2())
        measure { XCTAssertEqual(myInput.part2(), 2980) }
    }

}
