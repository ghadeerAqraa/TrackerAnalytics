//
//  ChartDataViewController.swift
//  TrackerAnalytics
//
//  Created by Ghadeer on 5/24/19.
//  Copyright © 2019 RMDY. All rights reserved.
//

import UIKit
import Alamofire
import Charts
class ChartDataViewController: UIViewController {
    @IBOutlet var chartView: LineChartView!
    @IBOutlet var stepsLabel: UILabel!
    @IBOutlet weak var activityIndicatorView: ActivityIndicatorView!

    var stepsChartData: StepsChartData = StepsChartData.init(graphData: [], goal: 0.0)
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicatorView.initializeActivityIndicatoreView()
        getStepsChartDataFromTheServer(range: RangeValues.Week)
        initializeChartView()
        initializStepTitleLabel()
        // Do any additional setup after loading the view.
    }

    
    func initializStepTitleLabel(){
        stepsLabel.transform = CGAffineTransform(rotationAngle:  -CGFloat.pi / 2)
    }
    
    func initializeChartView(){
        
        initilizeXAxis()
        
        chartView.rightAxis.enabled = false//Disable Right Axus
        
        chartView.noDataText = "No data available"
       
        
    }
    
    func getStepsChartDataFromTheServer(range: String){
        activityIndicatorView.showActivityIndicatorView()
        let userDefaults = UserDefaults.standard
        let authToken = userDefaults.value(forKey: trackerAPIKeys.AUTH_TOKEN_KEY) as! String
        let sessionToken = userDefaults.value(forKey: trackerAPIKeys.SESSION_TOKEN_KEY)as! String

        let headers: HTTPHeaders = [
            trackerAPIKeys.AUTH_TOKEN_KEY:authToken,
            trackerAPIKeys.SESSION_TOKEN_KEY:sessionToken
            
        ]
        let actionURL = trackerAPIKeys.TRACKERS_STEPS_ACTION + range
        ConnectionUtils.performJsonRequestToUrl(actionURL: actionURL, parameters: [:], httpMethod: .get, header: headers, success:{(responseDictionary : NSDictionary)-> Void in
            self.activityIndicatorView.hideActivityIndicatoreView()
            self.stepsChartData = StepsChartData.createStepsChartDataFromJson(jsonItem: responseDictionary)!
            self.initilizeLineChartData()
     
        },
                                                failure:{(error : NSError) -> Void in
                                                    self.activityIndicatorView.hideActivityIndicatoreView()
                                                    self.showAlertView(error: error.localizedDescription)
                                                    
                                                    
        }
        )
        
    }
    
    func initilizeXAxis(){
        let xAxis = chartView.xAxis
        xAxis.drawAxisLineEnabled = false
        xAxis.drawGridLinesEnabled = true
        xAxis.centerAxisLabelsEnabled = true
        xAxis.valueFormatter = DateValueFormatter()
        xAxis.labelPosition = .bottom
        xAxis.granularityEnabled = true
        xAxis.granularity = 1.0
    }
    
    func initilizeLineChartData(){
        
        var dataEntries: [ChartDataEntry] = []
        
        for i in 0..<stepsChartData.graphData.count {
            let data = stepsChartData.graphData[i]
            let date = DateUtils.dateFromString(stringDate: stepsChartData.graphData[i].startDateStr!)
            
            let xValue = date.timeIntervalSince1970
            
            let dataEntry = ChartDataEntry(x: xValue, y: data.steps!)
            
            dataEntries.append(dataEntry)
            
        }
   
         let lineChartDataSet = initializeLineChartDataSet(dataEntries: dataEntries)
        let lineChartData = LineChartData(dataSet: lineChartDataSet)
        
        chartView.leftAxis.axisMaximum = stepsChartData.goal!
        chartView.data = lineChartData
    }
    
    func initializeLineChartDataSet(dataEntries: [ChartDataEntry])->LineChartDataSet{
        let lineChartDataSet = LineChartDataSet(entries: dataEntries, label: "Steps")
        lineChartDataSet.axisDependency = .left
        
        lineChartDataSet.drawIconsEnabled = false
        lineChartDataSet.setColor(UIColor(red: 51/255, green: 181/255, blue: 229/255, alpha: 1))
        lineChartDataSet.setCircleColor(.black)
        lineChartDataSet.lineWidth = 1
        lineChartDataSet.circleRadius = 3
        lineChartDataSet.drawCircleHoleEnabled = false
        lineChartDataSet.valueFont = .systemFont(ofSize: 9)
        lineChartDataSet.formLineDashLengths = [5, 2.5]
        lineChartDataSet.formLineWidth = 1
        lineChartDataSet.formSize = 15
        
        return lineChartDataSet
    }
    
    @IBAction func segmentedIndexChanged(_ sender: Any) {
        let segmentedControl = sender as! UISegmentedControl
        var range = ""
        switch segmentedControl.selectedSegmentIndex {
        case Range.Week:
            range = RangeValues.Week
            break
        case Range.Month:
            range = RangeValues.Month
        case Range.Quarter:
            range = RangeValues.Quarter
        default:
            range = RangeValues.Week
        }
        getStepsChartDataFromTheServer(range: range)
        
    }
    

    func showAlertView(error : String)  {
        let alert = UIAlertController(title: "", message: error, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title:NSLocalizedString("OK",comment:""), style: UIAlertAction.Style.cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }


}

