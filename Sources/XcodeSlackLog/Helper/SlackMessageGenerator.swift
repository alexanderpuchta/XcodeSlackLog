// 
// Created by Alexander Puchta in 2020
// 
// 

import Foundation

protocol SlackMessageGeneratorProtocol {
    func create(message: String, level: SlackMessageLevel, file: String?, line: UInt?) -> SlackMessage
}

// MARK: - SlackMessageGenerator

final class SlackMessageGenerator {
    
}


// MARK: - SlackMessageGeneratorProtocol

extension SlackMessageGenerator: SlackMessageGeneratorProtocol {
    
    func create(message: String, level: SlackMessageLevel, file: String?, line: UInt?) -> SlackMessage {
        
        var blocks: [SlackMessageBlock] = [
            SlackMessageBlock(
                type: "mrkdwn",
                message: SlackMessageBlockText(
                    type: "mrkdwn",
                    text: message
                )
            ),
            SlackMessageBlock(
                type: "divider",
                message: nil
            )
        ]
        
        if let file = file,
           let line = line {
            blocks.append(
                SlackMessageBlock(
                    type: "mrkdwn",
                    message: SlackMessageBlockText(
                        type: "mrkdwn",
                        text: "\(file.split(separator: "/").last ?? "")[:\(line)]"
                    )
                )
            )
        }
        
        return SlackMessage(title: level.rawValue,
                            blocks: blocks)
        
    }
}
