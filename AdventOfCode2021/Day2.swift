import Foundation

final class Day2: Day {
    
    // MARK: - Helper struct
    
    struct Instruction {
        let direction: Direction
        let distance: Int
        
        enum Direction: String {
            case forward, down, up
        }
        
        init(_ string: String) {
            let parts = string.components(separatedBy: .whitespaces)
            direction = Direction(rawValue: parts[0])!
            distance = Int(parts[1])!
        }
    }
    
    // MARK: - Initialisation
    
    let inputData: [Instruction]
    
    init(input: String) {
        inputData = input
            .components(separatedBy: .newlines)
            .filter { !$0.isEmpty }
            .map { Instruction($0) }
    }
    
    // MARK: - Problem cases
    
    func part1() -> Int {
        var x=0; var y=0
        for instruction in inputData {
            switch instruction.direction {
            case .forward: x += instruction.distance
            case .down: y += instruction.distance
            case .up: y -= instruction.distance
            }
        }
        return x * y
    }
    
    func part2() -> Int {
        var x=0; var y=0; var aim=0
        for instruction in inputData {
            switch instruction.direction {
            case .forward:
                x += instruction.distance
                y += instruction.distance * aim
            case .down: aim += instruction.distance
            case .up: aim -= instruction.distance
            }
        }
        return x * y
    }
    
}
