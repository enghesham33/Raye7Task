//
//  RepositoriesRepository.swift
//  Raye7Task
//
//  Created by Hesham Donia on 7/21/19.
//  Copyright © 2019 Hesham Donia. All rights reserved.
//

import Foundation
import Alamofire

public protocol RepositoriesPresenterDelegate: class {
    func getRepositoriesSuccess(repositories: [Repository])
    func getRepositoriesFailed(errorMessage: String)
    func getCommitsSuccess(commitsCount: Int, index: Int)
    func getCommitsFailed(errorMessage: String)
}

public class RepositoriesRepository {
    var delegate: RepositoriesPresenterDelegate!
    
    public func setDelegate(delegate: RepositoriesPresenterDelegate) {
        self.delegate = delegate
    }
    
    public func getRepositories(page: Int, perPage: Int) {
        let url = CommonConstants.BASE_URL + "repos"
        
        var parameters = [String:Any]()
        
        parameters["page"] = page
        parameters["per_page"] = perPage
        
        Alamofire.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseJSON { response in
            
            switch response.result {
            case .success(_):
                if let json = (response.result.value as? [Dictionary<String,AnyObject>]) {
                    var repositories = [Repository]()
                    for repoDic in json {
                        repositories.append(Repository(json: repoDic)!)
                    }
                    self.delegate.getRepositoriesSuccess(repositories: repositories)
                } else {
                    self.delegate.getRepositoriesFailed(errorMessage: "Parsing error")
                }
                
                break
                
            case .failure(let error):
                self.delegate.getRepositoriesFailed(errorMessage: error.localizedDescription)
                break
            }
        }
    }
    
    public func getCommits(url: String, index: Int) {
        
        Alamofire.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseJSON { response in
            
            switch response.result {
            case .success(_):
                if let json = (response.result.value as? [Dictionary<String,AnyObject>]) {
                   
                    self.delegate.getCommitsSuccess(commitsCount: json.count, index: index)
                } else {
                    self.delegate.getCommitsFailed(errorMessage: "Parsing error")
                }
                
                break
                
            case .failure(let error):
                self.delegate.getCommitsFailed(errorMessage: error.localizedDescription)
                break
            }
        }
    }
}
