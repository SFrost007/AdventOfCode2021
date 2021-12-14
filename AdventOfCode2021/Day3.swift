import Foundation

final class Day3: Day {
    
    // MARK: - Initialisation
    
    let inputData: [String]
    
    init(input: String) {
        inputData = input
            .components(separatedBy: .newlines)
            .filter { !$0.isEmpty }
    }
    
    // MARK: - Part 1
    
    func part1() -> Int {
        let gammaString = Self.calculateGammaRate(in: inputData)
        let epsilonString = Self.calculateEpsilonRate(from: gammaString)
        return Self.binaryToDecimal(gammaString) * Self.binaryToDecimal(epsilonString)
    }
    
    static func calculateGammaRate(in input: [String]) -> String {
        String(findMostCommonValues(in: input))
    }
    
    static func calculateEpsilonRate(from gammaRate: String) -> String {
        gammaRate.map { $0 == "0" ? "1" : "0" }.joined() // Just invert the binary string
    }
    
    // MARK: - Part 2
    
    func part2() -> Int {
        Component.allCases
            .map { Self.findComponentRating(in: inputData, for: $0) }
            .map { Self.binaryToDecimal($0) }
            .reduce(1, *)
    }
    
    enum Component: CaseIterable {
        case oxygenGenerator
        case co2Scrubber
        
        func filter(input: [String], at position: Int) -> [String] {
            let mostCommonValue = Day3.findMostCommonValues(in: input)[position]
            switch self {
            case .oxygenGenerator:  return input.filter { $0[position] == mostCommonValue }
            case .co2Scrubber:      return input.filter { $0[position] != mostCommonValue }
            }
        }
    }
    
    static func findComponentRating(in input: [String], for component: Component) -> String {
        var filteredInput = input
        for position in 0..<input.first!.count {
            filteredInput = component.filter(input: filteredInput, at: position)
            if filteredInput.count == 1 { break }
        }
        return filteredInput.first!
    }
    
    // MARK: - Worker functions
    
    // Returns e.g. ["1", "0", "1", "0", "1"]
    private static func findMostCommonValues(in input: [String]) -> [String.Element] {
        input
            .map { Array($0).map { Int(String($0)) } } // ["01101", "11111"] -> [ [0,1,1,0,1], [1,1,1,1,1] ]
            .reduce( createZeroedIntArray(length: input.first!.count) ) { partialResult, thisValue in
                partialResult.enumerated().map { (index, item) in
                    item + thisValue[index]!
                }
            }
            .map { $0 >= ((input.count + 1) / 2) ? "1" : "0" } // Note: 1 takes precedent on a tie
    }
    
    private static func createZeroedIntArray(length: Int) -> [Int] {
        (0..<length).map { _ in 0 }
    }
    
    static func binaryToDecimal(_ binary: String) -> Int {
        Int(binary, radix: 2) ?? -1
    }
}

// MARK: - Helpers

fileprivate extension StringProtocol {
    /// Get character by index
    subscript(_ offset: Int) -> Element { self[index(startIndex, offsetBy: offset)] }
}
