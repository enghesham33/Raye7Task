//
//  RepositoriesVC.swift
//  Raye7Task
//
//  Created by Hesham Donia on 7/21/19.
//  Copyright © 2019 Hesham Donia. All rights reserved.
//

import UIKit

class RepositoriesVC: BaseVC {

    @IBOutlet weak var repositoriesTableView: UITableView!
    
    public class func buildVC() -> RepositoriesVC {
        let storyboard = UIStoryboard(name: "RepositoriesStoryboard", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "RepositoriesVC") as! RepositoriesVC
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        repositoriesTableView.dataSource = self
        repositoriesTableView.delegate = self
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

extension RepositoriesVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: RepositoryCell.identifier, for: indexPath) as! RepositoryCell
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    
}
