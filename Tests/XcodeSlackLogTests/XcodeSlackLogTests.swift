import XCTest
@testable import XcodeSlackLog

final class XcodeSlackLogTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        
        XcodeSlackLog.critical("Hallo")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
