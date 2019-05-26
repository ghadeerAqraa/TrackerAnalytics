//
//  ActivityIndicatorView.swift
//  TrackerAnalytics
//
//  Created by Ghadeer on 5/25/19.
//  Copyright © 2019 RMDY. All rights reserved.
//

import UIKit

class ActivityIndicatorView: UIView {
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!

    func showActivityIndicatorView(){
        self.isHidden = false
        activityIndicatorView.isHidden = false
        activityIndicatorView.startAnimating()
    }
    func hideActivityIndicatoreView() {
        self.isHidden = true
        activityIndicatorView.isHidden = true
        activityIndicatorView.stopAnimating()

    }
    func initializeActivityIndicatoreView(){
      //  activityIndicatorView.scale(factor:2)
        self.layer.cornerRadius = 10
        
    }
}
extension UIActivityIndicatorView {
    func scale(factor: CGFloat) {
        guard factor > 0.0 else { return }
        
        transform = CGAffineTransform(scaleX: factor, y: factor)
    }
}

