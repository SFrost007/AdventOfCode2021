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
    
    class RowAndRange: Equatable, CustomStringConvertible {
        var description: String {
            return "\(row): \(range)"
        }
        
        static func == (lhs: Day9.RowAndRange, rhs: Day9.RowAndRange) -> Bool {
            lhs.row == rhs.row && lhs.range == rhs.range
        }
        
        let row: Int
        let range: Range<Int>
        var checkedDeeper: Bool = false
        
        init(row: Int, range: Range<Int>) {
            self.row = row
            self.range = range
        }
    }
    typealias Basin = [RowAndRange]
    
    func part2() -> Int {
        // Map the 2d int array into a flat array of contiguous non-9 Ranges paired with the rows they appear on
        var searchRanges = inputData.enumerated().flatMap { line in
            Self.nonNineRanges(in: line.element)
                .map { RowAndRange(row: line.offset, range: $0) }
        }
        
        var basins: [Basin] = []
        while !searchRanges.isEmpty {
            // Take a range from the front, then keep checking rows below to find ranges that overlap with it
            var basin: Basin = [searchRanges.removeFirst()]
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
        
        // The above only searches downwards, but other basins could overlap upwards. Brute-force search for these :(
        print("Pre-fix:  \(basins.count): \(Self.getBasinSizes(from: basins).map { "\($0)" }.joined(separator: ","))")
        while let overlapResult = Self.findOverlaps(in: basins) {
            var firstBasin = basins.first { $0 == overlapResult.0 }!
            firstBasin.append(contentsOf: overlapResult.1)
            basins.removeAll(where: { $0 == overlapResult.1 })
        }
        print("Post-fix: \(basins.count): \(Self.getBasinSizes(from: basins).map { "\($0)" }.joined(separator: ","))")
        
        return Self.getBasinSizes(from: basins).sorted().suffix(3).reduce(1, *)
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
    
    // This is horrendous, an attempt at salvaging an answer from a bad solution to start with
    static func findOverlaps(in basins: [Basin]) -> (Basin, Basin)? {
        print("Checking \(basins.count) basins for overlaps")
        for basin in basins {
            for otherBasin in basins.filter({ $0 != basin }) {
                for row in basin {
                    for otherRow in otherBasin {
                        if row.range.overlaps(otherRow.range) && abs(row.row - otherRow.row) < 2 {
                            print("  Found an overlap: \(row) vs \(otherRow)")
                            return (basin, otherBasin)
                        }
                    }
                }
            }
        }
        print("  None found!")
        return nil
    }
    
    static func getBasinSizes(from basins: [Basin]) -> [Int] {
        basins.map { $0.map { $0.range.count }.reduce(0, +) }
    }
    
}
