//
//  UserInfoModel.swift
//  DesafioApp
//
//  Created by Victor Hugo Martins Lisboa on 18/08/23.
//

import Foundation
import UIKit

struct UserInfoModel: Codable {
    var login: String
    var id: Int
    var nodeId: String
    var avatarUrl: String?
    var url: String
    var reposUrl: String
    var name: String?
    var company: String?
    var blog: String?
    var location: String?
    var email: String?
    var bio: String?
    var twitterUsername: String?
    var publicRepos: Int
    var publicGists: Int
    var followers: Int
    var following: Int
    
    init(login: String, id: Int, nodeId: String, avatarUrl: String?, url: String, reposUrl: String, name: String?, company: String?, blog: String?, location: String?, email: String?, bio: String?, twitterUsername: String?, publicRepos: Int, publicGists: Int, followers: Int, following: Int) {
        self.login = login
        self.id = id
        self.nodeId = nodeId
        self.avatarUrl = avatarUrl
        self.url = url
        self.reposUrl = reposUrl
        self.name = name
        self.company = company
        self.blog = blog
        self.location = location
        self.email = email
        self.bio = bio
        self.twitterUsername = twitterUsername
        self.publicRepos = publicRepos
        self.publicGists = publicGists
        self.followers = followers
        self.following = following
    }
    
    init() {
        self.login = ""
        self.id = 0
        self.nodeId = ""
        self.avatarUrl = ""
        self.url = ""
        self.reposUrl = ""
        self.name = ""
        self.company = ""
        self.blog = ""
        self.location = ""
        self.email = ""
        self.bio = ""
        self.twitterUsername = ""
        self.publicRepos = 0
        self.publicGists = 0
        self.followers = 0
        self.following = 0
    }
    
    enum CodingKeys: String, CodingKey {
        case login
        case id
        case nodeId = "node_id"
        case avatarUrl = "avatar_url"
        case url
        case reposUrl = "repos_url"
        case name
        case company
        case blog
        case location
        case email
        case bio
        case twitterUsername = "twitter_username"
        case publicRepos = "public_repos"
        case publicGists = "public_gists"
        case followers
        case following
    }
}
