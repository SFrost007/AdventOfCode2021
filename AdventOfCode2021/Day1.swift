import Foundation

final class Day1: Day {
    
    // MARK: - Initialisation
    
    let inputData: [Int]
    
    init(input: String) {
        inputData = input
            .components(separatedBy: .newlines)
            .compactMap { Int($0) }
    }
    
    // MARK: - Problem cases
    
    func part1() -> Int {
        var count = 0
        for (index, item) in inputData.enumerated() {
            guard index > 0 else { continue }
            if item > inputData[index-1] { count += 1 }
        }
        return count
    }
    
    func part2() -> Int {
        var count = 0
        var lastTotal = Int.max
        for i in 2..<inputData.count {
            let thisTotal = inputData[i-2] + inputData[i-1] + inputData[i]
            if thisTotal > lastTotal { count += 1}
            lastTotal = thisTotal
        }
        return count
    }
    
}
