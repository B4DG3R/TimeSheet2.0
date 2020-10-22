//
//  TimeSheetBrain.swift
//  TimeSheetApp
//
//  Created by Matthew Hollyhead on 14/05/2020.
//  Copyright © 2020 Matthew Hollyhead. All rights reserved.
//

import UIKit
import MessageUI

struct TimeSheetBrain {
    
    var timeSheet: TimeSheet?
    
//    func getDate() -> String {
//        // get the current date and format it to dd/mm/yyyy
//        let currentDateTime = Date()
//        let formatter = DateFormatter()
//        formatter.dateFormat = "dd/MM/yyyy"
//        let date = formatter.string(from: currentDateTime)
//        
//        return date
//    }
//    
//    mutating func saveJob(jobDescription: String, hours: Double, jobCode: String) {
//        
//        let todaysDate = getDate()
//        let jobDescription = jobDescription
//        let hours = hours
//        let jobCode = jobCode
//        
//        timeSheet = TimeSheet(todaysDate: todaysDate, jobDescription: jobDescription, hours: hours, jobCode: jobCode)
//    }
//    
//    func getTimeSheetData() -> (String, String, String, String) {
//        let date = timeSheet?.todaysDate ?? ""
//        let jobDescription = timeSheet?.jobDescription ?? ""
//        let hours = String(timeSheet?.hours ?? 0.0)
//        let Jobcode = timeSheet?.jobCode ?? ""
//        
//        return (date, jobDescription, hours , Jobcode)
//    }
    
    func getwhichDayOfTheWeek() -> String {
        let dayNumber = Calendar.current.component(.weekday, from: Date())
        
        switch dayNumber {
        case 1:
            return "Sunday"
        case 2:
            return "Monday"
        case 3:
            return "Tuesday"
        case 4:
            return "Wednesday"
        case 5:
            return "Thursday"
        case 6:
            return "Friday"
        case 7:
            return "Saturday"
        default:
            return "Error no day found"
        }
    }
    
    // Increments the current job number by one when a new job added
    func incrementJobNumber(jobNumber: Int) -> Int {
        let newJobNumber = jobNumber + 1
        return newJobNumber
    }

}





