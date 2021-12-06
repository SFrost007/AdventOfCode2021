import Foundation

class Day6 {
    
    // MARK: - Initialisation
    
    let inputData: [Int]
    
    init(inputURL: URL) {
        inputData = try! String(contentsOf: inputURL).trimmingCharacters(in: .newlines)
            .components(separatedBy: ",")
            .compactMap { Int($0) }
    }
    
    // MARK: - Problem cases
    
    func part1() -> Int {
        var fishAges = inputData
        for _ in 1...80 {
            fishAges = Self.processDay(fishAges)
        }
        return fishAges.count
    }
    
    func part2() -> Int {
        fatalError("Not yet implemented")
    }
    
    // MARK: - Worker functions
    
    // Note: This doesn't append new fish to the end like the example, but order doesn't matter for part 1
    static func processDay(_ fishAges: [Int]) -> [Int] {
        return fishAges.flatMap { $0 > 0 ? [($0 - 1)] : [6, 8] }
    }
    
}
