import Foundation

class Day10 {
    
    // MARK: - Initialisation
    
    let inputData: [String]
    
    init(inputURL: URL) {
        inputData = try! String(contentsOf: inputURL)
            .components(separatedBy: .newlines)
            .filter { !$0.isEmpty }
    }
    
    // MARK: - Problem cases
    
    func part1() -> Int {
        inputData
            .compactMap {
                switch Self.validateLine($0) {
                case .valid, .incomplete(_): return nil
                case .corrupted(let bracketType): return bracketType.points
                }
            }
            .reduce(0, +)
    }
    
    func part2() -> Int {
        inputData
            .compactMap {
                switch Self.validateLine($0) {
                case .valid, .corrupted(_): return nil
                case .incomplete(let brackets): return brackets
                }
            }
            .map { (line: [Bracket]) -> Int in
                var score = 0
                line.reversed().forEach { score = score * 5 + $0.closingScore }
                return score
            }
            .sorted()
            .middle! // Uses helper extension below
    }
    
    // MARK: - Worker functions
    
    enum Bracket: String.Element {
        case openRegular = "("
        case openSquare = "["
        case openCurly = "{"
        case openAngled = "<"
        case closeRegular = ")"
        case closeSquare = "]"
        case closeCurly = "}"
        case closeAngled = ">"
        
        enum BracketType {
            case regular
            case square
            case curly
            case angled
        }
        
        var type: BracketType {
            switch self {
            case .openRegular, .closeRegular: return .regular
            case .openSquare, .closeSquare: return .square
            case .openCurly, .closeCurly: return .curly
            case .openAngled, .closeAngled: return .angled
            }
        }
        
        var isOpening: Bool {
            switch self {
            case .openRegular, .openSquare, .openCurly, .openAngled: return true
            case .closeRegular, .closeSquare, .closeCurly, .closeAngled: return false
            }
        }
        
        // Part 1
        var points: Int {
            switch self.type {
            case .regular: return 3
            case .square: return 57
            case .curly: return 1197
            case .angled: return 25137
            }
        }
        
        // Part 2
        var closingScore: Int {
            switch self.type {
            case .regular: return 1
            case .square: return 2
            case .curly: return 3
            case .angled: return 4
            }
        }
    }
    
    enum ValidationResult {
        case valid
        case incomplete([Bracket])
        case corrupted(Bracket)
    }
    
    static func validateLine(_ line: String) -> ValidationResult {
        var openedBrackets: [Bracket] = []
        for bracket in line.compactMap({ Bracket(rawValue: $0) }) {
            if bracket.isOpening {
                openedBrackets.append(bracket)
            } else if openedBrackets.popLast()?.type != bracket.type {
                return .corrupted(bracket)
            }
        }
        return openedBrackets.isEmpty ? .valid : .incomplete(openedBrackets)
    }
    
}

// MARK: - Helpers

fileprivate extension Array {
    var middle: Element? {
        guard count > 0 else { return nil }
        return self[(self.count-1) / 2]
    }
}
