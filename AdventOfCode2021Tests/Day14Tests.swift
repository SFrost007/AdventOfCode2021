import XCTest
@testable import AdventOfCode2021

class Day14Tests: AoCTestCase {
    
    let example = Day14(inputURL: urlForExampleData(day: 14))
    let myInput = Day14(inputURL: urlForMyInputData(day: 14))
    
    func testParsing() {
        XCTAssertEqual(example.template, "NNCB")
        XCTAssertEqual(example.rules.count, 16)
        XCTAssertEqual(example.rules[["N", "B"]], "B")
    }
    
    func testPart1() {
        // Test worker functions
        XCTAssertEqual(Day14.getCharArray(input: "NNCB", rules: example.rules, iterations: 1), Array("NCNBCHB"))
        XCTAssertEqual(Day14.getCharArray(input: "NCNBCHB", rules: example.rules, iterations: 1), Array("NBCCNBBBCBHCB"))
        XCTAssertEqual(Day14.getCharArray(input: "NNCB", rules: example.rules, iterations: 2), Array("NBCCNBBBCBHCB"))
        XCTAssertEqual(Day14.getCharArray(input: "NNCB", rules: example.rules, iterations: 3), Array("NBBBCNCCNBBNBNBBCHBHHBCHB"))
        XCTAssertEqual(Day14.findLetterCounts(in: Array("AAAABBCA")), ["A": 5, "B": 2, "C": 1])
        
        // Test actual part 1
        XCTAssertEqual(example.part1(), 1588)
        printAnswer(day: 14, part: 1, answer: myInput.part1())
        measure { XCTAssertEqual(myInput.part1(), 3247) }
    }
    
    func testPart2() {
        XCTAssertEqual(example.part2(), 2188189693529)
        
        printAnswer(day: 14, part: 2, answer: myInput.part2())
        measure { XCTAssertEqual(myInput.part2(), -1) }
    }

}
