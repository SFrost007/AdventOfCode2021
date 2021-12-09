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
    
    class RowAndRange {
        let row: Int
        let range: Range<Int>
        var checkedDeeper: Bool = false
        
        init(row: Int, range: Range<Int>) {
            self.row = row
            self.range = range
        }
    }
    
    func part2() -> Int {
        // Map the 2d int array into a flat array of contiguous non-9 Ranges paired with the rows they appear on
        var searchRanges = inputData.enumerated().flatMap { line in
            Self.nonNineRanges(in: line.element)
                .map { RowAndRange(row: line.offset, range: $0) }
        }
        
        var basins: [[RowAndRange]] = []
        while !searchRanges.isEmpty {
            var basin: [RowAndRange] = [searchRanges.removeFirst()]
            while var currentRange = basin.first(where: { !$0.checkedDeeper } ) {
                while let nextRange = searchRanges.first(where: { $0.row == currentRange.row + 1 && $0.range.overlaps(currentRange.range) }) {
                    searchRanges.removeAll(where: { $0.row == nextRange.row && $0.range == nextRange.range })
                    currentRange = nextRange
                    basin.append(currentRange)
                }
                currentRange.checkedDeeper = true
            }
            basins.append(basin)
        }
        
        let basinSizes = basins.map { $0.map { $0.range.count }.reduce(0, +) }
        return basinSizes.sorted().suffix(3).reduce(1, *)
    }
    
    // Eg 12394599929 = 0..<3,
    static func nonNineRanges(in intArray: [Int]) -> [Range<Int>] {
        var ranges: [Range<Int>] = []
        var lastStart = 0
        for digit in intArray.enumerated() {
            if digit.element != 9 { continue }
            if lastStart != digit.offset {
                ranges.append(lastStart..<digit.offset)
            }
            lastStart = digit.offset + 1
        }
        // Add the last range if applicable
        if lastStart < intArray.count {
            ranges.append(lastStart..<intArray.count)
        }
        return ranges
    }
    
}
