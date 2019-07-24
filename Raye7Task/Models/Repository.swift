//
//  Repository].swift
//  Raye7Task
//
//  Created by Hesham Donia on 7/21/19.
//  Copyright © 2019 Hesham Donia. All rights reserved.
//

import Foundation
import Gloss

public class Repository: DataType {
    
    public var id: Int!
    public var name : String!
    public var fullName : String!
    public var owner: Owner!
    public var description: String!
    public var forksCount: Int!
    public var language: String?
    public var createdAt: String!
    public var htmlUrl: String!
    public var commitsUrl: String!
    public var commitsCount: Int?
    
    required public init?(json: JSON){
        id = "id" <~~ json
        name = "name" <~~ json
        fullName = "full_name" <~~ json
        owner = "owner" <~~ json
        description = "description" <~~ json
        forksCount = "forks_count" <~~ json
        language = "language" <~~ json
        createdAt = "created_at" <~~ json
        htmlUrl = "html_url" <~~ json
        commitsUrl = "commits_url" <~~ json
        commitsUrl = commitsUrl.split("{")[0] // to remove some not needed data in the url
    }
    
    public init() {
        
    }
    
    public init(id: Int, name: String, fullName: String, ownerId: Int, ownerLogin: String, ownerAvatar: String, description: String, forksCount: Int, language: String, createdAt: String, htmlUrl: String, commitsUrl: String, commitsCount: Int) {
        self.id = id
        self.name = name
        self.fullName = fullName
        self.owner = Owner(id: ownerId, login: ownerLogin, avatarUrl: ownerAvatar)
        self.description = description
        self.forksCount = forksCount
        self.language = language
        self.createdAt = createdAt
        self.htmlUrl = htmlUrl
        self.commitsUrl = commitsUrl
        self.commitsCount = commitsCount
    }
    
    //MARK: Encodable
    public func toJSON() -> JSON? {
        return jsonify([
            "id" ~~> id,
            "name" ~~> name,
            "full_name" ~~> fullName,
            "owner" ~~> owner,
            "description" ~~> description,
            "forks_count" ~~> forksCount,
            "language" ~~> language,
            "created_at" ~~> createdAt,
            "html_url" ~~> htmlUrl,
            "commits_url" ~~> commitsUrl,
            ])
    }
}
