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
    
    struct BingoBoard {
        struct Cell {
            var number: Int
            var called: Bool
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
            return false
        }
    }
    
    // MARK: - Problem cases
    
    func part1() -> Int {
        return -1
    }
    
    func part2() -> Int {
        return -1
    }
    
}
