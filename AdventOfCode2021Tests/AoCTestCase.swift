import XCTest

class AoCTestCase: XCTestCase {
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
    }
    
    // MARK: - Helpers for getting input data from text files
    
    static func myInput(day: Int) -> String {
        try! String(contentsOf: urlForMyInputData(day: day))
    }
    
    static func exampleInput(day: Int, partSuffix: String? = nil) -> String {
        try! String(contentsOf: urlForExampleData(day: day, partSuffix: partSuffix))
    }
    
    private static func urlForTestResource(_ resource: String, withExtension: String) -> URL {
        let testBundle = Bundle(for: NSClassFromString(String(reflecting: Self.self))!)
        return testBundle.url(forResource: resource, withExtension: withExtension)!
    }
    
    private static func urlForExampleData(day: Int, partSuffix: String? = nil) -> URL {
        let partSuffix = partSuffix == nil ? "" : "_Part\(partSuffix!)"
        return urlForTestResource("Day\(day)_Example\(partSuffix)", withExtension: "txt")
    }
    
    private static func urlForMyInputData(day: Int) -> URL {
        return urlForTestResource("Day\(day)_MyInput", withExtension: "txt")
    }
    
    // MARK: - Answer pretty printing
    
    /// Prints the answer in a nice box so it stands out in the console
    func printAnswer(day: Int, part: Int, answer: Any) {
        let answerString = "Answer for Day \(day) Part \(part): \(answer)"
        print("┌\(String(repeating: "─", count: answerString.count+2))┐")
        print("│ \(answerString) │")
        print("└\(String(repeating: "─", count: answerString.count+2))┘")
    }
    
}
