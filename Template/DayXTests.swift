import XCTest
@testable import AdventOfCode2021

class DayXTests: AoCTestCase {
    
    let example = DayX(inputURL: urlForExampleData(day: DayX_Number))
    let myInput = DayX(inputURL: urlForMyInputData(day: DayX_Number))
    
    func testPart1() {
        XCTAssertEqual(DayX.findSomething(in: example.inputData[0]), 123)
        XCTAssertEqual(example.part1(), 123)
        
        printAnswer(day: DayX_Number, part: 1, answer: myInput.part1())
        measure {
            let _ = myInput.part1()
        }
    }
    
    func testPart2() {
        XCTAssertEqual(DayX.findSomething(in: example.inputData[0]), 123)
        XCTAssertEqual(example.part2(), 123)
        
        printAnswer(day: DayX_Number, part: 2, answer: myInput.part2())
        measure {
            let _ = myInput.part2()
        }
    }

}
