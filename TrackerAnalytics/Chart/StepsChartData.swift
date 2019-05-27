//
//  StepsChartData.swift
//  TrackerAnalytics
//
//  Created by Ghadeer on 5/26/19.
//  Copyright © 2019 RMDY. All rights reserved.
//

import UIKit
let GOAL_RESPONSE_KEY = "Goal"
let Graph_DATA_KEY = "GraphData"


class StepsChartData: NSObject {
    var graphData: [GraphData]
    var goal: Double?
    
    class func createStepsChartDataFromJson(jsonItem: NSDictionary) -> StepsChartData?{
        var stepsChartData:StepsChartData?
        
        var graphData:[GraphData] = []
        var goal = ""
        if let goalStr = jsonItem[GOAL_RESPONSE_KEY] {
            goal = StringUtils.getStringFromObject(obj: goalStr as AnyObject)
        }
        if let graphDataJSON = jsonItem[Graph_DATA_KEY] as? NSArray {
            for graphDataObj in graphDataJSON {
                graphData.append(GraphData.createGraphDataFromJson(jsonItem: graphDataObj as! NSDictionary)!)
            }
            
        }
        stepsChartData = StepsChartData.init(graphData: graphData, goal: NSString(string: goal).doubleValue)
    
        return stepsChartData
    }
    
    init(graphData: [GraphData] , goal: Double ){
        self.graphData = graphData
        self.goal = goal
    }


}
