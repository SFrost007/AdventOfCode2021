import Foundation

class Day7 {
    
    // MARK: - Initialisation
    
    let inputData: [Int]
    
    init(inputURL: URL) {
        inputData = try! String(contentsOf: inputURL)
            .trimmingCharacters(in: .newlines)
            .components(separatedBy: ",")
            .compactMap { Int($0) }
    }
    
    // MARK: - Problem cases
    
    func part1() -> Int {
        var minDistance = Int.max
        for i in inputData.min()!...inputData.max()! {
            let distance = inputData
                .map { abs($0-i) }
                .reduce(0, +)
            minDistance = min(distance, minDistance)
        }
        return minDistance
    }
    
    // TODO: This is just brute force and took 6 minutes to execute, but gets the right answer
    func part2() -> Int {
        var minDistance = Int.max
        for i in inputData.min()!...inputData.max()! {
            let distance = inputData
                .map { abs($0-i) }
                .flatMap { (0...$0).map{$0} }
                .reduce(0, +)
            minDistance = min(distance, minDistance)
        }
        return minDistance
    }
    
}
