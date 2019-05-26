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

    var stepsChartData: StepsChartData = StepsChartData.init(graphData: [], goal: 0.0)
    override func viewDidLoad() {
        super.viewDidLoad()
        stepsChartData = StepsChartData.getDummyStepsChartData(range: Range.Week)
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
        initilizeLineChartData()
        
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
        
        let firstDate = DateUtils.dateFromString(stringDate: stepsChartData.graphData[0].startDateStr!)
        let nextDate = Calendar.current.date(byAdding: .day, value: -1, to: firstDate)
        self.chartView.xAxis.axisMinimum = nextDate!.timeIntervalSince1970
        
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
        stepsChartData = StepsChartData.getDummyStepsChartData(range: segmentedControl.selectedSegmentIndex)
        initilizeLineChartData()
    }
    

    func showAlertView(error : String)  {
        let alert = UIAlertController(title: "", message: error, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title:NSLocalizedString("OK",comment:""), style: UIAlertAction.Style.cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }


}

