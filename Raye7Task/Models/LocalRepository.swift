//
//  LocalRepository.swift
//  Raye7Task
//
//  Created by Hesham Donia on 7/22/19.
//  Copyright © 2019 Hesham Donia. All rights reserved.
//

import Foundation
import RealmSwift

public class LocalRepository: Object {
    
    @objc dynamic var id: Int = 0
    @objc dynamic var name : String = ""
    @objc dynamic var fullName : String = ""
    @objc dynamic var ownerId: Int = 0
    @objc dynamic var ownerLogin: String = ""
    @objc dynamic var ownerAvatarUrl: String = ""
    @objc dynamic var repoDescription: String = ""
    @objc dynamic var forksCount: Int = 0
    @objc dynamic var language: String = ""
    @objc dynamic var createdAt: String = ""
    @objc dynamic var htmlUrl: String = ""
    @objc dynamic var commitsUrl: String = ""
    @objc dynamic var commitsCount: Int = -1
    
    override public static func primaryKey() -> String? {
        return "id"
    }
    
    class func getInstance(id: Int, name: String, fullName: String, ownerId: Int, ownerLogin: String, ownerAvatar: String, description: String, forksCount: Int, language: String, createdAt: String, htmlUrl: String, commitsUrl: String, commitsCount: Int) -> LocalRepository {
        let localRepository = LocalRepository()
        localRepository.id = id
        localRepository.name = name
        localRepository.fullName = fullName
        localRepository.ownerId = ownerId
        localRepository.ownerLogin = ownerLogin
        localRepository.ownerAvatarUrl = ownerAvatar
        localRepository.repoDescription = description
        localRepository.forksCount = forksCount
        localRepository.language = language
        localRepository.createdAt = createdAt
        localRepository.htmlUrl = htmlUrl
        localRepository.commitsUrl = commitsUrl
        localRepository.commitsCount = commitsCount
        return localRepository
    }
    
    public static func deleteAllRepositories() {
        let realm = try! Realm()
        do {
            try realm.write {
                realm.delete(realm.objects(LocalRepository.self))
            }
        } catch (let error) {
            print(error)
        }
    }
    
    class func insertRepository(repository: LocalRepository) {
        let realm = try! Realm()
        realm.beginWrite()
        realm.add(repository)
        try! realm.commitWrite()
    }
    
    class func getAllSavedRepositories() -> [LocalRepository] {
        let realm = try! Realm()
        let results = realm.objects(LocalRepository.self)
        return Array(results)
    }
    
    class func updateRepository(repository: LocalRepository) {
        let realm = try! Realm()
        if repository.id > 0 {
            realm.beginWrite()
            realm.add(repository, update: Realm.UpdatePolicy.modified)
            try! realm.commitWrite()
        }
        
    }
    
    class func getAllRepositories() -> [Repository] {
        return LocalRepository.getAllSavedRepositories().map { (localRepo) -> Repository in
            return Repository(id: localRepo.id, name: localRepo.name, fullName: localRepo.fullName, ownerId: localRepo.ownerId, ownerLogin: localRepo.ownerLogin, ownerAvatar: localRepo.ownerAvatarUrl, description: localRepo.repoDescription, forksCount: localRepo.forksCount, language: localRepo.language, createdAt: localRepo.createdAt, htmlUrl: localRepo.htmlUrl, commitsUrl: localRepo.commitsUrl, commitsCount: localRepo.commitsCount)
        }
    }
}
