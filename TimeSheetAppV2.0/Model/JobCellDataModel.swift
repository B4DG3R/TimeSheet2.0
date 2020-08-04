//
//  JobListCellData.swift
//  TimeSheetAppV2.0
//
//  Created by Matthew Hollyhead on 14/06/2020.
//  Copyright © 2020 Matthew Hollyhead. All rights reserved.
//

import Foundation

class JobCellDataModel {
    
    var yNumber: String
    var jobCode: String
    var hours: String
    
    init(yNumber: String, jobCode: String, hours: String) {
        
        self.yNumber = yNumber
        self.jobCode = jobCode
        self.hours = hours
    }
}

