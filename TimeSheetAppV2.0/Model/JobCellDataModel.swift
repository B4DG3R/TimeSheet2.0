//
//  JobListCellData.swift
//  TimeSheetAppV2.0
//
//  Created by Matthew Hollyhead on 14/06/2020.
//  Copyright © 2020 Matthew Hollyhead. All rights reserved.
//

import Foundation

class JobCellDataModel {
    
    
    var jobNumber: Int
    var day: String
    var yNumber: String
    var jobCode: String
    var jobDescription: String
    var hours: String
    var notes: String
    
    init(jobNumber: Int, day: String, yNumber: String, jobDescription: String, jobCode: String, hours: String, notes: String) {
        
        self.jobNumber = jobNumber
        self.day = day
        self.yNumber = yNumber
        self.jobDescription = jobDescription
        self.jobCode = jobCode
        self.hours = hours
        self.notes = notes
    }
}

