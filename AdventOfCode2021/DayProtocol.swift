import Foundation

/// Common protocol for all 'day' implementations to match
protocol Day {
    init(input: String) throws
    func part1() throws -> Int
    func part2() throws -> Int
}
