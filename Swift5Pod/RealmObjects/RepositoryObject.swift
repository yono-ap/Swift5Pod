//
//  RepositoryObject.swift
//  Swift5Pod
//
//  Created by yoshiyuki ono on 2019/04/13.
//  Copyright © 2019 yono-ap. All rights reserved.
//

import Foundation
import RealmSwift

class RepositoryObject: Object {
    @objc dynamic var repositoryId: Int = 0
    @objc dynamic var nodeId: String = ""
    @objc dynamic var repositoryName: String = ""
    @objc dynamic var fullName: String = ""
    @objc dynamic var repositoryDescription: String = ""
    @objc dynamic var updatedAt: Date = Date()

    override static func primaryKey() -> String? {
        return "repositoryId"
    }
}
