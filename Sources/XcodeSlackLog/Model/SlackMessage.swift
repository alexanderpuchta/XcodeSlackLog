// 
// Created by Alexander Puchta in 2020
// 
// 

import Foundation

struct SlackMessage: Codable {
    let text: String
    let blocks: [SlackMessageBlock]
}

struct SlackMessageBlock: Codable {
    let type: String
    let text: SlackMessageBlockText?
}

struct SlackMessageBlockText: Codable {
    let type: String
    let text: String
}

enum SlackMessageLevel: String, Codable {
    case debug =        "🔍 > DEBUG INFORMATION"
    case warning =      "🚧 > WARNING INFORMATION"
    case error =        "⚠️ > ERROR INFORMATION"
    case critical =     "🚨 > CRITICAL INFORMATION"
}
