// 
// Created by Alexander Puchta in 2020
// 
// 

import Foundation
import Logging

open class XcodeSlackLog {
    
    // Properties
    
    private static let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = .autoupdatingCurrent
        dateFormatter.dateFormat = "dd.MM - HH:mm:ss"
        return dateFormatter
    }()
    
    private static let logger = Logger(label: "xcodeslacklog",
                                       factory: XcodeLogHandler.output)
    
    private static let slackHandler = XcodeSlackHandler()
    private static let slackGenerator = SlackMessageGenerator()
    private(set) static var slackURL: String?
    
    
    // MARK: - Setup
    
    
    /// Setup the URL to your Slack-Chat-Room
    /// - Parameter url: Slack-URL as string
    public static func setupSlack(_ url: String) {
        self.slackURL = url
    }
    
    
    // MARK: - Functionality
    
    /// Output of debug information with filename + linenumber
    /// - Parameters:
    ///   - msg: "\(object)"
    ///   - file: #file or nil
    ///   - lineNr: #line or nil
    public static func debug(_ msg: String, file: String? = nil, lineNr: UInt? = nil) {
        print("debug :: \(msg) :: file :: \(file ?? "") :: lineNr :: \(lineNr ?? 0)")
        
        guard let slack = self.slackURL else {
            self.error("no slack url added. please use XcodeSlackLog.setupSlack(url) to add your slack chatroom.")
            return
        }
        
        let slackMessage = self.slackGenerator.create(message: msg,
                                   level: .debug,
                                   file: file,
                                   line: lineNr)
        
        self.slackHandler.send(slackMessage,
                               slackURL: slack) { response in
            switch response {
            case .failure(let err):     self.error("\(err)")
                
            case .success:              self.debug("slack message sent.")
            }
        }
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
