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
    
    public var name : String!
    public var fullName : String!
    public var owner: Owner!
    public var description: String!
    public var forksCount: Int!
    public var language: String!
    public var createdAt: String!
    public var htmlUrl: String!
    
    required public init?(json: JSON){
        name = "name" <~~ json
        fullName = "full_name" <~~ json
        owner = "owner" <~~ json
        description = "description" <~~ json
        forksCount = "forks_count" <~~ json
        language = "language" <~~ json
        createdAt = "created_at" <~~ json
        htmlUrl = "html_url" <~~ json
    }
    
    public init() {
        
    }
    
    //MARK: Encodable
    public func toJSON() -> JSON? {
        return jsonify([
            "name" ~~> name,
            "full_name" ~~> fullName,
            "owner" ~~> owner,
            "description" ~~> description,
            "forks_count" ~~> forksCount,
            "language" ~~> language,
            "created_at" ~~> createdAt,
            "html_url" ~~> htmlUrl,
            ])
    }
    
}
