import Foundation

final class Day7: Day {
    
    // MARK: - Initialisation
    
    let inputData: [Int]
    
    init(input: String) {
        inputData = input
            .trimmingCharacters(in: .newlines)
            .components(separatedBy: ",")
            .compactMap { Int($0) }
    }
    
    // MARK: - Problem cases
    
    func part1() -> Int {
        var minDistance = Int.max
        for i in inputData.min()!...inputData.max()! {
            let distance = inputData
                .map { abs($0-i) }
                .reduce(0, +)
            minDistance = min(distance, minDistance)
        }
        return minDistance
    }
    
    func part2() -> Int {
        var minDistance = Int.max
        for i in inputData.min()!...inputData.max()! {
            let distance = inputData
                .map { abs($0-i) }
                .map { $0 * ($0 + 1) / 2 } // nth triangular number: n * (n+1) / 2
                .reduce(0, +)
            minDistance = min(distance, minDistance)
        }
        return minDistance
    }
    
}
