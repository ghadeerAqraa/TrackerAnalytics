//
//  Keys.swift
//  TrackerAnalytics
//
//  Created by Ghadeer on 5/24/19.
//  Copyright © 2019 RMDY. All rights reserved.
//

import UIKit

struct trackerAPIKeys {
    static let BASE_URL = "https://dev-mdt-api.wellnesslayers.com/API/"
    static let LOGIN_ACTION = "Account/Login"
    static let TRACKERS_STEPS_ACTION = "Trackers/Steps/WithGoal"
    static let TOLENS_RESPONSE_KEY = "Tokens"
    static let AUTH_TOKEN_KEY = "AuthToken"
    static let SESSION_TOKEN_KEY = "SessionToken"
    static let Graph_DATA_KEY = "GraphData"
    static let USER_NAME_KEY = "UserName"
    static let PASSWORD_KEY = "Password"
    static let TRENANT_ID_KEY = "TenantID"

}
enum Range{
    static let Week = 0
    static let Month = 1
    static let Quarter = 2
}
