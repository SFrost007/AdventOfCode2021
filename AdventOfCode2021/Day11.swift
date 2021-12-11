import Foundation

class Day11 {
    
    // MARK: - Initialisation
    
    let inputData: [[Int]]
    
    init(inputURL: URL) {
        inputData = try! String(contentsOf: inputURL)
            .components(separatedBy: .newlines)
            .filter { !$0.isEmpty }
            .map { Array($0).compactMap { Int(String($0)) } }
    }
    
    // MARK: - Problem cases
    
    func part1() -> Int {
        var currentState = inputData
        var flashes: Int = 0
        for _ in 1...100 {
            currentState  = Self.incrementAllValues(in: currentState)
            var lastFlashCount = -1
            while lastFlashCount != 0 {
                (currentState, lastFlashCount) = Self.incrementNeighboursOfFlashing(in: currentState)
                flashes += lastFlashCount
            }
            currentState = Self.resetFlashedOctopussesToZero(in: currentState)
        }
        return flashes
    }
    
    func part2() -> Int {
        var currentState = inputData
        var step = 1
        while true {
            var flashes: Int = 0
            currentState  = Self.incrementAllValues(in: currentState)
            var lastFlashCount = -1
            while lastFlashCount != 0 {
                (currentState, lastFlashCount) = Self.incrementNeighboursOfFlashing(in: currentState)
                flashes += lastFlashCount
            }
            currentState = Self.resetFlashedOctopussesToZero(in: currentState)
            if flashes == inputData.first!.count * inputData.count {
                return step
            }
            step += 1
        }
    }
    
    // MARK: - Helper functions
    
    static func incrementAllValues(in input: [[Int]]) -> [[Int]] {
        return input.map { $0.map { $0 + 1 } }
    }
    
    static func incrementNeighboursOfFlashing(in input: [[Int]]) -> (newState: [[Int]], flashed: Int) {
        var newState = input
        var flashed = 0
        for y in 0..<input.count {
            for x in 0..<input.first!.count {
                // Bit of a hack - set any flashed values to a large number so we can exclude from future loops
                guard newState[y][x] > 9 && newState[y][x] < 1_000_000 else { continue }
                newState[y][x] = 1_000_000
                flashed += 1
                // Increment all neighbours
                for dx in -1...1 {
                    for dy in -1...1 {
                        guard x + dx >= 0 && x + dx < input.first!.count else { continue }
                        guard y + dy >= 0 && y + dy < input.count else { continue }
                        newState[y + dy][x + dx] += 1
                    }
                }
            }
        }
        return (newState, flashed)
    }
    
    static func resetFlashedOctopussesToZero(in input: [[Int]]) -> [[Int]] {
        return input.map { $0.map { $0 > 9 ? 0 : $0 } }
    }
    
}
