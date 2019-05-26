//
//  DateUtils.swift
//  TrackerAnalytics
//
//  Created by Ghadeer on 5/24/19.
//  Copyright © 2019 RMDY. All rights reserved.
//

import UIKit

class DateUtils: NSObject {
    class func dateFromString(stringDate: String ,format: String = "yyyy-MM-dd'T'HH:mm:ss") -> Date{
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.current
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .none
         dateFormatter.dateFormat = format
        if let date =  dateFormatter.date(from: stringDate) {
            print("date" , date)
            return date
        }
        return Date()
    }
    
}
