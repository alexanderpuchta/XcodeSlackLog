// 
// Created by Alexander Puchta in 2020
// 
// 

import Foundation
import Alamofire

protocol XcodeSlackHandlerProtocol {
    func send(_ log: SlackMessage, slackURL: String, completion: @escaping ( (Result<Void, Error>) -> Void ))
}


// MARK: - XcodeSlackHandler

final class XcodeSlackHandler {
}


// MARK: - XcodeSlackHandlerProtocol

extension XcodeSlackHandler: XcodeSlackHandlerProtocol {
    
    func send(_ log: SlackMessage, slackURL: String, completion: @escaping ((Result<Void, Error>) -> Void)) {
        
        let request = Router.send(log, url: slackURL)
        AF.request(request)
            .response { response in
                switch response.result {
                case .failure(let err):         completion(.failure(err))
                    
                case .success:                  completion(.success(()))
                }
            }
    }
}


// MARK: - XcodeSlackRouter

enum Router: URLRequestConvertible {
    
    case send(_ log: SlackMessage, url: String)
    
    var baseURL: URL {
        switch self {
        case .send(_, let url):     return URL(string: url)!
        }
        
    }
    
    var method: HTTPMethod {
        switch self {
        case .send:     return .post
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = baseURL
        var request = URLRequest(url: url)
        request.method = method
        
        switch self {
        case .send(let log, _):
            
            let data: Data = {
                do {
                    return try JSONEncoder().encode(log)
                } catch {
                    fatalError("error while encoding log")
                }
            }()
            
            print(String(data: data, encoding: .utf8))
            
            request.httpBody = data
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        }
        
        return request
    }
}


