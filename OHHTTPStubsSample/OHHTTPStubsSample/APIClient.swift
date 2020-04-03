//
//  APIClient.swift
//  OHHTTPStubsSample
//
//  Created by Fumiya Tanaka on 2020/04/03.
//  Copyright © 2020 Fumiya Tanaka. All rights reserved.
//

import Foundation
import OHHTTPStubsSwift
import OHHTTPStubs

struct Comment: Codable {
    let id: String
    let text: String
    let author: String
    
    static func stub() -> Comment {
        .init(id: "0", text: "text", author: "author")
    }
}

class APIClient {
    
    static let stubJSON: [String: Any] = {
        let stub = Comment.stub()
        let data = try! JSONEncoder().encode(stub)
        let json = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
        return json
    }()
    
    let baseURL: URL
    var session: URLSession
    
    init(baseURL: URL) {
        self.baseURL = baseURL
        
        let configuration = URLSessionConfiguration.default
        self.session = URLSession(configuration: configuration)
        stub(condition: isHost(baseURL.host!)) { _ in
            return HTTPStubsResponse(jsonObject: APIClient.stubJSON, statusCode: 200, headers: nil)
        }
    }
    
    enum Endpoint {
        case comment
        
        var method: String {
            switch self {
            case .comment:
                return "GET"
            }
        }
        
        var path: String {
            switch self {
            case .comment: return "comments/"
            }
        }
        
        func request(_ baseURL: URL, with parameters: [String: Any]) -> URLRequest? {
            switch self {
            case .comment:
                guard let id = parameters["id"] as? String else {
                    return .none
                }
                
                let url = baseURL.appendingPathComponent(path).appendingPathComponent(id)
                
                var request = URLRequest(url: url)
                request.httpMethod = method
                
                return request
            }
        }
    }
    
    enum Error: Swift.Error {
        case incorrectRequest(endpoint: Endpoint, params: [String: Any])
        case noResponseData
        case failedToDecode(with: Data)
        case some(Swift.Error)
    }
    
    func performAPIRequest(endpoint: Endpoint, parameters: [String: Any], completion: @escaping (Data?, Error?) -> ()) {
        guard let request = endpoint.request(baseURL, with: parameters) else {
            completion(nil, .incorrectRequest(endpoint: endpoint, params: parameters))
            return
        }
        
        let task = session.dataTask(with: request) { (data, response, error) -> Void in
            if let error = error {
                completion(nil, .some(error))
                return
            }
            
            guard let data = data else {
                // FIXME: This should return a proper error
                completion(nil, .noResponseData)
                return
            }
            completion(data, nil)
        }
        
        task.resume()
    }
    
    func getComment(withId id: String, completion: @escaping (_ resource: Comment?, _ error: Error?) -> ()) {
        performAPIRequest(endpoint: .comment, parameters: ["id": id]) { data, error in
            guard let data = data else {
                completion(nil, error)
                return
            }
            guard let comment = try? JSONDecoder().decode(Comment.self, from: data) else {
                completion(nil, .failedToDecode(with: data))
                return
            }
            completion(comment, nil)
        }
    }
}
