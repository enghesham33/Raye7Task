//
//  RepositoriesPresenter.swift
//  Raye7Task
//
//  Created by Hesham Donia on 7/21/19.
//  Copyright © 2019 Hesham Donia. All rights reserved.
//

import Foundation

public protocol RepositoriesView: class {
    func getRepositoriesSuccess(repositories: [Repository])
    func getRepositoriesFailed(errorMessage: String)
    func handleNoInternetConnection(message: String)
}

public class RepositoriesPresenter {
    fileprivate weak var view : RepositoriesView?
    fileprivate let repositoriesRepository: RepositoriesRepository!
    
    init(repositoriesRepository: RepositoriesRepository) {
        self.repositoriesRepository = repositoriesRepository
        self.repositoriesRepository.setDelegate(delegate: self)
    }
    
    public func setView(view: RepositoriesView) {
        self.view = view
    }
}

extension RepositoriesPresenter {
    public func getRepositories(page: Int, perPage: Int) {
        if UiHelpers.isInternetAvailable() {
            UiHelpers.showLoader()
            repositoriesRepository.getRepositories(page: page, perPage: perPage)
        } else {
            self.view?.handleNoInternetConnection(message: "noInternetConnection".localized())
        }
    }
    
    public func getLocalRepositories() -> [Repository] {
        return LocalRepository.getAllRepositories()
    }
    
    public func deleteAllRepositories() {
        LocalRepository.deleteAllRepositories()
    }
    
    public func cacheRpositories(repositories: [Repository]) {
       let localRepositories = repositories.map { repository -> LocalRepository in
            return LocalRepository.getInstance(name: repository.name, fullName: repository.fullName, ownerId: repository.owner.id, ownerLogin: repository.owner.login, ownerAvatar: repository.owner.avatarUrl, description: repository.description, forksCount: repository.forksCount, language: repository.language ?? "", createdAt: repository.createdAt, htmlUrl: repository.htmlUrl)
        }
        for localRepository in localRepositories {
            LocalRepository.insertRepository(repository: localRepository)
        }
    }
}

extension RepositoriesPresenter: RepositoriesPresenterDelegate {
    public func handleNoInternetConnection(message: String) {
        UiHelpers.hideLoader()
        self.view?.handleNoInternetConnection(message: message)
    }
    
    public func getRepositoriesSuccess(repositories: [Repository]) {
        UiHelpers.hideLoader()
        self.view?.getRepositoriesSuccess(repositories: repositories)
    }
    
    public func getRepositoriesFailed(errorMessage: String) {
        UiHelpers.hideLoader()
        self.view?.getRepositoriesFailed(errorMessage: errorMessage)
    }
}
