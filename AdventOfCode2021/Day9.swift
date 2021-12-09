import Foundation

class Day9 {
    
    // MARK: - Initialisation
    
    let inputData: [[Int]]
    
    init(inputURL: URL) {
        inputData = try! String(contentsOf: inputURL)
            .components(separatedBy: .newlines)
            .filter { !$0.isEmpty }
            .map { Array($0).compactMap { Int(String($0)) } }
    }
    
    // MARK: - Problem cases
    
    func part1() -> Int {
        let gridWidth = inputData.first!.count
        let gridHeight = inputData.count
        var lowPoints: [Int] = []
        for x in 0..<gridWidth {
            for y in 0..<gridHeight {
                let thisValue = inputData[y][x]
                if x > 0 && thisValue >= inputData[y][x-1] { continue }
                if x < gridWidth-1 && thisValue >= inputData[y][x+1] { continue }
                if y > 0 && thisValue >= inputData[y-1][x] { continue }
                if y < gridHeight-1 && thisValue >= inputData[y+1][x] { continue }
                lowPoints.append(thisValue)
            }
        }
        return lowPoints.reduce(0, +) + lowPoints.count
    }
    
    func part2() -> Int {
        fatalError("Not yet implemented")
    }
    
}
