import XCTest
@testable import XcodeSlackLog

final class XcodeSlackLogTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        
        XcodeSlackLog.setupSlack("https://hooks.slack.com/services/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")
        
        XcodeSlackLog.debug("Hallo", file: #file, lineNr: #line)
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
