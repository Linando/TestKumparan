//
//  AlbumModel.swift
//  TestKumparan
//
//  Created by Linando Saputra on 06/09/21.
//

import Foundation

struct AlbumModel: Codable {
    let userID, id: Int
    let title: String

    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case id, title
    }
}
