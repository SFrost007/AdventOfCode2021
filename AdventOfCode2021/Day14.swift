import Foundation

class Day14 {
    
    // MARK: - Initialisation
    
    let template: String
    let rules: [String: String]
    
    init(inputURL: URL) {
        let inputData = try! String(contentsOf: inputURL)
            .trimmingCharacters(in: .newlines)
            .components(separatedBy: "\n\n")
        template = inputData[0]
        rules = inputData[1]
            .components(separatedBy: .newlines)
            .reduce(into: [:], {
                let parts = $1.components(separatedBy: " -> ")
                $0[parts[0]] = parts[1]
            })
    }
    
    // MARK: - Problem cases
    
    func part1() -> Int {
        var state = template
        for _ in 1...10 {
            state = Self.processStep(input: state, rules: rules)
        }
        let sortedCounts = Self.findLetterCounts(in: state)
            .map { $0.value }
            .sorted()
        return sortedCounts.last! - sortedCounts.first!
    }
    
    func part2() -> Int {
        fatalError("Not yet implemented")
    }
    
    // MARK: - Worker functions
    
    static func processStep(input: String, rules: [String: String]) -> String {
        let newCharacters = (0..<input.count-1)
            .map { String(input[$0...$0+1]) }
            .map { rules[$0]! }
        return (
            zip(input, newCharacters).flatMap { [String($0.0), $0.1] }
            + [String(Array(input).last!)]
        ).joined(separator: "")
    }
    
    static func findLetterCounts(in input: String) -> [String.Element: Int] {
        return input.reduce(into: [:], { $0[$1] = $0[$1, default: 0] + 1 })
    }
    
}

// MARK: - Helper extensions

// From https://stackoverflow.com/questions/24092884/get-nth-character-of-a-string-in-swift-programming-language/38215613#38215613
fileprivate extension StringProtocol {
    subscript(_ offset: Int)                     -> Element     { self[index(startIndex, offsetBy: offset)] }
    subscript(_ range: Range<Int>)               -> SubSequence { prefix(range.lowerBound+range.count).suffix(range.count) }
    subscript(_ range: ClosedRange<Int>)         -> SubSequence { prefix(range.lowerBound+range.count).suffix(range.count) }
    subscript(_ range: PartialRangeThrough<Int>) -> SubSequence { prefix(range.upperBound.advanced(by: 1)) }
    subscript(_ range: PartialRangeUpTo<Int>)    -> SubSequence { prefix(range.upperBound) }
    subscript(_ range: PartialRangeFrom<Int>)    -> SubSequence { suffix(Swift.max(0, count-range.lowerBound)) }
}
