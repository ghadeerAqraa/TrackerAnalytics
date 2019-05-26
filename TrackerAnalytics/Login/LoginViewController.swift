//
//  LoginViewController.swift
//  TrackerAnalytics
//
//  Created by Ghadeer on 5/24/19.
//  Copyright © 2019 RMDY. All rights reserved.
//

import UIKit
import Alamofire

class LoginViewController: UIViewController {

    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var userNameErrorMsgLabel: UILabel!
    @IBOutlet weak var passwordErrorMsgLabel: UILabel!
    @IBOutlet weak var activityIndicatorView: ActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicatorView.initializeActivityIndicatoreView()
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        if isValidValues(){
            performLogin()
            hideErrorMsgLabels()
        }
        
    }
    func hideErrorMsgLabels(){
        userNameErrorMsgLabel.isHidden = true
        passwordErrorMsgLabel.isHidden = true
    }
    func isValidValues() -> Bool{
        var isValidValues = true
        if userNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            isValidValues = false
            userNameErrorMsgLabel.isHidden = false
        }
        if passwordTextField.text!.isEmpty {
            isValidValues = false
            passwordErrorMsgLabel.isHidden = false
        }
        return isValidValues
        
    }
    
    
    func performLogin(){
        activityIndicatorView.showActivityIndicatorView()
        let userName : String = self.userNameTextField.text!
        let password : String = self.passwordTextField.text!
        let parameters: [String: Any] = [
            trackerAPIKeys.USER_NAME_KEY: userName,
            trackerAPIKeys.PASSWORD_KEY:password,
            trackerAPIKeys.TRENANT_ID_KEY: "1",
        ]
        ConnectionUtils.performJsonRequestToUrl(actionURL: trackerAPIKeys.LOGIN_ACTION, parameters: parameters, httpMethod: .post, success:{(responseDictionary : NSDictionary)-> Void in
            self.activityIndicatorView.hideActivityIndicatoreView()
            if let tokensData = responseDictionary[trackerAPIKeys.TOLENS_RESPONSE_KEY] as? NSDictionary {
                let authToken = tokensData[trackerAPIKeys.AUTH_TOKEN_KEY]
                let sessionToken = tokensData[trackerAPIKeys.SESSION_TOKEN_KEY]
                let userDefaults = UserDefaults.standard
                userDefaults.setValue(authToken, forKey: trackerAPIKeys.AUTH_TOKEN_KEY)
                userDefaults.setValue(sessionToken, forKey: trackerAPIKeys.SESSION_TOKEN_KEY)
                
                self.openChartDataViewController()
            }
         
        },
                                                    failure:{(error : NSError) -> Void in
                                                        self.activityIndicatorView.hideActivityIndicatoreView()
                                                        self.showAlertView(error: error.localizedDescription)
                                                        
                                                        
        }
        )
       
    }
    
    func openChartDataViewController() {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ChartDataViewController") as! ChartDataViewController
        self.present(vc, animated: true, completion: nil)
    
    }
    
    
    func showAlertView(error : String)  {
        let alert = UIAlertController(title: "", message: error, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title:NSLocalizedString("OK",comment:""), style: UIAlertAction.Style.cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }


}

