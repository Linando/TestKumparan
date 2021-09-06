//
//  CommentModel.swift
//  TestKumparan
//
//  Created by Linando Saputra on 06/09/21.
//

import Foundation

struct CommentModel: Codable {
    let postID, id: Int
    let name, email, body: String
    
    enum CodingKeys: String, CodingKey {
        case postID = "postId"
        case id, name, email, body
    }
}
