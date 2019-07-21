//
//  Navigator.swift
//  Raye7Task
//
//  Created by Hesham Donia on 7/21/19.
//  Copyright © 2019 Hesham Donia. All rights reserved.
//

import Foundation
import UIKit

public class Navigator {
    
    var navigationController: UINavigationController!
    
    public init(navController: UINavigationController) {
        self.navigationController = navController
    }
    
//    public func navigateToLogin() {
//        let vc = LoginVC.buildVC()
//        self.navigationController.pushViewController(vc, animated: true)
//    }
}
