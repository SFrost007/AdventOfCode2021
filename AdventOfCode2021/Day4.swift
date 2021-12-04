import Foundation

class Day4 {
    
    // MARK: - Initialisation
    
    let calledNumbers: [Int]
    let bingoBoards: [BingoBoard]
    
    init(inputURL: URL) {
        let inputData = try! String(contentsOf: inputURL)
        let firstLine = inputData.components(separatedBy: .newlines).first!
        calledNumbers = firstLine.components(separatedBy: ",").compactMap { Int($0) }
        
        let inputWithoutCalledNumbers = inputData.components(separatedBy: .newlines)[2...].joined(separator: "\n")
        let boardsData = inputWithoutCalledNumbers.components(separatedBy: "\n\n")
        bingoBoards = boardsData.map { BingoBoard($0) }
    }
    
    // MARK: = Data structures
    
    class BingoBoard {
        class Cell {
            var number: Int
            var called: Bool
            
            init(number: Int, called: Bool) {
                self.number = number
                self.called = called
            }
        }
        
        var numberGrid: [[Cell]]
        
        init(_ string: String) {
            numberGrid = string
                .components(separatedBy: .newlines)
                .filter { !$0.isEmpty }
                .map {
                    $0.components(separatedBy: .whitespaces)
                        .compactMap { Int($0) }
                        .compactMap { Cell(number: $0, called: false) }
                }
        }
        
        func isCompleted() -> Bool {
            // Check for horizontal wins
            for row in numberGrid {
                if row.filter({ !$0.called }).isEmpty { return true }
            }
            // Check for vertical wins
            let gridSize = numberGrid.first!.count // Assumes a square grid
            for columnNum in 0..<gridSize {
                let columnCells = numberGrid.compactMap { $0[columnNum] }
                if columnCells.filter({ !$0.called }).isEmpty { return true }
            }
            // TODO: Check for diagonal wins. Got away without this for part 1
            
            // Board is incomplete
            return false
        }
        
        func handleCalledNumber(_ number: Int) {
            numberGrid.flatMap { $0 }.filter { $0.number == number }.forEach { $0.called = true }
        }
        
        func sumOfUncalledNumbers() -> Int {
            numberGrid
                .flatMap { $0 }
                .filter { !$0.called }
                .map { $0.number }
                .reduce(0, +)
        }
    }
    
    // MARK: - Problem cases
    
    func part1() -> Int {
        for calledNumber in calledNumbers {
            bingoBoards.forEach { $0.handleCalledNumber(calledNumber) }
            if let completedBoard = bingoBoards.filter({ $0.isCompleted() }).first {
                return completedBoard.sumOfUncalledNumbers() * calledNumber
            }
        }
        fatalError("No result found")
    }
    
    func part2() -> Int {
        return -1
    }
    
}
