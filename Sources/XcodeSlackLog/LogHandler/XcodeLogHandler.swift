// 
// Created by Alexander Puchta in 2020
// 
// 

import Foundation
import Logging

class XcodeLogHandler: LogHandler {
    
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
        let time = self.getTime()
        
        if let file = file.split(separator: "/").last,
           file != "XcodeSlackLog.swift" {
            self.output(message.description, icon: icon, fileInfo: "\(file)[:\(line)]", time: time)
        } else {
            self.output(message.description, icon: icon, time: time)
        }

        

    }
    
    
    // MARK: - Public
    
    static func output(label: String) -> XcodeLogHandler {
        return XcodeLogHandler(label: label,
                                    stream: LogOutputStream())
    }
    
    
    // MARK: - Private
    
    private func output(_ msg: String? = nil, icon: String, fileInfo: String? = nil, time: String) {
        var stream = self.stream
        if let file = fileInfo,
           let msg = msg {
            stream.write("\(icon)\(time) - \(fileInfo) :: \(msg)")
        } else {
            stream.write("\(icon)\(time)")
        }
        
        
    }
}


// MARK: - Icon

extension XcodeLogHandler {
    
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
