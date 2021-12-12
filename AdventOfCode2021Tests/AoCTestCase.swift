import XCTest

class AoCTestCase: XCTestCase {
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
    }
    
    private class func urlForTestResource(_ resource: String, withExtension: String) -> URL {
        let testBundle = Bundle(for: NSClassFromString(String(reflecting: Self.self))!)
        return testBundle.url(forResource: resource, withExtension: withExtension)!
    }
    
    class func urlForExampleData(day: Int, partSuffix: String? = nil) -> URL {
        let partSuffix = partSuffix == nil ? "" : "_Part\(partSuffix!)"
        return urlForTestResource("Day\(day)_Example\(partSuffix)", withExtension: "txt")
    }
    
    class func urlForMyInputData(day: Int) -> URL {
        return urlForTestResource("Day\(day)_MyInput", withExtension: "txt")
    }
    
    func printAnswer(day: Int, part: Int, answer: Any) {
        let answerString = "Answer for Day \(day) Part \(part): \(answer)"
        print("┌\(String(repeating: "─", count: answerString.count+2))┐")
        print("│ \(answerString) │")
        print("└\(String(repeating: "─", count: answerString.count+2))┘")
    }
    
}
