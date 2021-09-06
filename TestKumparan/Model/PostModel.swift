//
//  File.swift
//  TestKumparan
//
//  Created by Linando Saputra on 05/09/21.
//

import Foundation

struct PostModel: Codable{
    
    let userID: Int
    let postID: Int
    let title: String
    let body: String
    
    enum CodingKeys: String, CodingKey {
        case title, body
        case userID = "userId"
        case postID = "id"
    }
}
