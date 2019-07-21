//
//  RepositoriesTests.swift
//  Raye7TaskTests
//
//  Created by Hesham Donia on 7/22/19.
//  Copyright © 2019 Hesham Donia. All rights reserved.
//

import XCTest
import Raye7Task

class RepositoriesTests: XCTestCase {

    var presenter: RepositoriesPresenter!
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        presenter = Injector.provideRepositoriesPresenter()
        
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testPresenterDependencyInjection() {
        XCTAssert(presenter != nil)
    }

    func testNumberOfSavedRepositories() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let localRepos = presenter.getLocalRepositories()
        XCTAssert(localRepos.count >= 0)
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
            presenter.getLocalRepositories()
        }
    }

}
