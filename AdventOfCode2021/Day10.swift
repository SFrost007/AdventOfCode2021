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
            .map { Self.validateLine($0) }
            .compactMap {
                switch $0 {
                case .valid, .incomplete(_): return nil
                case .corrupted(let bracketType): return bracketType.points
                }
            }
            .reduce(0, +)
    }
    
    func part2() -> Int {
        // TODO: Would be nice to do this fully functionally, but returning from some cases in the switch statement causes problems
        var incompleteLines: [[BracketType]] = []
        inputData
            .map { Self.validateLine($0) }
            .forEach {
                switch $0 {
                case .valid, .corrupted(_): break
                case .incomplete(let brackets): incompleteLines.append(brackets)
                }
            }
        
        var lineScores: [Int] = []
        for line in incompleteLines {
            var score = 0
            line.reversed().forEach {
                score = score * 5 + $0.closingScore
            }
            lineScores.append(score)
        }
        return lineScores.sorted()[(lineScores.count-1)/2]
    }
    
    // MARK: - Worker functions
    
    enum BracketType {
        case regular
        case square
        case curly
        case angled
        
        // Part 1
        var points: Int {
            switch self {
            case .regular: return 3
            case .square: return 57
            case .curly: return 1197
            case .angled: return 25137
            }
        }
        
        // Part 2
        var closingScore: Int {
            switch self {
            case .regular: return 1
            case .square: return 2
            case .curly: return 3
            case .angled: return 4
            }
        }
    }
    
    enum BracketChar: String.Element {
        case openRegular = "("
        case openSquare = "["
        case openCurly = "{"
        case openAngled = "<"
        case closeRegular = ")"
        case closeSquare = "]"
        case closeCurly = "}"
        case closeAngled = ">"
        
        var isOpening: Bool {
            switch self {
            case .openRegular, .openSquare, .openCurly, .openAngled: return true
            case .closeRegular, .closeSquare, .closeCurly, .closeAngled: return false
            }
        }
        
        var type: BracketType {
            switch self {
            case .openRegular, .closeRegular: return .regular
            case .openSquare, .closeSquare: return .square
            case .openCurly, .closeCurly: return .curly
            case .openAngled, .closeAngled: return .angled
            }
        }
    }
    
    enum ValidationResult {
        case valid
        case incomplete([BracketType])
        case corrupted(BracketType)
    }
    
    static func validateLine(_ line: String) -> ValidationResult {
        var openedBrackets: [BracketType] = []
        for bracketChar in line.compactMap({ BracketChar(rawValue: $0) }) {
            if bracketChar.isOpening {
                openedBrackets.append(bracketChar.type)
            } else if openedBrackets.popLast() != bracketChar.type {
                return .corrupted(bracketChar.type)
            }
        }
        return openedBrackets.isEmpty ? .valid : .incomplete(openedBrackets)
    }
    
}
