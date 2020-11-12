// 
// Created by Alexander Puchta in 2020
// 
// 

import Foundation

struct SlackMessage: Codable {
    let title: String
    let blocks: [SlackMessageBlock]
    
    enum CodingKeys: String, CodingKey {
        case title = "text"
        case blocks
    }
}

struct SlackMessageBlock: Codable {
    let type: String
    let message: SlackMessageBlockText?
    
    enum CondigKeys: String, CodingKey {
        case type
        case message = "text"
    }
}

struct SlackMessageBlockText: Codable {
    let type: String
    let text: String
}

enum SlackMessageLevel: String, Codable {
    case debug =        "DEBUG INFORMATION"
    case warning =      "WARNING INFORMATION"
    case error =        "ERROR INFORMATION"
    case critical =     "CRITICAL INFORMATION"
}
