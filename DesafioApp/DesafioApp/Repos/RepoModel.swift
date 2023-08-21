//
//  RepoModel.swift
//  DesafioApp
//
//  Created by Victor Hugo Martins Lisboa on 18/08/23.
//

import Foundation

struct RepoModel: Codable {
    var id: Int
    var nodeId: String
    var name: String
    var fullName: String
    var `private`: Bool
    var htmlUrl: String
    
    init(id: Int, nodeId: String, name: String, fullName: String, `private`: Bool, htmlUrl: String) {
        self.id = id
        self.nodeId = nodeId
        self.name = name
        self.fullName = fullName
        self.private = `private`
        self.htmlUrl = htmlUrl
    }
    
    init() {
        self.id = 0
        self.nodeId = ""
        self.name = ""
        self.fullName = ""
        self.private = false
        self.htmlUrl = ""
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case nodeId = "node_id"
        case name
        case fullName = "full_name"
        case `private`
        case htmlUrl = "html_url"
    }
}
