//
//  UiHelpers.swift
//  Raye7Task
//
//  Created by Hesham Donia on 7/21/19.
//  Copyright © 2019 Hesham Donia. All rights reserved.
//

import Foundation
import NVActivityIndicatorView

public class UiHelpers {
    
    class func showLoader() {
        let activityData = ActivityData(size: nil, message: nil, messageFont: nil, messageSpacing: nil, type: nil, color: UIColor.AppColors.darkGray, padding: nil, displayTimeThreshold: nil, minimumDisplayTime: nil, backgroundColor: nil, textColor: nil)
        NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData, nil)
    }
    
    class func hideLoader() {
        NVActivityIndicatorPresenter.sharedInstance.stopAnimating(nil)
    }
    
    class func createAlertView(title: String, message: String, actions: [UIAlertAction]) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        for action in actions {
            alert.addAction(action)
        }
        return alert
    }
}
