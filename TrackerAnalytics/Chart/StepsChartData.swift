//
//  StepsChartData.swift
//  TrackerAnalytics
//
//  Created by Ghadeer on 5/26/19.
//  Copyright © 2019 RMDY. All rights reserved.
//

import UIKit

class StepsChartData: NSObject {
    var graphData: [GraphData]
    var goal: Double?
    
    init(graphData: [GraphData] , goal: Double ){
        self.graphData = graphData
        self.goal = goal
    }
    
    class func getDummyStepsChartData(range: Int)-> StepsChartData{
        var stepsChartData : StepsChartData!
        var goal: Double = 0
        switch range
        {
        case Range.Week://week
            goal = 10000
            break
        case Range.Month://month
             goal = 100000
            break
        case Range.Quarter://quarter
             goal = 1000000
            break
        default:
            break
        }
        stepsChartData = StepsChartData.init(graphData: GraphData.getGraphData(range: range), goal: goal)
        
        return stepsChartData

    }

}
