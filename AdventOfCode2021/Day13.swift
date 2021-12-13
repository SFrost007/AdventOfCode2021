import Foundation

class Day13 {
    
    // MARK: - Initialisation
    
    struct Dot: Hashable {
        let x: Int
        let y: Int
    }
    
    struct FoldInstruction {
        enum Axis: String {
            case x, y
        }
        let axis: Axis
        let value: Int
    }
    
    let dots: [Dot]
    let instructions: [FoldInstruction]
    
    init(inputURL: URL) {
        let inputData = try! String(contentsOf: inputURL)
            .components(separatedBy: "\n\n")
        dots = inputData
            .first!
            .components(separatedBy: .newlines)
            .filter { !$0.isEmpty }
            .map { $0.components(separatedBy: ",") }
            .map { Dot(x: Int($0.first!)!, y: Int($0.last!)!) }
        instructions = inputData
            .last!
            .components(separatedBy: .newlines)
            .filter { !$0.isEmpty }
            .map { $0.replacingOccurrences(of: "fold along ", with: "") }
            .map { $0.components(separatedBy: "=") }
            .map { FoldInstruction(axis: FoldInstruction.Axis(rawValue: $0.first!)!, value: Int($0.last!)!) }
    }
    
    // MARK: - Problem cases
    
    func part1() -> Int {
        Set(Self.getNewDots(from: dots, after: instructions.first!)).count
    }
    
    func part2() -> Int {
        var currentDots = dots
        instructions.forEach { currentDots = Self.getNewDots(from: currentDots, after: $0) }
        print("Answer for Day 13 Part 2:\n")
        Self.printGrid(from: currentDots)
        print("\n")
        return 0 // Not really unit testable
    }
    
    // MARK: - Helper functions
    
    static func getNewDots(from dots: [Dot], after instruction: FoldInstruction) -> [Dot] {
        dots.map { (dot) -> Dot in
            switch instruction.axis {
            case .x:
                guard dot.x > instruction.value else { return dot }
                let newValue = instruction.value - (dot.x - instruction.value)
                return Dot(x: newValue, y: dot.y)
            case .y:
                guard dot.y > instruction.value else { return dot }
                let newValue = instruction.value - (dot.y - instruction.value)
                return Dot(x: dot.x, y: newValue)
            }
        }
    }
    
    static func printGrid(from dots: [Dot]) {
        let paperWidth = dots.map { $0.x }.max()!
        let paperHeight = dots.map { $0.y }.max()!
        for y in 0...paperHeight {
            let rowString = (0...paperWidth)
                .map { x in dots.contains(where: { $0.x == x && $0.y == y }) ? "X" : " " }
                .joined(separator: "")
            print(rowString)
        }
    }
    
}
