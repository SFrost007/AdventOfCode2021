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
        let lowPointLocations = Self.findLowPoints(in: inputData)
        let lowPointValues = lowPointLocations.map { inputData[$0.y][$0.x] }
        return lowPointValues.reduce(0, +) + lowPointValues.count
    }
    
    func part2() -> Int {
        Self.findLowPoints(in: inputData)
            .map { Self.findBasinLocations(from: $0, currentBasin: [], in: inputData)}
            .map { $0.count }
            .sorted()
            .suffix(3)
            .reduce(1, *)
    }
    
    // MARK: - Worker functions
    
    struct GridLocation: Hashable {
        let x: Int
        let y: Int
    }
    
    static func findLowPoints(in input: [[Int]]) -> [GridLocation] {
        let gridWidth = input.first!.count
        let gridHeight = input.count
        var lowPoints: [GridLocation] = []
        for x in 0..<gridWidth {
            for y in 0..<gridHeight {
                let thisValue = input[y][x]
                if x > 0 && thisValue >= input[y][x-1] { continue }
                if x < gridWidth-1 && thisValue >= input[y][x+1] { continue }
                if y > 0 && thisValue >= input[y-1][x] { continue }
                if y < gridHeight-1 && thisValue >= input[y+1][x] { continue }
                lowPoints.append(GridLocation(x: x, y: y))
            }
        }
        return lowPoints
    }
    
    static func findBasinLocations(from location: GridLocation, currentBasin: Set<GridLocation>, in input: [[Int]]) -> Set<GridLocation> {
        guard !currentBasin.contains(location) else { return [] }
        guard location.x >= 0, location.x < input.first!.count else { return [] }
        guard location.y >= 0, location.y < input.count else { return [] }
        guard input[location.y][location.x] != 9 else { return [] }
        var newBasin = currentBasin
        newBasin.insert(location)
        newBasin = newBasin.union(findBasinLocations(from: GridLocation(x: location.x-1, y: location.y), currentBasin: newBasin, in: input))
        newBasin = newBasin.union(findBasinLocations(from: GridLocation(x: location.x+1, y: location.y), currentBasin: newBasin, in: input))
        newBasin = newBasin.union(findBasinLocations(from: GridLocation(x: location.x, y: location.y-1), currentBasin: newBasin, in: input))
        newBasin = newBasin.union(findBasinLocations(from: GridLocation(x: location.x, y: location.y+1), currentBasin: newBasin, in: input))
        return newBasin
    }
}
