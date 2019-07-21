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
    var currentPage = 1
    let perPage = 10
    
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
        
        showFromLocal()
        
        showFromCloud()
    }
    
    private func showFromLocal() {
        self.repositories = presenter.getLocalRepositories()
        self.repositoriesTableView.reloadData()
    }
    
    private func showFromCloud() {
        presenter.getRepositories(page: currentPage, perPage: perPage)
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
        
        if indexPath.row == self.repositories.count - 1 {
            self.presenter.getRepositories(page: currentPage, perPage: perPage)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, percentage: 15)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let url = URL(string: self.repositories.get(indexPath.row)?.htmlUrl ?? "") {
            UIApplication.shared.open(url)
        }
    }
}

extension RepositoriesVC: RepositoriesView {
    func getRepositoriesSuccess(repositories: [Repository]) {
        if self.currentPage == 1 { // saving the first page only
            presenter.deleteAllRepositories()
            presenter.cacheRpositories(repositories: self.repositories)
            self.repositories.removeAll()
        }
        self.repositories.append(contentsOf: repositories)
        self.repositoriesTableView.reloadData()
        self.currentPage += 1
    }
    
    func getRepositoriesFailed(errorMessage: String) {
        self.view.makeToast(errorMessage)
    }
    
    func handleNoInternetConnection(message: String) {
        self.view.makeToast(message)
    }
}
