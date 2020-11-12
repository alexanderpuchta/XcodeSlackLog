import XCTest
@testable import XcodeSlackLog

final class XcodeSlackLogTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        
        XcodeSlackLog.debug("Hallo")
        XcodeSlackLog.warning("123", file: #file, lineNr: #line)
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
