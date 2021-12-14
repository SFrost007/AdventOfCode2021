import Foundation

final class Day13: Day {
    
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
    
    init(input: String) {
        let inputData = input
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
        Self.getNewDots(from: dots, after: instructions.first!).count
    }
    
    func part2() -> Int {
        var currentDots = dots
        instructions.forEach { currentDots = Self.getNewDots(from: currentDots, after: $0) }
        Self.printGrid(from: currentDots, heading: "Answer for Day 13 Part 2:")
        return 0 // Not really unit testable
    }
    
    // MARK: - Helper functions
    
    static func getNewDots(from dots: [Dot], after instruction: FoldInstruction) -> [Dot] {
        let newDots = dots.map { (dot) -> Dot in
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
        return Array(Set(newDots)) // Only return unique dots
    }
    
    static func printGrid(from dots: [Dot], heading: String) {
        print("\(heading)\n")
        let paperWidth = dots.map { $0.x }.max()!
        let paperHeight = dots.map { $0.y }.max()!
        for y in 0...paperHeight {
            let rowString = (0...paperWidth)
                .map { x in dots.contains(where: { $0.x == x && $0.y == y }) ? "X" : " " }
                .joined(separator: "")
            print(rowString)
        }
        print("\n")
    }
    
}
