import Foundation

final class Day8: Day {
    
    // MARK: - Initialisation
    
    let inputData: [String]
    
    init(input: String) {
        inputData = input
            .components(separatedBy: .newlines)
            .filter { !$0.isEmpty }
    }
    
    // MARK: - Part 1
    
    func part1() -> Int {
        let outputParts =  inputData.compactMap { $0.components(separatedBy: " | ").last }
        let outputSegments = outputParts.flatMap { $0.components(separatedBy: .whitespaces) }
        let correctNumbers = outputSegments.filter { $0.count == 2 || $0.count == 3 || $0.count == 4 || $0.count == 7 }
        return correctNumbers.count
    }
    
    // MARK: - Part 2
    
    func part2() -> Int {
        inputData.map { Self.solveLine($0) }.reduce(0, +)
    }
    
    // Names the seven segments of the display
    enum Segment: CaseIterable {
        case horizTop
        case horizMid
        case horizBot
        case leftTop
        case leftBot
        case rightTop
        case rightBot
    }
    typealias SegmentMapping = [Character: Segment]
    
    enum DisplayDigit: CaseIterable {
        case zero, one, two, three, four, five, six, seven, eight, nine
        
        var enabledSegments: Set<Segment> {
            switch self {
            case .zero:  return Set(Segment.allCases.filter { $0 != .horizMid })            // 6 segments
            case .one:   return [.rightTop, .rightBot]                                      // 2 segments *
            case .two:   return [.horizTop, .rightTop, .horizMid, .leftBot, .horizBot]      // 5 segments
            case .three: return [.horizTop, .horizMid, .horizBot, .rightTop, .rightBot]     // 5 segments
            case .four:  return [.leftTop, .rightTop, .horizMid, .rightBot]                 // 4 segments *
            case .five:  return [.horizTop, .horizMid, .horizBot, .leftTop, .rightBot]      // 5 segments
            case .six:   return Set(Segment.allCases.filter { $0 != .rightTop })            // 6 segments
            case .seven: return [.horizTop, .rightTop, .rightBot]                           // 3 segments *
            case .eight: return Set(Segment.allCases)                                       // 7 segments *
            case .nine:  return Set(Segment.allCases.filter { $0 != .leftBot })             // 6 segments
            }
        }
        
        /// Digits where the number of enabled segments is unique
        static var uniquelyIdentifiableDigits: [DisplayDigit] { [.one, .four, .seven, .eight] }
        
        var segmentCount: Int { return enabledSegments.count }
        
        var intValue: Int { return Self.allCases.firstIndex(of: self)! }
    }
    
    // MARK: - Helper functions
    
    static func solveLine(_ line: String) -> Int {
        let parts = line.components(separatedBy: " | ")
        let mapping = deduceMapping(input: parts.first!)
        let outputDigits = outputDigits(mapping: mapping, string: parts.last!)
        return intArrayToInt(outputDigits)
    }
    
