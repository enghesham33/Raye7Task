
//
//  Owner.swift
//  Raye7Task
//
//  Created by Hesham Donia on 7/21/19.
//  Copyright © 2019 Hesham Donia. All rights reserved.
//

import Foundation
 import Gloss


public class Owner: DataType {
	public var login : String!
	public var id : Int!
	public var avatarUrl : String!

    required public init?(json: JSON){
        login = "login" <~~ json
        id = "id" <~~ json
        avatarUrl = "avatar_url" <~~ json
    }
    
    public init() {
        
    }
    
    //MARK: Encodable
    public func toJSON() -> JSON? {
        return jsonify([
            "login" ~~> login,
            "id" ~~> id,
            "avatar_url" ~~> avatarUrl,
            ])
    }

}
