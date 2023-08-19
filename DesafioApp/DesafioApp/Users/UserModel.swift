//
//  UserModel.swift
//  DesafioApp
//
//  Created by Victor Hugo Martins Lisboa on 18/08/23.
//

import Foundation

struct UserModel: Codable {
    var login: String
    var id: Int
    var nodeId: String
    var avatarUrl: String
    var url: String
    
    init(login: String, id: Int, nodeId: String, avatarUrl: String, url: String) {
        self.login = login
        self.id = id
        self.nodeId = nodeId
        self.avatarUrl = avatarUrl
        self.url = url
    }
    
    init() {
        self.login = ""
        self.id = 0
        self.nodeId = ""
        self.avatarUrl = ""
        self.url = ""
    }
    
    enum CodingKeys: String, CodingKey {
        case login
        case id
        case nodeId = "node_id"
        case avatarUrl = "avatar_url"
        case url
    }
}
