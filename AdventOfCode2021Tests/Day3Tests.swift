import XCTest
@testable import AdventOfCode2021

class Day3Tests: AoCTestCase {
    
    let example = Day3(inputURL: urlForExampleData(day: 3))
    let myInput = Day3(inputURL: urlForMyInputData(day: 3))
    
    func testPart1() {
        XCTAssertEqual(Day3.calculateGammaRate(in: example.inputData), "10110")
        XCTAssertEqual(Day3.calculateEpsilonRate(from: "10110"), "01001")
        XCTAssertEqual(Day3.binaryToDecimal("10110"), 22)
        XCTAssertEqual(Day3.binaryToDecimal("01001"), 9)
        XCTAssertEqual(example.part1(), 198)
        
        printAnswer(day: 3, part: 1, answer: myInput.part1())
        measure {
            let _ = myInput.part1()
        }
    }
    
    func testPart2() {
        XCTAssertEqual(Day3.findOxygenGeneratorRating(in: example.inputData), "10111")
        XCTAssertEqual(Day3.findCO2ScrubberRating(in: example.inputData), "01010")
        XCTAssertEqual(example.part2(), 230)
        
        printAnswer(day: 3, part: 2, answer: myInput.part2())
        measure {
            let _ = myInput.part2()
        }
    }

}
