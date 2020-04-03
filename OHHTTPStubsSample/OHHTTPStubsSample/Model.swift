//
//  Model.swift
//  OHHTTPStubsSample
//
//  Created by Fumiya Tanaka on 2020/04/03.
//  Copyright © 2020 Fumiya Tanaka. All rights reserved.
//

import Foundation

class Model {
    
    private let client = APIClient(baseURL: URL(string: "http://test")!)
    
    func getComemnt(of id: String = "0") {
        client.getComment(withId: id) { (comment, error) in
            if error != nil {
                fatalError()
            }
            guard let comment = comment else {
                fatalError()
            }
            print(comment)
        }
    }
}
