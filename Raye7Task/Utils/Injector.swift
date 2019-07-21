//
//  Injector.swift
//  Raye7Task
//
//  Created by Hesham Donia on 7/21/19.
//  Copyright © 2019 Hesham Donia. All rights reserved.
//

import Foundation

public class Injector {
    
    public class func provideRepositoriesPresenter() -> RepositoriesPresenter {
        return RepositoriesPresenter(repositoriesRepository: Injector.provideRepositoriesRepository())
    }

    public class func provideRepositoriesRepository() -> RepositoriesRepository {
        return RepositoriesRepository()
    }
}
