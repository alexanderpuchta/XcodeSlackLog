// 
// Created by Alexander Puchta in 2020
// 
// 

import Foundation
import Logging

class XcodeSlackLogHandler: LogHandler {
    
    struct Constants {
        static let fileName = "XcodeSlackLog.swift"
    }
    
    // Properties
    private lazy var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = .autoupdatingCurrent
        dateFormatter.dateFormat = "dd.MM - HH:mm:ss"
        return dateFormatter
    }()
    
    private let label: String
    private let stream: TextOutputStream
    
    public var logLevel: Logger.Level = .info
    public var slackLevel: Logger.Level = .warning
    public var metadata: Logger.Metadata = [:]
    
    
    
    public subscript(metadataKey key: String) -> Logger.Metadata.Value? {
        
        get {
            self.metadata[key]
        }
        set(newValue) {
            self.metadata[key] = newValue
        }
    }
    
    
    // MARK: - Init
    
    init(label: String, stream: TextOutputStream) {
        self.label = label
        self.stream = stream
    }
    
    public func log(level: Logger.Level, message: Logger.Message, metadata: Logger.Metadata?, source: String, file: String, function: String, line: UInt) {
        
        let icon = self.getLogHeader(level)
        var parameters = self.metadata
        if let metadata = metadata {
            parameters.merge(metadata, uniquingKeysWith: { (_, new) in new })
        }
        
        var fileName: String?
        if !(file.split(separator: "/").last?.elementsEqual(Constants.fileName) ?? false) {
            fileName = file.split(separator: "/").last?.description
        }
        
        let time = self.getTime()
        self.output(message.description, icon: icon, fileInfo: "\(fileName ?? "")[:\(line)]", time: time)
    }
    
    
    // MARK: - Public
    
//    static func output(label: String) -> SwiftyLogHandler {
//        return SwiftyLogHandler(label: label, stream: DefaultOutputStream())
//    }
    
    
    // MARK: - Private
    
    private func output(_ msg: String? = nil, icon: String, fileInfo: String, time: String) {
        var stream = self.stream
        stream.write("\(icon)\(time) - \(fileInfo) :: \(msg ?? "")")
    }
}


// MARK: - Icon

extension XcodeSlackLogHandler {
    
    private func getLogHeader(_ level: Logger.Level) -> String {
        
        switch level {
        case .trace, .debug:    return "🔍 > "
        case .info, .notice:    return "📌 > "
        case .warning:          return "🚧 > "
        case .error:            return "⚠️ > "
        case .critical:         return "🚨 > "
        }
    }
    
    private func getTime() -> String {
        return self.dateFormatter.string(from: Date())
    }
}
