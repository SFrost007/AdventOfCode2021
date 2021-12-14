import XCTest
@testable import AdventOfCode2021

class Day6Tests: AoCTestCase {
    
    let example = Day6(input: exampleInput(day: 6))
    let myInput = Day6(input: myInput(day: 6))
    
    func testPart1() {
        XCTAssertEqual(example.inputData, [3,4,3,1,2]) // Check parsing
        XCTAssertEqual(example.part1(), 5934)
        
        printAnswer(day: 6, part: 1, answer: myInput.part1())
        measure { XCTAssertEqual(myInput.part1(), 376194) }
    }
    
    func testPart2() {
        // Test individual days up to 256
        XCTAssertEqual(Day6.cumulativeFishCreatedUpToCutoff(fromFishBornOnDay: 256), 1) // Will never reproduce
        XCTAssertEqual(Day6.cumulativeFishCreatedUpToCutoff(fromFishBornOnDay: 255), 1) // Will never reproduce
        XCTAssertEqual(Day6.cumulativeFishCreatedUpToCutoff(fromFishBornOnDay: 254), 1) // Will never reproduce
        XCTAssertEqual(Day6.cumulativeFishCreatedUpToCutoff(fromFishBornOnDay: 253), 1) // Will never reproduce
        XCTAssertEqual(Day6.cumulativeFishCreatedUpToCutoff(fromFishBornOnDay: 252), 1) // Will never reproduce
        XCTAssertEqual(Day6.cumulativeFishCreatedUpToCutoff(fromFishBornOnDay: 251), 1) // Will never reproduce
        XCTAssertEqual(Day6.cumulativeFishCreatedUpToCutoff(fromFishBornOnDay: 250), 1) // Will never reproduce
        XCTAssertEqual(Day6.cumulativeFishCreatedUpToCutoff(fromFishBornOnDay: 249), 1) // Will never reproduce
        XCTAssertEqual(Day6.cumulativeFishCreatedUpToCutoff(fromFishBornOnDay: 248), 1) // Will never reproduce
        XCTAssertEqual(Day6.cumulativeFishCreatedUpToCutoff(fromFishBornOnDay: 247), 2) // Will repro on 256 (+9)
        // Skip some repeated `2`s
        XCTAssertEqual(Day6.cumulativeFishCreatedUpToCutoff(fromFishBornOnDay: 241), 2) // Will repro on 250 (+9)
        XCTAssertEqual(Day6.cumulativeFishCreatedUpToCutoff(fromFishBornOnDay: 240), 3) // Will repro on 249 (+9) and 256 (+7)
        XCTAssertEqual(Day6.cumulativeFishCreatedUpToCutoff(fromFishBornOnDay: 239), 3) // Will repro on 248 (+9) and 255 (+7)
        XCTAssertEqual(Day6.cumulativeFishCreatedUpToCutoff(fromFishBornOnDay: 238), 4) // Will repro on 247 (+9) and 254 (+7), plus child from 247 will repro once
        XCTAssertEqual(Day6.cumulativeFishCreatedUpToCutoff(fromFishBornOnDay: 231), 7) // Will repro on 240 (+9), 247 (+7) and 254 (+7), = self +3 from 240, +2 from 247, +1 from 254
        // Test the same again with a clear cache
        Day6.wipeCache()
        XCTAssertEqual(Day6.cumulativeFishCreatedUpToCutoff(fromFishBornOnDay: 231), 7)
        
        // Test full calculation
        XCTAssertEqual(example.part2(), 26984457539)

        printAnswer(day: 6, part: 2, answer: myInput.part2())
        measure { XCTAssertEqual(myInput.part2(), 1693022481538) }
    }

}
