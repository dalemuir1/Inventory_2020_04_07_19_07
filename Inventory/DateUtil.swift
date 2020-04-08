//
//  DateUtil.swift
//  Inventory
//
//  Created by dalemuir on 10/28/16.
//  Copyright © 2016 Dale Muir. All rights reserved.
//

import UIKit

extension Date {
    
    func dataBaseDateFormat() -> String {
        
        let dateFormatter = DateFormatter()
        
        dateFormatter.setLocalizedDateFormatFromTemplate("yyyy")
        let yearStr = dateFormatter.string(from: self)
        dateFormatter.setLocalizedDateFormatFromTemplate("MM")
        let monthStr = dateFormatter.string(from: self)
        dateFormatter.setLocalizedDateFormatFromTemplate("dd")
        let dayStr = dateFormatter.string(from: self)
        
        let returnStr = "\(yearStr)-\(monthStr)-\(dayStr)"
        return returnStr
        
    }
    
    func sqlDateFormat() -> String {
        return dataBaseDateFormat()
    }
    
}