    /// Note: With hindsight this goes far beyond what was required for the puzzle. This determines the full mapping of
    /// letters to specific segments, rather than just which sets of letters correspond to a given number.
    /// But the code can stay for posterity :)
    static func deduceMapping(input: String) -> SegmentMapping {
        var foundMappings: SegmentMapping = [:]
        var knownNumbers: [DisplayDigit: Set<Character>] = [:]
        var unsolvedDigitStrings = input.components(separatedBy: .whitespaces)
        
        // Figure out 1, 7, 4, 8 from unique segment counts
        for digit in DisplayDigit.uniquelyIdentifiableDigits {
            if let string = unsolvedDigitStrings.first(where: { $0.count == digit.segmentCount }) {
                knownNumbers[digit] = Set(Array(string))
                unsolvedDigitStrings = unsolvedDigitStrings.filter { $0.count != digit.segmentCount }
            }
        }
        guard knownNumbers.count == 4 else { fatalError("Failed to identify all unique numbers (1, 7, 8, 9)") }
        
        // Find the horizTop segment as it exists in 7 and not 1
        if let seven = knownNumbers[.seven], let one = knownNumbers[.one] {
            let horizTopLetter = seven.first { !one.contains($0) }!
            foundMappings[horizTopLetter] = .horizTop
        } else { fatalError("Could not find seven and one in input") }
        
        // Horizontal segments are the only common segments in all 5-segment digits, and can be uniqued via 4
        let fiveSegSets = Set(unsolvedDigitStrings.filter { $0.count == 5 }.map { Set(Array($0)) })
        let fiveSegOccurrenceCount = fiveSegSets.flatMap { Array($0) }.reduce(into: [Character: Int]()) { $0[$1] = $0[$1, default: 0] + 1 }
        let horizontalSegs = fiveSegOccurrenceCount.filter { $0.value == 3 }.map { $0.key }
        guard
            let horizTopLetter = foundMappings.first?.key,
            let fourDigitSegments = knownNumbers[.four]
        else { fatalError("Where do we go from here?") }
        let midBottomLetters = horizontalSegs.filter({ $0 != horizTopLetter })
        let middleSegment = midBottomLetters.filter { fourDigitSegments.contains($0) }.first!
        let bottomSegment = midBottomLetters.filter { $0 != middleSegment }.first!
        foundMappings[middleSegment] = .horizMid
        foundMappings[bottomSegment] = .horizBot
        // Now we know the characters in 1,4,7,8 and the segment characters for all the horizontal lines
        
        // Zero is the only six-segment character that doesn't include all the horizontal lines
        let sixSegSets = Set(unsolvedDigitStrings.filter { $0.count == 6 }.map { Set(Array($0)) })
        knownNumbers[.zero] = sixSegSets.first { !$0.isSuperset(of: horizontalSegs) }
        let sixAndNinePossibilities = sixSegSets.filter { $0 != knownNumbers[.zero] }
        // Nine contains all the segments in seven but six doesn't
        knownNumbers[.nine] = sixAndNinePossibilities.first { $0.isSuperset(of: knownNumbers[.seven]!) }
        knownNumbers[.six] = sixAndNinePossibilities.first { $0 != knownNumbers[.nine]! }
        // Now we know the characters in 0, 1, 4, 6, 7, 8, 9 and the segment chars for all horizontal lines. Need 2,3,5.
        
        // Six contains all the segments in five, but not 2 and 3
        knownNumbers[.five] = fiveSegSets.first { knownNumbers[.six]!.isSuperset(of: $0) }
        let twoAndThreePossibilities = fiveSegSets.filter { $0 != knownNumbers[.five] }
        // Nine contains all the segments in three but not two
        knownNumbers[.three] = twoAndThreePossibilities.first { knownNumbers[.nine]!.isSuperset(of: $0) }
        knownNumbers[.two] = twoAndThreePossibilities.first { $0 != knownNumbers[.three]! }
        
        // Now we've identified all the numbers uniquely, and all the horizontal segments, we just need the verticals
        foundMappings[knownNumbers[.five]!.first { !knownNumbers[.three]!.contains($0)}!] = .leftTop
        foundMappings[knownNumbers[.two]!.first { !knownNumbers[.nine]!.contains($0)}!] = .leftBot
        foundMappings[knownNumbers[.nine]!.first { !knownNumbers[.five]!.contains($0)}!] = .rightTop
        foundMappings[knownNumbers[.one]!.first { !knownNumbers[.two]!.contains($0)}!] = .rightBot
        
        // Return the mapping, hope we got everything!
        return foundMappings
    }
    
    static func outputDigits(mapping: SegmentMapping, string: String) -> [Int] {
        string
            .components(separatedBy: .whitespaces)  // Separate strings, e.g. ["ab", "abc"]
            .map { Array($0).map { mapping[$0]! } } // Segment arrays, e.g. [ [.rightTop, rightBot], [.rightTop, .rightBot, .horizTop] ]
            .map { segments in return DisplayDigit.allCases.first { $0.enabledSegments == Set(segments) }! } // DisplayDigits, e.g. [.one, .seven]
            .map { $0.intValue } // [1, 7]
    }
    
    // [1,2,3,4] -> 1234
    static func intArrayToInt(_ input: [Int]) -> Int {
        input
            .reversed()
            .enumerated()
            .map { $0.element * (pow(10, $0.offset) as NSDecimalNumber).intValue }
            .reduce(0, +)
    }
    
}
