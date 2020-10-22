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
    
    // edits current job list if you edit an already added job.
    // Iterates through the current job list until it matches the job number
    // you wish to edit, removes that job and replaces job with the new amended job.
    func amendJobList(jobList: [JobCellDataModel], jobToAdd: JobCellDataModel, jobNumber: Int) -> [JobCellDataModel] {
        
        var index = -1
        var newJobList = jobList
        
        for job in newJobList {
            index += 1
            if job.jobNumber == jobNumber {
                newJobList.remove(at: index)
            }
        }
        newJobList.insert(jobToAdd, at: index)
        //index = -1
        
        return newJobList
    }
}





