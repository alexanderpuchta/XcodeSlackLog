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
        
        var blocks: [SlackMessageBlock] = []

        let header = SlackMessageBlock(
            type: "header",
            text: SlackMessageBlockText(
                type: "plain_text",
                text: level.rawValue
            )
        )
        
        let body = SlackMessageBlock(
            type: "section",
            text: SlackMessageBlockText(
                type: "mrkdwn",
                text: ">_\(message)_"
            )
        )
        
        blocks.append(contentsOf: [header, body])
        
        if let file = file?.split(separator: "/").last,
           let line = line {
            let divider = SlackMessageBlock(
                type: "divider",
                text: nil
            )
            
            let fileAndLine = SlackMessageBlock(
                type: "section",
                text: SlackMessageBlockText(
                    type: "mrkdwn",
                    text: "```Location: \(file)[:\(line)]"
                )
            )
            
            blocks.append(contentsOf: [divider, fileAndLine])
        }
        
        return SlackMessage(text: level.rawValue,
                            blocks: blocks)
        
    }
}
