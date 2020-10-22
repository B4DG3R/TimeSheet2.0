//
//  DaysViewController.swift
//  TimeSheetAppV2.0
//
//  Created by Matthew Hollyhead on 14/06/2020.
//  Copyright © 2020 Matthew Hollyhead. All rights reserved.
//

import Foundation
import UIKit
import MessageUI
//import CoreData

class DaysViewController: UIViewController, MFMailComposeViewControllerDelegate {
    
    var emailBrain = EmailBrain()
    var timeSheetBrain = TimeSheetBrain()
    
    let defaults = UserDefaults.standard
    
    var jobNumber = 1
    var lastJobNumber = 0
    var newJobNumber = 1
    
    var dayOfJob: String?
    var jobDescription: String?
    var hours: Double?
    var previousHours: Double = 0
    var yNumber: String?
    var jobCode: String?
    var notes: String?
    
    var userEmail: String?
    var timeSheetExport: [String] = []
    var clearData = false
    var csvString: String?
    var saveDataPresent = false

    var monJobList: [JobCellDataModel] = []
    var tueJobList: [JobCellDataModel] = []
    var wedJobList: [JobCellDataModel] = []
    var thurJobList: [JobCellDataModel] = []
    var friJobList: [JobCellDataModel] = []
    var satJobList: [JobCellDataModel] = []
    var sunJobList: [JobCellDataModel] = []
    
    var monSaveList: [String] = []
    var tueSaveList: [String] = []
    var wedSaveList: [String] = []
    var thurSaveList: [String] = []
    var friSaveList: [String] = []
    var satSaveList: [String] = []
    var sunSaveList: [String] = []
    
    
    var monHours = 0.0
    var tueHours  = 0.0
    var wedHours  = 0.0
    var thurhours = 0.0
    var friHours  = 0.0
    var satHours  = 0.0
    var sunHours  = 0.0

    var dataReload = false
    
    struct keys {
        //Keys for saving data
        static let timeSheetExport   = "timeSheetExport"
        static let userEmail         = "userEmail"
        static let jobNumber         = "jobNumber"
        static let newJobNumber      = "newJobNumber"
        static let lastJobNumber     = "lastJobNumber"
        static let monHours          = "mondayHours"
        static let tuesHours         = "tuesdayHours"
        static let wedHours          = "wednesdayHours"
        static let thusHours         = "thursdayHours"
        static let friHours          = "fridayHours"
        static let satHours          = "saturdayHours"
        static let sunHours          = "sundayHours"
        static let clearTimeSheet    = "clearTimeSheet"
        static let monSaveList       = "monSaveList"
        static let tueSaveList       = "tueSaveList"
        static let wedSaveList       = "wedSaveList"
        static let thurSaveList      = "thurSaveList"
        static let friSaveList       = "friSaveList"
        static let satSaveList       = "satSaveList"
        static let sunSaveList       = "sunSaveList"
        static let saveDataPresent   = "saveDataPresent"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Time Sheet"
        
        mondayButton.layer.cornerRadius = mondayButton.frame.size.height/8
        tuesdayButton.layer.cornerRadius = tuesdayButton.frame.size.height/8
        wednesdayButton.layer.cornerRadius = wednesdayButton.frame.size.height/8
        
        thursdayButton.layer.cornerRadius = thursdayButton.frame.size.height/8
        fridayButton.layer.cornerRadius = fridayButton.frame.size.height/8
        saturdayButton.layer.cornerRadius = saturdayButton.frame.size.height/8
        
        sundayButton.layer.cornerRadius = sundayButton.frame.size.height/8
        // timeSheetButton.layer.cornerRadius = timeSheetButton.frame.size.height/8
        
        exportButton.layer.cornerRadius = exportButton.frame.size.height/8
        addJobButton.layer.cornerRadius = addJobButton.frame.size.height/8
        
        checkForSavedData()

