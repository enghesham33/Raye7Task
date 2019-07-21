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
    
    override public static func primaryKey() -> String? {
        return "id"
    }
    
    class func getInstance(name: String, fullName: String, ownerId: Int, ownerLogin: String, ownerAvatar: String, description: String, forksCount: Int, language: String, createdAt: String, htmlUrl: String) -> LocalRepository {
        let localRepository = LocalRepository()
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
        return localRepository
    }
    
    //Incrementa ID
    func incrementaID() -> Int{
        let realm = try! Realm()
        if let retNext = realm.objects(LocalRepository.self).sorted(byKeyPath: "id").last?.id {
            return retNext + 1
        }else{
            return 1
        }
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
        repository.id = repository.incrementaID()
        realm.beginWrite()
        realm.add(repository)
        try! realm.commitWrite()
    }
    
    class func getAllSavedRepositories() -> [LocalRepository] {
        let realm = try! Realm()
        let results = realm.objects(LocalRepository.self).sorted(byKeyPath: "id")
        return Array(results)
    }
    
    class func getAllRepositories() -> [Repository] {
        let localRepositories = LocalRepository.getAllSavedRepositories()
        var repositories = [Repository]()
        for localRepo in localRepositories {
            repositories.append(Repository(name: localRepo.name, fullName: localRepo.fullName, ownerId: localRepo.ownerId, ownerLogin: localRepo.ownerLogin, ownerAvatar: localRepo.ownerAvatarUrl, description: localRepo.repoDescription, forksCount: localRepo.forksCount, language: localRepo.language, createdAt: localRepo.createdAt, htmlUrl: localRepo.htmlUrl))
        }
        
        return repositories
    }
}
