//
//  RepositoriesVC.swift
//  Raye7Task
//
//  Created by Hesham Donia on 7/21/19.
//  Copyright © 2019 Hesham Donia. All rights reserved.
//

import UIKit
import Toast_Swift

class RepositoriesVC: BaseVC {

    @IBOutlet weak var repositoriesTableView: UITableView!

    private var repositories = [Repository]()
    private var presenter: RepositoriesPresenter!
    
    
    public class func buildVC() -> RepositoriesVC {
        let storyboard = UIStoryboard(name: "RepositoriesStoryboard", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "RepositoriesVC") as! RepositoriesVC
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        repositoriesTableView.dataSource = self
        repositoriesTableView.delegate = self
        
        presenter = Injector.provideRepositoriesPresenter()
        presenter.setView(view: self)
        presenter.getRepositories(page: 1, perPage: 10)
        
    }
}

extension RepositoriesVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repositories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: RepositoryCell.identifier, for: indexPath) as! RepositoryCell
        cell.selectionStyle = .none
        cell.repository = self.repositories.get(indexPath.row)
        cell.populateData()
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, percentage: 15)
    }
}

extension RepositoriesVC: RepositoriesView {
    func getRepositoriesSuccess(repositories: [Repository]) {
        self.repositories.append(contentsOf: repositories)
        for repo in repositories {
            print("name: \(repo.name!)")
        }
        self.repositoriesTableView.reloadData()
    }
    
    func getRepositoriesFailed(errorMessage: String) {
        self.view.makeToast(errorMessage)
    }
    
    func handleNoInternetConnection(message: String) {
        self.view.makeToast(message)
    }
}
