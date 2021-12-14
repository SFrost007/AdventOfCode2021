import Foundation

class Day14 {
    
    // MARK: - Initialisation
    
    let template: String
    let rules: RulesDict
    typealias RulesDict = [CharPair: Character]
    typealias CharacterCounts = [Character: Int]
    
    struct CharPair: Hashable {
        let first: Character
        let second: Character
        
        init(_ first: Character, _ second: Character) {
            self.first = first
            self.second = second
        }
    }
    
    init(inputURL: URL) {
        let inputData = try! String(contentsOf: inputURL)
            .trimmingCharacters(in: .newlines)
            .components(separatedBy: "\n\n")
        template = inputData[0]
        rules = inputData[1]
            .components(separatedBy: .newlines)
            .reduce(into: [:], { dict, line in
                let parts = line.components(separatedBy: " -> ")
                let keyChars = Array(parts[0])
                let key = CharPair(keyChars[0], keyChars[1])
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
    
    struct CacheKey: Hashable {
        let depth: Int
        let parentChars: CharPair
    }
    
    static func findAnswer(input: String, rules: RulesDict, iterations: Int) -> Int {
        // This is the magic part. Cache the result of any pair of parent characters at a given depth.
        var lookupCache: [CacheKey: CharacterCounts] = [:]
        
        // Calculate all child counts from each pair of characters in the input string
        let charPairs = (0..<input.count-1).map { CharPair(input[$0], input[$0+1]) }
        let childCounts = charPairs.map { getCharacterCounts(from: $0, rules: rules, currentDepth: 0, maxDepth: iterations, lookupCache: &lookupCache) }
        
        // Create a "root" count from the input string and add all the child counts to it
        var characterCounts = input.reduce(into: [:], { $0[$1] = $0[$1, default: 0] + 1 } )
        childCounts.forEach { mergeDictionary($0, into: &characterCounts)}
        
        // Calculate the end result
        let sortedCounts = characterCounts
            .map { $0.value }
            .sorted()
        return sortedCounts.last! - sortedCounts.first!
    }
    
    static func getCharacterCounts(
        from parents: CharPair,
        rules: RulesDict,
        currentDepth: Int,
        maxDepth: Int,
        lookupCache: inout [CacheKey: CharacterCounts]
    ) -> CharacterCounts {
        guard currentDepth < maxDepth else { return [:] }
        
        let lookupKey = CacheKey(depth: currentDepth, parentChars: parents)
        if let cachedValue = lookupCache[lookupKey] { return cachedValue }
        
        guard let child = rules[parents] else { fatalError("Missing rule for \(parents.first)\(parents.second)") }
        let lhs = getCharacterCounts(from: CharPair(parents.first, child), rules: rules, currentDepth: currentDepth+1, maxDepth: maxDepth, lookupCache: &lookupCache)
        let rhs = getCharacterCounts(from: CharPair(child, parents.second), rules: rules, currentDepth: currentDepth+1, maxDepth: maxDepth, lookupCache: &lookupCache)
        
        var result: CharacterCounts = [child: 1]
        mergeDictionary(lhs, into: &result)
        mergeDictionary(rhs, into: &result)
        lookupCache[lookupKey] = result
        return result
    }
    
    static func mergeDictionary(_ addingDictionary: CharacterCounts, into rootDictionary: inout CharacterCounts) {
        rootDictionary = rootDictionary.merging(addingDictionary, uniquingKeysWith: +)
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
