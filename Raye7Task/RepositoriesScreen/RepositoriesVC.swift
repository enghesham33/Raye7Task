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
    var canLoadMore = true
    
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
        
        displayLocalRepositories()
        
        getFromCloud()
    }
    
    private func displayLocalRepositories() {
        self.repositories = presenter.getLocalRepositories()
        self.repositoriesTableView.reloadData()
    }
    
    private func getFromCloud() {
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
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if ((self.repositoriesTableView.contentOffset.y + self.repositoriesTableView.frame.size.height) >= self.repositoriesTableView.contentSize.height) && canLoadMore { // check if we scrolled to the bottom.
           self.presenter.getRepositories(page: currentPage, perPage: perPage)
        }
    }
}

extension RepositoriesVC: RepositoriesView {
    func getRepositoriesSuccess(repositories: [Repository]) {
        if repositories.count == perPage {
            if self.currentPage == 1 { // saving the first page only
                presenter.deleteAllRepositories()
                presenter.cacheRpositories(repositories: repositories)
                self.repositories.removeAll()
            }
            
            self.repositories.append(contentsOf: repositories)
            self.repositoriesTableView.reloadData()
            self.currentPage += 1
        } else {
            canLoadMore = false
        }
        
    }
    
    func getRepositoriesFailed(errorMessage: String) {
        self.view.makeToast(errorMessage)
    }
    
    func handleNoInternetConnection(message: String) {
        self.view.makeToast(message)
    }
}
