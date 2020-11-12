// 
// Created by Alexander Puchta in 2020
// 
// 

import Foundation
import Logging

open class XcodeSlackLog {
    
    // Properties    
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
        
        self.createLog(.info,
                       message: msg,
                       file: file,
                       line: lineNr)
    }
    
    /// Output of warning information with filename + linenumber
    /// - Parameters:
    ///   - msg: "\(object)"
    ///   - file: #file or nil
    ///   - lineNr: #line or nil
    public static func warning(_ msg: String, file: String? = nil, lineNr: UInt? = nil) {
        
        self.createLog(.warning,
                       message: msg,
                       file: file,
                       line: lineNr)
    }
    
    /// Output of error information with filename + linenumber
    /// - Parameters:
    ///   - msg: "\(object)"
    ///   - file: #file or nil
    ///   - lineNr: #line or nil
    public static func error(_ msg: String, file: String? = nil, lineNr: UInt? = nil) {
        
        self.createLog(.error,
                       message: msg,
                       file: file,
                       line: lineNr)
        
        guard let slack = self.slackURL else {
            self.slackError()
            return
        }
        
        self.sendSlack(self.createSlackMessage(msg,
                                               level: .error,
                                               file: file,
                                               lineNr: lineNr),
                       slack: slack)
    }
    
    /// Output of critical information with filename + linenumber
    /// - Parameters:
    ///   - msg: "\(object)"
    ///   - file: #file or nil
    ///   - lineNr: #line or nil
    public static func critical(_ msg: String, file: String? = nil, lineNr: UInt? = nil) {
        
        self.createLog(.critical,
                       message: msg,
                       file: file,
                       line: lineNr)
        
        guard let slack = self.slackURL else {
            self.slackError()
            return
        }
        
        self.sendSlack(self.createSlackMessage(msg,
                                               level: .critical,
                                               file: file,
                                               lineNr: lineNr),
                       slack: slack)
    }
    
    
    // MARK: - Private
    
    private static func createLog(_ level: Logger.Level, message: String, file: String?, line: UInt?) {
        
        self.logger.log(level: level,
                        "\(message)",
                        file: file ?? #file,
                        line: line ?? #line)
    }
    
    private static func createSlackMessage(_ msg: String, level: SlackMessageLevel, file: String?, lineNr: UInt?) -> SlackMessage {
        return self.slackGenerator.create(message: msg,
                                          level: level,
                                          file: file,
                                          line: lineNr)
    }
    
    private static func didSend() {
        self.createLog(.info,
                       message: "message sent successfully",
                       file: nil,
                       line: nil)
    }
    
    private static func sendSlack(_ msg: SlackMessage, slack: String) {
        self.slackHandler.send(msg,
                               slackURL: slack) { response in
            switch response {
            case .failure(let err):     self.error("\(err)")
                
            case .success:              self.didSend()
            }
        }
    }
    
    private static func slackError() {
        self.createLog(.error,
                       message: "no slack url added. please use XcodeSlackLog.setupSlack(url) to add your slack chatroom",
                       file: nil,
                       line: nil)
    }
}
