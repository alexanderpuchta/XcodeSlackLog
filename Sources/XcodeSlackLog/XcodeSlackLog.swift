// 
// Created by Alexander Puchta in 2020
// 
// 

import Foundation

open class XcodeSlackLog {
    
    /// Output of debug information with filename + linenumber
    /// - Parameters:
    ///   - msg: "\(object)"
    ///   - file: #file or nil
    ///   - lineNr: #line or nil
    public static func debug(_ msg: String, file: String? = nil, lineNr: UInt? = nil) {
        print("debug :: \(msg) :: file :: \(file ?? "") :: lineNr :: \(lineNr ?? 0)")
    }
    
    /// Output of warning information with filename + linenumber
    /// - Parameters:
    ///   - msg: "\(object)"
    ///   - file: #file or nil
    ///   - lineNr: #line or nil
    public static func warning(_ msg: String, file: String? = nil, lineNr: UInt? = nil) {
        print("warning :: \(msg) :: file :: \(file ?? "") :: lineNr :: \(lineNr ?? 0)")
    }
    
    /// Output of error information with filename + linenumber
    /// - Parameters:
    ///   - msg: "\(object)"
    ///   - file: #file or nil
    ///   - lineNr: #line or nil
    public static func error(_ msg: String, file: String? = nil, lineNr: UInt? = nil) {
        print("error :: \(msg) :: file :: \(file ?? "") :: lineNr :: \(lineNr ?? 0)")
    }
    
    /// Output of critical information with filename + linenumber
    /// - Parameters:
    ///   - msg: "\(object)"
    ///   - file: #file or nil
    ///   - lineNr: #line or nil
    public static func critical(_ msg: String, file: String? = nil, lineNr: UInt? = nil) {
        print("critical :: \(msg) :: file :: \(file ?? "") :: lineNr :: \(lineNr ?? 0)")
    }
}
