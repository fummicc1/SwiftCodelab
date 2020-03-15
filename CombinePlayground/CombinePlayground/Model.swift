//
//  Model.swift
//  CombinePlayground
//
//  Created by Fumiya Tanaka on 2020/03/15.
//  Copyright © 2020 Fumiya Tanaka. All rights reserved.
//

import Foundation

struct ToDo {
    let id: Int
    let content: String
    let createdAt: Date
    let sender: String
    let deadline: Date
    
    init?(data: [String: Any]) {
        guard let id = data["id"] as? Int, let content = data["content"] as? String, let createdAt = data["created_at"] as? Date, let deadline = data["deadline"] as? Date, let sender = data["sender"] as? String else {
            return nil
        }
        self.id = id
        self.content = content
        self.sender = sender
        self.createdAt = createdAt
        self.deadline = deadline
    }
    
    var data: [String: Any] {
        [
            "id": id,
            "content": content,
            "sender": sender,
            "created_at": createdAt,
            "deadline": deadline
        ]
    }
}
