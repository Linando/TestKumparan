//
//  PhotoModel.swift
//  TestKumparan
//
//  Created by Linando Saputra on 06/09/21.
//

import Foundation

struct PhotoModel: Codable {
    let albumID, id: Int
    let title: String
    let url, thumbnailURL: String
    
    enum CodingKeys: String, CodingKey {
        case albumID = "albumId"
        case id, title, url
        case thumbnailURL = "thumbnailUrl"
    }
}
