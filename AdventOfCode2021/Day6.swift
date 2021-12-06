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
    
    // Naive approach works for part 1, but gets out of hand for day 2
    func part1() -> Int {
        var fishAges = inputData
        for _ in 1...80 {
            // Note: This doesn't append new fish to the end like the example, but order doesn't matter
            fishAges = fishAges.flatMap { $0 > 0 ? [($0 - 1)] : [6, 8] }
        }
        return fishAges.count
    }
    
    func part2() -> Int {
        return -1
    }
    
}