        // gets job data from addEditTaksVC
        NotificationCenter.default.addObserver(self, selector: #selector(didGetNotificationDayOfJob(_:)), name: Notification.Name("dayOfJob"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(didGetNotificationJobNumber(_:)), name: Notification.Name("jobNumberTextField"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(didGetNotificationJobDescription(_:)), name: Notification.Name("jobDescriptionTextField"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(didGetNotificationHours(_:)), name: Notification.Name("hoursTextField"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(didGetNotificationYNumber(_:)), name: Notification.Name("yNumberTextField"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(didGetNotificationJobCode(_:)), name: Notification.Name("jobCodeTextField"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(didGetNotificationNotes(_:)), name: Notification.Name("notesTextField"), object: nil)
        
        // Gets any previous hours if its an edited job
        NotificationCenter.default.addObserver(self, selector: #selector(didGetNotificationPreviousHours(_:)), name: Notification.Name("previousHours"), object: nil)

        //Get User Email
        NotificationCenter.default.addObserver(self, selector: #selector(didGetNotificationEmail(_:)), name: Notification.Name("emailTextField"), object: nil)

        //  tells func didGetNotificationReloadData there is data to be appended to addJobToListString() and calls this function
        NotificationCenter.default.addObserver(self, selector: #selector(didGetNotificationReloadData(_:)), name: Notification.Name("ReloadData"), object: nil)

        // tells func didGetNotificationClearData to clear all time sheet data
        NotificationCenter.default.addObserver(self, selector: #selector(didGetNotificationClearData(_:)), name: Notification.Name("clearTimeSheetData"), object: nil)
    }

    @IBOutlet var hoursLabel: UILabel!
    @IBOutlet var mondayButton: UIButton!
    @IBOutlet var tuesdayButton: UIButton!
    @IBOutlet var wednesdayButton: UIButton!
    @IBOutlet var thursdayButton: UIButton!
    @IBOutlet var fridayButton: UIButton!
    @IBOutlet var saturdayButton: UIButton!
    @IBOutlet var sundayButton: UIButton!
    @IBOutlet var exportButton: UIButton!
    @IBOutlet var addJobButton: UIButton!
    @IBOutlet var timeSheetButton: UIButton!
    
    @IBAction func mondayButtonPressed(_ sender: UIButton) {
    }
    @IBAction func tuesdayButtonPressed(_ sender: UIButton) {
    }
    @IBAction func wednesdayButtonPressed(_ sender: UIButton) {
    }
    @IBAction func thursdayButtonPressed(_ sender: UIButton) {
    }
    @IBAction func fridayButtonPressed(_ sender: UIButton) {
    }
    @IBAction func saturdayButtonPressed(_ sender: UIButton) {
    }
    @IBAction func sundayButtonPressed(_ sender: UIButton) {
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "goToMondayTableView" {
            let destinationVC = segue.destination as! JobsTableViewController
            destinationVC.jobList = monJobList
        }
        if segue.identifier == "goToTuesdayTableView" {
            let destinationVC = segue.destination as! JobsTableViewController
            destinationVC.jobList = tueJobList
        }
        if segue.identifier == "goToWednesdayTableView" {
            let destinationVC = segue.destination as! JobsTableViewController
            //print("this got run")
            destinationVC.jobList = wedJobList
        }
        if segue.identifier == "goToThursdayTableView" {
            let destinationVC = segue.destination as! JobsTableViewController
            destinationVC.jobList = thurJobList
        }
        if segue.identifier == "goToFridayTableView" {
            let destinationVC = segue.destination as! JobsTableViewController
            destinationVC.jobList = friJobList
        }
        if segue.identifier == "goToSaturdayTableView" {
            let destinationVC = segue.destination as! JobsTableViewController
            destinationVC.jobList = satJobList
        }
        if segue.identifier == "goToSundayTableView" {
            let destinationVC = segue.destination as! JobsTableViewController
            destinationVC.jobList = sunJobList
        }
//        if segue.identifier == "goToTimeSheetViewController" {
//            let destinationVC = segue.destination as! TimeSheetViewController
//        }
        if segue.identifier == "addEditViewController" {
            let destinationVC = segue.destination as! AddEditViewController
            destinationVC.jobNumber = newJobNumber
        }
        
    }
    @IBAction func addJobButtonPressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: "addEditViewController", sender: self)
    }

    @IBAction func exportButtonPressed(_ sender: UIButton) {

        userEmail = emailBrain.getUserEmail()

        csvString = timeSheetExport.joined(separator: ",")
        //print("csv string - \(csvString ?? "No CSV String Data")")

        let data = csvString!.data(using: String.Encoding.utf8, allowLossyConversion: false)
        if let content = data {
            //print("NSData: \(content)")
        }

        func sendEmail() {
            if MFMailComposeViewController.canSendMail() {
                let mail = MFMailComposeViewController()
                print("Users Email is \(userEmail!)")
                mail.mailComposeDelegate = self
                mail.setToRecipients([userEmail!])
                mail.setSubject("Time Sheet")
                mail.setMessageBody("<p>This weeks Time Sheet</p>", isHTML: true)

                //Add CSV File to email
                mail.addAttachmentData(data!, mimeType: "text/csv", fileName: "timeSheet.csv")

                self.present(mail, animated: true)

            } else {
                // show failure alert
                print("Cannot send mail")
            }
        }

        func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {

            controller.dismiss(animated: true, completion: nil)
        }

        sendEmail()
    }
    
    @objc func didGetNotificationDayOfJob(_ notification: Notification) {
        let dayOfJobText = notification.object as! String
        dayOfJob = dayOfJobText
    }
    
    @objc func didGetNotificationJobNumber(_ notification: Notification) {
        let jobNumberText = notification.object as! String
        jobNumber = Int(jobNumberText)!
    }

    @objc func didGetNotificationJobDescription(_ notification: Notification) {
        let descriptionText = notification.object as! String
        jobDescription = descriptionText
    }

    @objc func didGetNotificationHours(_ notification: Notification) {
        let hoursText = notification.object as! String
        hours = Double(hoursText)
    }

    @objc func didGetNotificationYNumber(_ notification: Notification) {
        let yNumberText = notification.object as! String
        yNumber = yNumberText
    }

    @objc func didGetNotificationJobCode(_ notification: Notification) {
        let jobCodeText = notification.object as! String
        jobCode = jobCodeText
    }

    @objc func didGetNotificationNotes(_ notification: Notification) {
        let notesText = notification.object as! String
        notes = notesText
    }
    
    @objc func didGetNotificationPreviousHours(_ notification: Notification) {
        let newPreviousHours = notification.object as! String
        previousHours = Double(newPreviousHours)!
    }

    @objc func didGetNotificationEmail(_ notification: Notification) {
        let email = notification.object as! String
        emailBrain.setUserEmail(emailAddress: email)
    }

    @objc func didGetNotificationClearData(_ notification: Notification) {
        clearData = notification.object as! Bool

        if clearData == true {
            clearTimeSheetData()
        }

        clearData = false
    }

    @objc func didGetNotificationReloadData(_ notification: Notification) {
        dataReload = notification.object as! Bool

        if dataReload == true {
            setHours()
            updateHours()
            
            // creates/adds job to job list and reloads the table view
            createArray()
            saveData()
        }
    }
    
    
    
    func createArray() {
                
        let addToTimeSheet = JobCellDataModel(jobNumber: jobNumber, day: dayOfJob ?? "",  yNumber: yNumber ?? "", jobDescription: jobDescription ?? "", jobCode: jobCode ?? "", hours: String(hours ?? 0.0), notes: notes ?? "")
        
        // If you try to add an empty job
        if addToTimeSheet.yNumber == "" {
            
            noJobs()
            
        } else {
            
            // If you edit a job
            if jobNumber <= lastJobNumber {
                
                // Calls timeSheetBrain.amendJobList function to amend the joblist with
                // edited job
                
                if dayOfJob == "Monday" {
                    
                    // Old edit job function, still testing dont delete yet
                    
//                    for job in monJobList {
//                        index += 1
//                        if job.jobNumber == jobNumber {
//                            monJobList.remove(at: index)
//                        }
//                    }
//                    monJobList.insert(addToTimeSheet, at: index)
//                    index = -1
                    
                    monJobList = timeSheetBrain.amendJobList(jobList: monJobList, jobToAdd: addToTimeSheet, jobNumber: jobNumber)
                } else if dayOfJob == "Tuesday" {
                    tueJobList = timeSheetBrain.amendJobList(jobList: tueJobList, jobToAdd: addToTimeSheet, jobNumber: jobNumber)
                } else if dayOfJob == "Wednesday" {
                    wedJobList = timeSheetBrain.amendJobList(jobList: wedJobList, jobToAdd: addToTimeSheet, jobNumber: jobNumber)
                } else if dayOfJob == "Thursday" {
                    thurJobList = timeSheetBrain.amendJobList(jobList: thurJobList, jobToAdd: addToTimeSheet, jobNumber: jobNumber)
                } else if dayOfJob == "Friday" {
                    friJobList = timeSheetBrain.amendJobList(jobList: friJobList, jobToAdd: addToTimeSheet, jobNumber: jobNumber)
                } else if dayOfJob == "Saturday" {
                    satJobList = timeSheetBrain.amendJobList(jobList: satJobList, jobToAdd: addToTimeSheet, jobNumber: jobNumber)
                } else if dayOfJob == "Sunday" {
                    sunJobList = timeSheetBrain.amendJobList(jobList: sunJobList, jobToAdd: addToTimeSheet, jobNumber: jobNumber)
                }
            } else {
                
                // If you add a new job
                lastJobNumber = jobNumber
                
                if dayOfJob == "Monday" {
                    monJobList.append(addToTimeSheet)
                } else if dayOfJob == "Tuesday" {
                    tueJobList.append(addToTimeSheet)
                } else if dayOfJob == "Wednesday" {
                    wedJobList.append(addToTimeSheet)
                } else if dayOfJob == "Thursday" {
                    thurJobList.append(addToTimeSheet)
                } else if dayOfJob == "Friday" {
                    friJobList.append(addToTimeSheet)
                } else if dayOfJob == "Saturday" {
                    satJobList.append(addToTimeSheet)
                } else if dayOfJob == "Sunday" {
                    sunJobList.append(addToTimeSheet)
                }
                
                newJobNumber = timeSheetBrain.incrementJobNumber(jobNumber: newJobNumber)
            }
        }
        
        saveDataPresent = true
        addJobToListString()
        saveData()
    }
    
    func noJobs() {
        
        let ac = UIAlertController(title: "No Data", message: "You currently have no saved jobs.", preferredStyle: .alert)
        
        // This puts a button on the alert
        ac.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        
        // This presents the alert
        present(ac, animated: true)
    }
    
    func addJobToListString() {
        
        var addToTimeSheet: [String] = []
        
        monSaveList.removeAll()
        tueSaveList.removeAll()
        wedSaveList.removeAll()
        thurSaveList.removeAll()
        friSaveList.removeAll()
        satSaveList.removeAll()
        sunSaveList.removeAll()
        timeSheetExport.removeAll()
        
        for job in monJobList {
            addToTimeSheet = ["\n", String(job.jobNumber), job.day , job.jobDescription , job.hours , job.yNumber, job.jobCode, job.notes]
            monSaveList.append(contentsOf: addToTimeSheet)
            timeSheetExport.append(contentsOf: addToTimeSheet)
        }
        
        for job in tueJobList {
            addToTimeSheet = ["\n", String(job.jobNumber), job.day , job.jobDescription , job.hours , job.yNumber, job.jobCode, job.notes]
            tueSaveList.append(contentsOf: addToTimeSheet)
            timeSheetExport.append(contentsOf: addToTimeSheet)
        }
        
        for job in wedJobList {
            addToTimeSheet = ["\n", String(job.jobNumber), job.day , job.jobDescription , job.hours , job.yNumber, job.jobCode, job.notes]
            wedSaveList.append(contentsOf: addToTimeSheet)
            timeSheetExport.append(contentsOf: addToTimeSheet)
        }
        
        for job in thurJobList {
            addToTimeSheet = ["\n", String(job.jobNumber), job.day , job.jobDescription , job.hours , job.yNumber, job.jobCode, job.notes]
            thurSaveList.append(contentsOf: addToTimeSheet)
            timeSheetExport.append(contentsOf: addToTimeSheet)
        }
        
        for job in friJobList {
            addToTimeSheet = ["\n", String(job.jobNumber), job.day , job.jobDescription , job.hours , job.yNumber, job.jobCode, job.notes]
            friSaveList.append(contentsOf: addToTimeSheet)
            timeSheetExport.append(contentsOf: addToTimeSheet)
        }
        
        for job in satJobList {
            addToTimeSheet = ["\n", String(job.jobNumber), job.day , job.jobDescription , job.hours , job.yNumber, job.jobCode, job.notes]
            satSaveList.append(contentsOf: addToTimeSheet)
            timeSheetExport.append(contentsOf: addToTimeSheet)
        }
        
        for job in sunJobList {
            addToTimeSheet = ["\n", String(job.jobNumber), job.day , job.jobDescription , job.hours , job.yNumber, job.jobCode, job.notes]
            sunSaveList.append(contentsOf: addToTimeSheet)
            timeSheetExport.append(contentsOf: addToTimeSheet)
        }
    }
    
    func saveData() {
        defaults.set(timeSheetExport, forKey: keys.timeSheetExport)
        defaults.set(emailBrain.getUserEmail(), forKey: keys.userEmail)
        //defaults.set(storedArray, forKey: keys.storedArray)
        defaults.set(jobNumber, forKey: keys.jobNumber)
        defaults.set(newJobNumber, forKey: keys.newJobNumber)
        defaults.set(lastJobNumber, forKey: keys.lastJobNumber)
        defaults.set(monHours, forKey: keys.monHours)
        defaults.set(tueHours, forKey: keys.tuesHours)
        defaults.set(wedHours, forKey: keys.wedHours)
        defaults.set(thurhours, forKey: keys.thusHours)
        defaults.set(friHours, forKey: keys.friHours)
        defaults.set(satHours, forKey: keys.satHours)
        defaults.set(sunHours, forKey: keys.sunHours)
        defaults.set(monSaveList, forKey: keys.monSaveList)
        defaults.set(tueSaveList, forKey: keys.tueSaveList)
        defaults.set(wedSaveList, forKey: keys.wedSaveList)
        defaults.set(thurSaveList, forKey: keys.thurSaveList)
        defaults.set(friSaveList, forKey: keys.friSaveList)
        defaults.set(satSaveList, forKey: keys.satSaveList)
        defaults.set(sunSaveList, forKey: keys.sunSaveList)
        defaults.set(saveDataPresent, forKey: keys.saveDataPresent)
        
    }

    func checkForSavedData() {
        let savedTimeSheetExport = defaults.object(forKey: keys.timeSheetExport) as? [String] ?? [String]()
        timeSheetExport = savedTimeSheetExport

        let savedUserEmail = defaults.value(forKey: keys.userEmail) as? String ?? "No Email Saved"
        emailBrain.setUserEmail(emailAddress: savedUserEmail)

        let savedJobNumber = defaults.value(forKey: keys.jobNumber) as? Int ?? 0
        jobNumber = savedJobNumber
        
        let savedNewJobNumber = defaults.value(forKey: keys.newJobNumber) as? Int ?? 0
        newJobNumber = savedNewJobNumber
        
        let savedLastJobNumber = defaults.value(forKey: keys.lastJobNumber) as? Int ?? 0
        lastJobNumber = savedLastJobNumber

        let savedMonJobList = defaults.value(forKey: keys.monSaveList) as? [String] ?? ["No Data"]
        monSaveList = savedMonJobList

        let savedTueJobList = defaults.value(forKey: keys.tueSaveList) as? [String] ?? ["No Data"]
        tueSaveList = savedTueJobList

        let savedWedJobList = defaults.value(forKey: keys.wedSaveList) as? [String] ?? ["No Data"]
        wedSaveList = savedWedJobList

        let savedThurJobList = defaults.value(forKey: keys.thurSaveList) as? [String] ?? ["No Data"]
        thurSaveList = savedThurJobList

        let savedFriJobList = defaults.value(forKey: keys.friSaveList) as? [String] ?? ["No Data"]
        friSaveList = savedFriJobList

        let savedSatJobList = defaults.value(forKey: keys.satSaveList) as? [String] ?? ["No Data"]
        satSaveList = savedSatJobList

        let savedSunJobList = defaults.value(forKey: keys.sunSaveList) as? [String] ?? ["No Data"]
        sunSaveList = savedSunJobList

        let savedMondayHours = defaults.double(forKey: keys.monHours)
        monHours = savedMondayHours

        let savedTuesdayHours = defaults.double(forKey: keys.tuesHours)
        tueHours = savedTuesdayHours

        let savedWednesdayHours = defaults.double(forKey: keys.wedHours)
        wedHours = savedWednesdayHours

        let savedThursdayHours = defaults.double(forKey: keys.thusHours)
        thurhours = savedThursdayHours

        let savedFridayHours = defaults.double(forKey: keys.friHours)
        friHours = savedFridayHours

        let savedSaturdayHours = defaults.double(forKey: keys.satHours)
        satHours = savedSaturdayHours

        let savedSundayHours = defaults.double(forKey: keys.sunHours)
        sunHours = savedSundayHours
        
        let isThereSavedData = defaults.bool(forKey: keys.saveDataPresent)
        saveDataPresent = isThereSavedData

        updateHours()
        
        if saveDataPresent == true {
            convertToDataModel()
        }
    }
    
    func convertToDataModel() {

        var tempSaveArray: [String] = []
        var totalJobs: [String] = []
        let totalTimesToLoop: Int

        monJobList.removeAll()
        tueJobList.removeAll()
        wedJobList.removeAll()
        thurJobList.removeAll()
        friJobList.removeAll()
        satJobList.removeAll()
        sunJobList.removeAll()

        totalJobs.append(contentsOf: monSaveList)
        totalJobs.append(contentsOf: tueSaveList)
        totalJobs.append(contentsOf: wedSaveList)
        totalJobs.append(contentsOf: thurSaveList)
        totalJobs.append(contentsOf: friSaveList)
        totalJobs.append(contentsOf: satSaveList)
        totalJobs.append(contentsOf: sunSaveList)

        // append contents to tempSaveArray otherwise it wipes saved data
        tempSaveArray.append(contentsOf: totalJobs)

        // Total amount of jobs in list
        totalTimesToLoop = totalJobs.count / 8

        for _ in (0...totalTimesToLoop) {

            if tempSaveArray != [] {
                let tempArray = JobCellDataModel(jobNumber: Int(tempSaveArray[1]) ?? 0, day: tempSaveArray[2] , yNumber: tempSaveArray[5], jobDescription: tempSaveArray[3], jobCode: tempSaveArray[6], hours: tempSaveArray[4], notes: tempSaveArray[7])

                if tempSaveArray[2] == "Monday" {
                    monJobList.append(tempArray)
                } else if tempSaveArray[2] == "Tuesday" {
                    tueJobList.append(tempArray)
                } else if tempSaveArray[2] == "Wednesday" {
                    wedJobList.append(tempArray)
                } else if tempSaveArray[2] == "Thursday" {
                    thurJobList.append(tempArray)
                } else if tempSaveArray[2] == "Friday" {
                    friJobList.append(tempArray)
                } else if tempSaveArray[2] == "Saturday" {
                    satJobList.append(tempArray)
                } else if tempSaveArray[2] == "Sunday" {
                    sunJobList.append(tempArray)
                }
            }

            // This removes the job from tempSaveArray after it has been added to the correct job list

            for _ in (0...7) {
                if tempSaveArray.first != nil {
                    print("temp array - \(tempSaveArray.first)")
                    tempSaveArray.removeFirst()
                }

            }
        }
    }
    
    func setHours() {
        
        let today = Calendar.current.component(.weekday, from: Date())
        let currentDay = timeSheetBrain.getwhichDayOfTheWeek()
        var jobHours = hours ?? 0.0
        
        if dayOfJob == currentDay {
            if jobNumber <= lastJobNumber {
                jobHours -= previousHours
            }
            
            switch today {
            case 1:
                return monHours += jobHours
            case 2:
                return tueHours += jobHours
            case 3:
                return wedHours += jobHours
            case 4:
                return thurhours += jobHours
            case 5:
                return friHours += jobHours
            case 6:
                return satHours += jobHours
            case 7:
                return sunHours += jobHours
            default:
                return sunHours += jobHours
            }
        }
        
    }
    
    func updateHours() {
        
        let today = Calendar.current.component(.weekday, from: Date())
        switch today {
        case 1:
            return hoursLabel.text = String(monHours)
        case 2:
            return hoursLabel.text = String(tueHours)
        case 3:
            return hoursLabel.text = String(wedHours)
        case 4:
            return hoursLabel.text = String(thurhours)
        case 5:
            return hoursLabel.text = String(friHours)
        case 6:
            return hoursLabel.text = String(satHours)
        case 7:
            return hoursLabel.text = String(sunHours)
        default:
            return hoursLabel.text = "No Hours"
        }
    }



    func clearTimeSheetData() {
        /*
         function clears all time sheet data stored in variables
         resets hours on days VC Buttons
         then saves the changes into user defaults
         */

        timeSheetExport = []

        // Sets all day hours to 0.0
        hours = 0.0
        monHours = 0.0
        tueHours  = 0.0
        wedHours  = 0.0
        thurhours = 0.0
        friHours  = 0.0
        satHours  = 0.0
        sunHours  = 0.0

        yNumber = ""
        jobCode = ""
        jobNumber = 1
        newJobNumber = 1
        lastJobNumber = 0

        // Clear csvString or the data will stay after its been cleared
        csvString = ""

        /*Call whichDayOfTheWeek() & setHoursOnDaysVC() to reset hours on
         days VC Buttons
         */

        setHours()
        updateHours()
        hoursLabel.text = "0.0"

        monJobList = []
        tueJobList = []
        wedJobList = []
        thurJobList = []
        friJobList = []
        satJobList = []
        sunJobList = []
        
        monSaveList = []
        tueSaveList = []
        wedSaveList = []
        thurSaveList = []
        friSaveList = []
        satSaveList = []
        sunSaveList = []
        
        // save data after clearing or if closed app then reopen data will be reloaded
        // from user defaults
        saveDataPresent = false
        saveData()
        
        let ac = UIAlertController(title: "No Data", message: "You have cleared all time sheet data.", preferredStyle: .alert)
        
        // This puts a button on the alert
        ac.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        
        // This presents the alert
        present(ac, animated: true)
    }
}
