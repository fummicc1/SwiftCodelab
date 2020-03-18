//
//  Model.swift
//  CombinePlayground
//
//  Created by Fumiya Tanaka on 2020/03/15.
//  Copyright © 2020 Fumiya Tanaka. All rights reserved.
//

import Foundation
import FirebaseFirestore

protocol Model {
    init?(data: [String: Any])
    var data: [String: Any] { get }
}

struct ToDo {
    let title: String
    let content: String
    let createdAt: Date
    let sender: String
    let deadline: Date
    
    init?(data: [String: Any]) {
        guard let title = data["title"] as? String, let content = data["content"] as? String, let deadline = data["deadline"] as? Timestamp, let sender = data["sender"] as? String else {
            return nil
        }
        self.title = title
        self.content = content
        self.sender = sender
        self.createdAt = (data["created_at"] as? Timestamp ?? Timestamp()).dateValue()
        self.deadline = deadline.dateValue()
    }
    
    var data: [String: Any] {
        [
            "title": title,
            "content": content,
            "sender": sender,
            "created_at": createdAt,
            "deadline": deadline
        ]
    }
}

extension ToDo: Identifiable {
    var id: String {
        "\(title):\(content):\(deadline)"
    }
}
