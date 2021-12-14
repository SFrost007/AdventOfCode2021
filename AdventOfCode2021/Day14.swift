import Foundation

class Day14 {
    
    // MARK: - Initialisation
    
    let template: String
    let rules: RulesDict
    typealias RulesDict = [[Character]: Character]
    typealias CharPair = (Character, Character)
    
    init(inputURL: URL) {
        let inputData = try! String(contentsOf: inputURL)
            .trimmingCharacters(in: .newlines)
            .components(separatedBy: "\n\n")
        template = inputData[0]
        rules = inputData[1]
            .components(separatedBy: .newlines)
            .reduce(into: [:], { dict, line in
                let parts = line.components(separatedBy: " -> ")
                let key = Array(parts[0])
                dict[key] = Array(parts[1]).first
            })
    }
    
    // MARK: - Problem cases
    
    func part1() -> Int {
        Self.findAnswer(input: template, rules: rules, iterations: 10)
    }
    
    func part2() -> Int {
        Self.findAnswer(input: template, rules: rules, iterations: 40)
    }
    
    // MARK: - Worker functions
    
    static func findAnswer(input: String, rules: RulesDict, iterations: Int) -> Int {
        var characterCounts = input.reduce(into: [:], { $0[$1] = $0[$1, default: 0] + 1 } )
        
        let charPairs = (0..<input.count-1).map { CharPair(input[$0], input[$0+1]) }
        charPairs.forEach { getChildren(from: $0, rules: rules, currentDepth: 0, maxDepth: iterations, counts: &characterCounts) }
        
        let sortedCounts = characterCounts
            .map { $0.value }
            .sorted()
        return sortedCounts.last! - sortedCounts.first!
    }
    
    static func getChildren(from input: CharPair, rules: RulesDict, currentDepth: Int, maxDepth: Int, counts: [Character: Int]) {
        guard currentDepth < maxDepth else { return }
        let child = rules[[input.0, input.1]]!
        counts[child] = counts[child, default: 0] + 1
        getChildren(from: (input.0, child), rules: rules, currentDepth: currentDepth+1, maxDepth: maxDepth, counts: &counts)
        getChildren(from: (child, input.1), rules: rules, currentDepth: currentDepth+1, maxDepth: maxDepth, counts: &counts)
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
