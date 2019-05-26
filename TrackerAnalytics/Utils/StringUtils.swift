//
//  StringUtils.swift
//  TrackerAnalytics
//
//  Created by Ghadeer on 5/24/19.
//  Copyright © 2019 RMDY. All rights reserved.
//

import UIKit

class StringUtils: NSObject {
    class  func getStringFromObject(obj:AnyObject)->String {
        if let str = obj as? String {
            return str
        } else if let numb = obj as? NSNumber {
            return numb.stringValue
        }else {
            return ""
            
        }
    }
    
}
