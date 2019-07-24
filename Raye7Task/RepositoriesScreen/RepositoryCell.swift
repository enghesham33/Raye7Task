//
//  RepositoryCell.swift
//  Raye7Task
//
//  Created by Hesham Donia on 7/21/19.
//  Copyright © 2019 Hesham Donia. All rights reserved.
//

import UIKit
import AlamofireImage

class RepositoryCell: UITableViewCell {

    public static let identifier = "RepositoryCell"
    
    public var repository: Repository!
    
    @IBOutlet weak var repositoryTitleLabel: UILabel!
    @IBOutlet weak var repositoryDescLabel: UILabel!
    @IBOutlet weak var forksCountLabel: UILabel!
    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var creationDateLabel: UILabel!
    @IBOutlet weak var ownerImageView: UIImageView!
    @IBOutlet weak var commitsCountLabel: UILabel!
    
    public func populateData() {
        repositoryTitleLabel.text = repository.name
        repositoryDescLabel.text = repository.description
        forksCountLabel.text = "\(repository.forksCount!) Forks"
        languageLabel.text = repository.language
        let date = repository.createdAt.split("T")[0]
        let time = repository.createdAt.split("T")[1].replacingOccurrences(of: "Z", with: "")
        creationDateLabel.text = date + " " + time
        if let url = URL(string: repository.owner.avatarUrl) {
            ownerImageView.af_setImage(withURL: url)
        }
        if let count = repository.commitsCount, count > -1 {
            showCommitsCount(count: count)
        }
    }
    
    public func showCommitsCount(count: Int) {
        commitsCountLabel.text = "\(count) Commits"
    }

    override func prepareForReuse() {
        self.ownerImageView.image = nil
    }
}
