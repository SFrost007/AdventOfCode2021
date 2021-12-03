import XCTest

class AoCTestCase: XCTestCase {
    
    private class func urlForTestResource(_ resource: String, withExtension: String) -> URL {
        let testBundle = Bundle(for: NSClassFromString(String(reflecting: Self.self))!)
        return testBundle.url(forResource: resource, withExtension: withExtension)!
    }
    
    class func urlForExampleData(day: Int, part: Int? = nil) -> URL {
        let partSuffix = part == nil ? "" : "_Part\(part!)"
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
