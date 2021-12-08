import Foundation

class Day8 {
    
    // MARK: - Initialisation
    
    let inputData: [String]
    
    init(inputURL: URL) {
        inputData = try! String(contentsOf: inputURL)
            .components(separatedBy: .newlines)
            .filter { !$0.isEmpty }
    }
    
    // MARK: - Problem cases
    
    func part1() -> Int {
        let outputParts =  inputData.compactMap { $0.components(separatedBy: " | ").last }
        let outputSegments = outputParts.flatMap { $0.components(separatedBy: .whitespaces) }
        let correctNumbers = outputSegments.filter { $0.count == 2 || $0.count == 3 || $0.count == 4 || $0.count == 7 }
        return correctNumbers.count
    }
    
    func part2() -> Int {
        fatalError("Not yet implemented")
    }
    
}
