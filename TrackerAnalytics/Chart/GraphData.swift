//
//  GraphData.swift
//  TrackerAnalytics
//
//  Created by Ghadeer on 5/24/19.
//  Copyright © 2019 RMDY. All rights reserved.
//

import UIKit
let START_DATE_RESPONSE_KEY = "StartDate"
let STEPS_RESPONSE_KEY = "Steps"

class GraphData: NSObject {
    var startDateStr: String?
    var steps: Double?

    class func createGraphDataFromJson(jsonItem: NSDictionary) -> GraphData?{
        var graphData:GraphData?
        
        var startDate = ""
        if let startDateStr = jsonItem[START_DATE_RESPONSE_KEY] {
            startDate = StringUtils.getStringFromObject(obj: startDateStr as AnyObject)
        }
        
        var steps = ""
        if let stepsStr = jsonItem[STEPS_RESPONSE_KEY] {
            steps = StringUtils.getStringFromObject(obj: stepsStr as AnyObject)
        }
        
        graphData = GraphData.init(startDateStr: startDate, steps: NSString(string: steps).doubleValue)
        
        
        return graphData
    }
    
    init(startDateStr: String , steps: Double ){
        self.startDateStr = startDateStr
        self.steps = steps
    }

}
