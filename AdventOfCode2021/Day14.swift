import Foundation

class Day14 {
    
    // MARK: - Initialisation
    
    let template: String
    let rules: [String: String]
    
    init(inputURL: URL) {
        let inputData = try! String(contentsOf: inputURL)
            .trimmingCharacters(in: .newlines)
            .components(separatedBy: "\n\n")
        template = inputData[0]
        rules = inputData[1]
            .components(separatedBy: .newlines)
            .reduce(into: [:], {
                let parts = $1.components(separatedBy: " -> ")
                $0[parts[0]] = parts[1]
            })
    }
    
    // MARK: - Problem cases
    
    func part1() -> Int {
        fatalError("Not yet implemented")
    }
    
    func part2() -> Int {
        fatalError("Not yet implemented")
    }
    
}
