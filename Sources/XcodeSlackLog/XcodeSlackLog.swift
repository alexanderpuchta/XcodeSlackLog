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
        
        if let file = file,
           let line = lineNr {
            self.logger.log(level: .debug,
                            "\(msg)",
                            file: file,
                            line: line)
        } else {
            self.logger.debug("\(msg)")
        }
        
        
        guard let slack = self.slackURL else {
            self.error("no slack url added. please use XcodeSlackLog.setupSlack(url) to add your slack chatroom.")
            return
        }
        
        self.sendSlack(self.createSlackMessage(msg,
                                               level: .debug,
                                               file: file,
                                               lineNr: lineNr),
                       slack: slack)
    }
    
    /// Output of warning information with filename + linenumber
    /// - Parameters:
    ///   - msg: "\(object)"
    ///   - file: #file or nil
    ///   - lineNr: #line or nil
    public static func warning(_ msg: String, file: String? = nil, lineNr: UInt? = nil) {
        
        if let file = file,
           let line = lineNr {
            self.logger.log(level: .warning,
                            "\(msg)",
                            file: file,
                            line: line)
        } else {
            self.logger.warning("\(msg)")
        }
        
        guard let slack = self.slackURL else {
            self.error("no slack url added. please use XcodeSlackLog.setupSlack(url) to add your slack chatroom.")
            return
        }
        
        self.sendSlack(self.createSlackMessage(msg,
                                               level: .warning,
                                               file: file,
                                               lineNr: lineNr),
                       slack: slack)
    }
    
    /// Output of error information with filename + linenumber
    /// - Parameters:
    ///   - msg: "\(object)"
    ///   - file: #file or nil
    ///   - lineNr: #line or nil
    public static func error(_ msg: String, file: String? = nil, lineNr: UInt? = nil) {
        
        if let file = file,
           let line = lineNr {
            self.logger.log(level: .error,
                            "\(msg)",
                            file: file,
                            line: line)
        } else {
            self.logger.error("\(msg)")
        }
        
        guard let slack = self.slackURL else {
            self.error("no slack url added. please use XcodeSlackLog.setupSlack(url) to add your slack chatroom.")
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
        
        if let file = file,
           let line = lineNr {
            self.logger.log(level: .critical,
                            "\(msg)",
                            file: file,
                            line: line)
        } else {
            self.logger.critical("\(msg)")
        }
        
        guard let slack = self.slackURL else {
            self.error("no slack url added. please use XcodeSlackLog.setupSlack(url) to add your slack chatroom.")
            return
        }
        
        self.sendSlack(self.createSlackMessage(msg,
                                               level: .critical,
                                               file: file,
                                               lineNr: lineNr),
                       slack: slack)
    }
    
    
    // MARK: - Private
    
    private static func didSend() {
        print("did send message to slack")
    }
    
    private static func createSlackMessage(_ msg: String, level: SlackMessageLevel, file: String?, lineNr: UInt?) -> SlackMessage {
        return self.slackGenerator.create(message: msg,
                                          level: level,
                                          file: file,
                                          line: lineNr)
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
}
