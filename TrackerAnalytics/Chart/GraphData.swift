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
    
    class func getGraphData(range: Int)-> [GraphData]{
        var graphData: [GraphData] = []
        switch range {
        case Range.Week:
            graphData.append(GraphData.init(startDateStr: "2019-04-16T00:00:00", steps: 3409))
            graphData.append(GraphData.init(startDateStr: "2019-04-17T00:00:00", steps: 7337))
            graphData.append(GraphData.init(startDateStr: "2019-04-18T00:00:00", steps: 8017))
            graphData.append(GraphData.init(startDateStr: "2019-05-13T00:00:00", steps: 999))
            break
            case Range.Month:
                graphData.append(GraphData.init(startDateStr: "2019-04-16T00:00:00", steps: 34090))
                graphData.append(GraphData.init(startDateStr: "2019-05-17T00:00:00", steps: 73370))
                graphData.append(GraphData.init(startDateStr: "2019-06-18T00:00:00", steps: 80170))
                graphData.append(GraphData.init(startDateStr: "2019-07-13T00:00:00", steps: 9990))
            break
            case Range.Quarter:
                graphData.append(GraphData.init(startDateStr: "2019-01-10T00:00:00", steps: 99900))
                graphData.append(GraphData.init(startDateStr: "2019-03-16T00:00:00", steps: 340900))
                graphData.append(GraphData.init(startDateStr: "2019-06-17T00:00:00", steps: 733700))
                graphData.append(GraphData.init(startDateStr: "2020-12-18T00:00:00", steps: 801700))
            break
        default:
            break
        }
        
        
        return graphData
    }
}
