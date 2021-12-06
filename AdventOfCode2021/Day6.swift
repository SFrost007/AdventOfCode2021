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
        Self.wipeCache()
        // Normalise the fish's initial ages to a date they were born on
        let birthDates = inputData.map { $0 - 8 } // Example: [3,4,3,1,2] -> [-5,-4,-5,-7,-8]
        return birthDates.map { Self.cumulativeFishCreatedUpToCutoff(fromFishBornOnDay: $0) }.reduce(0, +)
    }
    
    // MARK: - Cached calculation function
    
    // Keep a cache for the 'cumulative' function as any fish born on the same day will produce the same number of children.
    // To make this more dynamic it could be a multi-layer cache with an extra key for the number of days we're calculating
    // up to, but for the puzzle we only ever need it up to 256.
    static let dayCutoff = 256
    static var cache: [Int: Int] = [:]
    
    static func wipeCache() {
        cache = [:]
    }
    
    static func cumulativeFishCreatedUpToCutoff(fromFishBornOnDay day: Int) -> Int {
        guard day <= dayCutoff else { fatalError("") }
        if let previousCalculatedValue = cache[day] { return previousCalculatedValue }
        
        var fishCounter = 1 // For self
        var reproduceCycle = day + 2 // Fish are born with a counter of 8, but reproduce cycle resets to 6
        while reproduceCycle + 7 <= dayCutoff {
            reproduceCycle += 7
            fishCounter += cumulativeFishCreatedUpToCutoff(fromFishBornOnDay: reproduceCycle)
        }
        cache[day] = fishCounter
        return fishCounter
    }
    
}
