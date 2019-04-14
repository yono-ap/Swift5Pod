//
//  ApiRepository.swift
//  Swift5Pod
//
//  Created by yoshiyuki ono on 2019/04/13.
//  Copyright © 2019 yono-ap. All rights reserved.
//

import Foundation

struct ApiRepository: Codable {
    var repositoryId: Int
    var nodeId: String
    var repositoryName: String
    var fullName: String
    var repositoryDescription: String
    var updatedAt: Date

    enum CodingKeys: String, CodingKey {
        case repositoryId = "id"
        case nodeId = "node_id"
        case repositoryName = "name"
        case fullName = "full_name"
        case repositoryDescription = "description"
        case updatedAt = "updated_at"
    }
}
