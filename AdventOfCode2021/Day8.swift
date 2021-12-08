import Foundation

class Day8 {
    
    // MARK: - Initialisation
    
    let inputData: [String]
    
    init(inputURL: URL) {
        inputData = try! String(contentsOf: inputURL)
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
    
    static func deduceMapping(input: String) -> SegmentMapping {
        var foundMappings: SegmentMapping = [:]
        // Step 1: Figure out 1, 7, 4, 8 from unique segment counts
        // Step 2: Figure out what's horizTop from being in 7 and not 1
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
