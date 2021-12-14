import Foundation

final class Day5: Day {
    
    // MARK: - Initialisation
    
    let lines: [Line]
    
    init(input: String) {
        lines = input
            .components(separatedBy: .newlines)
            .filter { !$0.isEmpty }
            .map { Line($0) }
    }
    
    // MARK: - Data structures
    
    struct Line {
        
        struct Coord: Hashable {
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
        }
        
        let startPoint: Coord
        let endPoint: Coord
        
        init(_ string: String) {
            let coords = string.components(separatedBy: " -> ").map { Coord($0) }
            startPoint = coords.first!
            endPoint = coords.last!
        }
        
        var isHorizontalOrVertical: Bool {
            return startPoint.x == endPoint.x || startPoint.y == endPoint.y
        }
        
        var coordsCovered: [Coord] {
            if startPoint.x == endPoint.x { // Vertical
                return (min(startPoint.y,endPoint.y)...max(startPoint.y,endPoint.y)).map { Coord(x: startPoint.x, y: $0) }
            } else if startPoint.y == endPoint.y { // Horizontal
                return (min(startPoint.x,endPoint.x)...max(startPoint.x,endPoint.x)).map { Coord(x: $0, y: startPoint.y) }
            } else { // Diagonal
                return (0...abs(startPoint.x - endPoint.x)).map {
                    Coord(
                        x: startPoint.x < endPoint.x ? startPoint.x + $0 : startPoint.x - $0,
                        y: startPoint.y < endPoint.y ? startPoint.y + $0 : startPoint.y - $0
                    )
                }
            }
        }
    }
    
    // MARK: - Problem cases
    
    func findRepeatedCoords(includeDiagonals: Bool) -> Int {
        lines
            .filter { includeDiagonals || $0.isHorizontalOrVertical }
            .flatMap { $0.coordsCovered }
            .reduce(into: [:]) { dict, coord in
                dict[coord] = dict[coord, default: 0] + 1
            }
            .filter { $0.value > 1 }
            .count
    }
    
    func part1() -> Int {
        findRepeatedCoords(includeDiagonals: false)
    }
    
    func part2() -> Int {
        findRepeatedCoords(includeDiagonals: true)
    }
    
}
