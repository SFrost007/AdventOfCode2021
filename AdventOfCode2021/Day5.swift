import Foundation

class Day5 {
    
    // MARK: - Initialisation
    
    let lines: [Line]
    
    init(inputURL: URL) {
        lines = try! String(contentsOf: inputURL)
            .components(separatedBy: .newlines)
            .filter { !$0.isEmpty }
            .map { Line($0) }
    }
    
    // MARK: - Data structures
    
    struct Line {
        
        struct Coord: Equatable, Comparable, Hashable {
            let x: Int
            let y: Int
            
            init(_ string: String) {
                x = Int(string.components(separatedBy: ",")[0])!
                y = Int(string.components(separatedBy: ",")[1])!
            }
            
            init(x: Int, y: Int) {
                self.x = x
                self.y = y
            }
            
            static func < (lhs: Day5.Line.Coord, rhs: Day5.Line.Coord) -> Bool {
                return lhs.x < rhs.x || lhs.y < rhs.y
            }
        }
        
        let startPoint: Coord
        let endPoint: Coord
        
        init(_ string: String) {
            let coords = string.components(separatedBy: " -> ").map { Coord($0) }.sorted()
            startPoint = coords.first!
            endPoint = coords.last!
        }
        
        var isHorizontalOrVertical: Bool {
            return startPoint.x == endPoint.x || startPoint.y == endPoint.y
        }
        
        var coordsCovered: [Coord] {
            if startPoint.x == endPoint.x { // Vertical
                return (startPoint.y...endPoint.y).map { Coord(x: startPoint.x, y: $0) }
            } else if startPoint.y == endPoint.y { // Horizontal
                return (startPoint.x...endPoint.x).map { Coord(x: $0, y: startPoint.y) }
            } else {
                fatalError("Not implemented for diagonals")
            }
        }
    }
    
    // MARK: - Problem cases
    
    func part1() -> Int {
        lines
            .filter { $0.isHorizontalOrVertical }
            .flatMap { $0.coordsCovered }
            .reduce(into: [:]) { dict, coord in
                dict[coord] = dict[coord, default: 0] + 1
            }
            .filter { $0.value > 1 }
            .count
    }
    
    func part2() -> Int {
        fatalError("Not yet implemented")
    }
    
}
