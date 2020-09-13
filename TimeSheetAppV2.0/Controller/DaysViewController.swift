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
    
    
    var dayPressed: String?
    var date: String?
    var jobNumber: Int = 1
    var lastJobNumber: Int?
    var jobDescription: String?
    var hours: Double?
    var yNumber: String?
    var jobCode: String?
    var notes: String?
    var userEmail: String?
    var timeSheetExport: [String] = []
    var clearData = false
    var csvString: String?
    var clearTable = false
    var saveDataPresent = false
   
//    var jobList: [JobCellDataModel] = []
    //var mondayArray: [JobCellDataModel] = []
//    var storedArray: [String] = []
    var iteratedArray: [JobCellDataModel] = []
    
    // Reference to managed object context
    //let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    // Data for the table
    //var job: [JobDataModel]?
    
    
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

    var dataRe = false
    
    struct keys {
        //Keys for saving data
        static let timeSheetExport   = "timeSheetExport"
        static let userEmail         = "userEmail"
        static let jobNumber         = "jobNumber"
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
        
        monSaveList = []
        
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
        //createArray()

        
        // gets job data from addEditTaksVC
        NotificationCenter.default.addObserver(self, selector: #selector(didGetNotificationJobNumber(_:)), name: Notification.Name("jobNumberTextField"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(didGetNotificationJobDescription(_:)), name: Notification.Name("jobDescriptionTextField"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(didGetNotificationHours(_:)), name: Notification.Name("hoursTextField"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(didGetNotificationYNumber(_:)), name: Notification.Name("yNumberTextField"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(didGetNotificationJobCode(_:)), name: Notification.Name("jobCodeTextField"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(didGetNotificationNotes(_:)), name: Notification.Name("notesTextField"), object: nil)

        //Get User Email
        NotificationCenter.default.addObserver(self, selector: #selector(didGetNotificationEmail(_:)), name: Notification.Name("emailTextField"), object: nil)

        //  tells func didGetNotificationReloadData there is data to be appended to addJobToListString() and calls this function
        NotificationCenter.default.addObserver(self, selector: #selector(didGetNotificationReloadData(_:)), name: Notification.Name("ReloadData"), object: nil)

        // tells func didGetNotificationClearData to clear all time sheet data
        NotificationCenter.default.addObserver(self, selector: #selector(didGetNotificationClearData(_:)), name: Notification.Name("clearTimeSheetData"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(didGetNotificationClearTable(_:)), name: Notification.Name("ClearTable"), object: nil)
        //loadTableViewOnStartUp()
        //checkForSavedData()
    }
    
//    func fetchData() {
//
//        // Fetch data from core data
//        do {
//            self.job = try context.fetch(JobDataModel.fetchRequest())
//        }
//        catch {
//
//        }
//
//    }
    
    
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
        //self.fetchData()
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
        
        //print("this got run")
        
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
            destinationVC.jobNumber = jobNumber
            print(jobNumber)
        }
        
    }
    @IBAction func addJobButtonPressed(_ sender: UIButton) {
        //Opens addEditTask View Controller Modually
//        let addEditController = storyboard?.instantiateViewController(identifier: "AddEditViewController") as! AddEditViewController
//        present(addEditController, animated: true)
        
        self.performSegue(withIdentifier: "addEditViewController", sender: self)
//        if let vc = storyboard?.instantiateViewController(withIdentifier: "AddEditViewController") as? AddEditViewController {
//            navigationController?.pushViewController(vc, animated: true)
//        }
    }

    @IBAction func exportButtonPressed(_ sender: UIButton) {

        userEmail = emailBrain.getUserEmail()

        csvString = timeSheetExport.joined(separator: ",")
        //print("csv string - \(csvString ?? "No CSV String Data")")

        let data = csvString!.data(using: String.Encoding.utf8, allowLossyConversion: false)
        if let content = data {
            print("NSData: \(content)")
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
    
    @objc func didGetNotificationJobNumber(_ notification: Notification) {
        let jobNumberText = notification.object as! String
        jobNumber = Int(jobNumberText)!
        print("Job Number - \(jobNumber)")
    }

    @objc func didGetNotificationJobDescription(_ notification: Notification) {
        let descriptionText = notification.object as! String
        jobDescription = descriptionText
        print("Job Description - \(jobDescription ?? "No Job Description")")
    }

    @objc func didGetNotificationHours(_ notification: Notification) {
        let hoursText = notification.object as! String
        hours = Double(hoursText)
        print("hours - \(hours ?? 0.0)")
    }

    @objc func didGetNotificationYNumber(_ notification: Notification) {
        let yNumberText = notification.object as! String
        yNumber = yNumberText
        print("y number - \(yNumber ?? "No Y Number")")
    }

    @objc func didGetNotificationJobCode(_ notification: Notification) {
        let jobCodeText = notification.object as! String
        jobCode = jobCodeText
        print("job Code - \(jobCode ?? "No Job Code")")
    }

    @objc func didGetNotificationNotes(_ notification: Notification) {
        let notesText = notification.object as! String
        notes = notesText
        print("notes - \(notes!)")
    }

    @objc func didGetNotificationEmail(_ notification: Notification) {
        let email = notification.object as! String
        emailBrain.setUserEmail(emailAddress: email)
        print("email - \(email)")
    }

    @objc func didGetNotificationClearData(_ notification: Notification) {
        clearData = notification.object as! Bool
        //print(clearData)

        if clearData == true {
            clearTimeSheetData()
        }

        clearData = false
    }

    @objc func didGetNotificationReloadData(_ notification: Notification) {
        dataRe = notification.object as! Bool

        if dataRe == true {
            print("View Controller got Reloaded")

            // creates/adds job to job list and reloads the table view
            createArray()
//            fridayTableView.reloadData()
            
            //addJobToListString()
            //print(timeSheetBrain.getwhichDayOfTheWeek())
            //timeSheetBrain.getwhichDayOfTheWeek()
            incrementJobNumber()
            setHours()
            updateHours()
            saveData()
        }
    }
    
    @objc func didGetNotificationClearTable(_ notification: Notification) {
        clearTable = notification.object as! Bool
        //print(clearTable)

        if clearTable == true {
            
//            hours = 0.0
//            yNumber = ""
//            jobCode =  ""
            
        }

        clearData = false
    }
    
    func incrementJobNumber() {
        jobNumber += 1
    }

    
    func createArray() {
        
        //var tempArray: [JobCellDataModel] = []
        
//        var addToTimeSheet = JobCellDataModel(yNumber: yNumber ?? "No Y Number", jobCode: jobCode  ?? "No Job Code", hours: String(hours ?? 0.0))
        
        let addToTimeSheet = JobCellDataModel(jobNumber: String(jobNumber), yNumber: yNumber ?? "", jobCode: jobCode ?? "", hours: String(hours ?? 0.0))
        
        
        //var addToTSheet = [yNumber ?? "No Y Number", jobCode  ?? "No Job Code", String(hours ?? 0.0)]

    
//        if addToTimeSheet.yNumber == "" {
//            for items in (0...2) {
//                       addToTimeSheet.removeFirst()
//                   }
//                   //            iteratedArray = []
//
//                   // This gets iterated through and then is cleared by end of function call
//                   iteratedArray.append(contentsOf: addToTimeSheet)
//
//        }
        
        if addToTimeSheet.yNumber == "" {
            
            noJobs()
            
        } else {
            
            if jobNumber <= lastJobNumber ?? 0 {
                
                if timeSheetBrain.getwhichDayOfTheWeek() == "Monday" {

                    self.monJobList[jobNumber] = addToTimeSheet
                    
                } else if timeSheetBrain.getwhichDayOfTheWeek() == "Tuesday" {
                    tueJobList.append(addToTimeSheet)
                } else if timeSheetBrain.getwhichDayOfTheWeek() == "Wednesday" {
                    wedJobList.append(addToTimeSheet)
                } else if timeSheetBrain.getwhichDayOfTheWeek() == "Thursday" {
                    thurJobList.append(addToTimeSheet)
                } else if timeSheetBrain.getwhichDayOfTheWeek() == "Friday" {
                    friJobList.append(addToTimeSheet)
                } else if timeSheetBrain.getwhichDayOfTheWeek() == "Saturday" {
                    satJobList.append(addToTimeSheet)
                } else if timeSheetBrain.getwhichDayOfTheWeek() == "Sunday" {
                    print("This worked")
                    self.sunJobList[jobNumber - 1] = addToTimeSheet
                }
                
            } else {
                print("This got run")
                
                lastJobNumber = jobNumber
                
                if timeSheetBrain.getwhichDayOfTheWeek() == "Monday" {
                    monJobList.append(addToTimeSheet)
                } else if timeSheetBrain.getwhichDayOfTheWeek() == "Tuesday" {
                    tueJobList.append(addToTimeSheet)
                } else if timeSheetBrain.getwhichDayOfTheWeek() == "Wednesday" {
                    wedJobList.append(addToTimeSheet)
                } else if timeSheetBrain.getwhichDayOfTheWeek() == "Thursday" {
                    thurJobList.append(addToTimeSheet)
                } else if timeSheetBrain.getwhichDayOfTheWeek() == "Friday" {
                    friJobList.append(addToTimeSheet)
                } else if timeSheetBrain.getwhichDayOfTheWeek() == "Saturday" {
                    satJobList.append(addToTimeSheet)
                } else if timeSheetBrain.getwhichDayOfTheWeek() == "Sunday" {
                    sunJobList.append(addToTimeSheet)
                }
            }
            
            
            
        }
        
        //print(timeSheetBrain.getwhichDayOfTheWeek())
        
        
        saveDataPresent = true
        print("Save data present - \(saveDataPresent)")
        addJobToListString()
        saveData()
        
        // Create jobData Object
//        let newJob = JobDataModel(context: self.context)
//        newJob.yNumber = yNumber
//        newJob.jobCode = jobCode
//        newJob.hours = hours!
//        
//        // Save the data
//        do {
//            try self.context.save()
//        }
//        catch {
//            
//        }
        
//        tempArray.append(contentsOf: iteratedArray)
//
//        return tempArray
    }
    
    func noJobs() {
        
        let ac = UIAlertController(title: "No Data", message: "You currently have no saved jobs.", preferredStyle: .alert)
        
        // This puts a button on the alert
        ac.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        
        // This presents the alert
        present(ac, animated: true)
        
    }
    
//
//
    func addJobToListString() {

        // Array contains variable data to be added to export list
        // \n in item 1 of array starts the job on a new line.
        let addToTimeSheet = ["\n\(timeSheetBrain.getwhichDayOfTheWeek())", String(jobNumber), jobDescription ?? "No Job Description", String(hours ?? 0.0), yNumber ?? "No Y Number", jobCode ?? "No Job Code", notes ?? "No Notes"]
        
        if timeSheetBrain.getwhichDayOfTheWeek() == "Monday" {
            monSaveList.append(contentsOf: addToTimeSheet)
        } else if timeSheetBrain.getwhichDayOfTheWeek() == "Tuesday" {
            tueSaveList.append(contentsOf: addToTimeSheet)
        } else if timeSheetBrain.getwhichDayOfTheWeek() == "Wednesday" {
            wedSaveList.append(contentsOf: addToTimeSheet)
        } else if timeSheetBrain.getwhichDayOfTheWeek() == "Thursday" {
            thurSaveList.append(contentsOf: addToTimeSheet)
        } else if timeSheetBrain.getwhichDayOfTheWeek() == "Friday" {
            friSaveList.append(contentsOf: addToTimeSheet)
        } else if timeSheetBrain.getwhichDayOfTheWeek() == "Saturday" {
            satSaveList.append(contentsOf: addToTimeSheet)
        } else if timeSheetBrain.getwhichDayOfTheWeek() == "Sunday" {
            sunSaveList.append(contentsOf: addToTimeSheet)
        }

        // Appends contents of addTimeSheet to timeSheetExport
        timeSheetExport.append(contentsOf: addToTimeSheet)

        // Prints export array to console
        //print(timeSheetExport)
    }
//
    func saveData() {
        defaults.set(timeSheetExport, forKey: keys.timeSheetExport)
        defaults.set(emailBrain.getUserEmail(), forKey: keys.userEmail)
        //defaults.set(storedArray, forKey: keys.storedArray)
        defaults.set(jobNumber, forKey: keys.jobNumber)
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

//        let savedStoredArray = defaults.value(forKey: keys.storedArray) as? [String] ?? [String]()
//        storedArray = savedStoredArray
        let savedJobNumber = defaults.value(forKey: keys.jobNumber) as? Int ?? 0
        jobNumber = savedJobNumber

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
        print(friSaveList)

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

        //timeSheetBrain.getwhichDayOfTheWeek()
        updateHours()
        
        print("Got this far")
        print("Save data present - \(saveDataPresent)")
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
        totalTimesToLoop = totalJobs.count / 7 - 1
        
        for _ in (0...totalTimesToLoop) {
            
            let tempArray = JobCellDataModel(jobNumber: tempSaveArray[1], yNumber: tempSaveArray[4], jobCode: tempSaveArray[5], hours: tempSaveArray[3])
            
            if tempSaveArray[0] == "\nMonday" {
                monJobList.append(tempArray)
            } else if tempSaveArray[0] == "\nTuesday" {
                tueJobList.append(tempArray)
            } else if tempSaveArray[0] == "\nWednesday" {
                wedJobList.append(tempArray)
            } else if tempSaveArray[0] == "\nThursday" {
                thurJobList.append(tempArray)
            } else if tempSaveArray[0] == "\nFriday" {
                friJobList.append(tempArray)
                print(tempSaveArray)
            } else if tempSaveArray[0] == "\nSaturday" {
                satJobList.append(tempArray)
            } else if tempSaveArray[0] == "\nSunday" {
                sunJobList.append(tempArray)
            }
            
            // This removes the job from tempSaveArray after it has been added to the correct job list
            for _ in (0...6) {
                print(tempSaveArray.first)
                tempSaveArray.removeFirst()

            }
        }
    }
    
//    func convertToDataModel() {
//
//        var tempSaveArray: [String] = []
//        var totalJobs: [String] = []
//        let totalTimesToLoop: Int
//
//        monJobList.removeAll()
//        tueJobList.removeAll()
//        wedJobList.removeAll()
//        thurJobList.removeAll()
//        friJobList.removeAll()
//        satJobList.removeAll()
//        sunJobList.removeAll()
//
//        totalJobs.append(contentsOf: monSaveList)
//        totalJobs.append(contentsOf: tueSaveList)
//        totalJobs.append(contentsOf: wedSaveList)
//        totalJobs.append(contentsOf: thurSaveList)
//        totalJobs.append(contentsOf: friSaveList)
//        totalJobs.append(contentsOf: satSaveList)
//        totalJobs.append(contentsOf: sunSaveList)
//
//        totalTimesToLoop = totalJobs.count / 6
//
//        // append contents to temp array otherwise it wipes saved data
//        tempSaveArray.append(contentsOf: satSaveList)
//
//        let count = tempSaveArray.count/6
//        print(count)
//
//        if tempSaveArray != [] {
//
//            print("if has run")
//
//            for _ in (0...tempSaveArray.count/6 - 1) {
//
//    //            let addToTimeSheet = ["\n\(timeSheetBrain.getwhichDayOfTheWeek())", jobDescription ?? "No Job Description", String(hours ?? 0.0), yNumber ?? "No Y Number", jobCode ?? "No Job Code", notes ?? "No Notes"]
//                print("Saturday - \(tempSaveArray)")
//                let tempArray = JobCellDataModel(yNumber: tempSaveArray[3], jobCode: tempSaveArray[4], hours: tempSaveArray[2])
//                    satJobList.append(tempArray)
//
//                print("if 2 has run")
//
//                for _ in (0...5) {
//                    tempSaveArray.removeFirst()
//
//                    print("if 3 has run")
//                }
//            }
//        }
//    }


    func setHours() {
        
        let today = Calendar.current.component(.weekday, from: Date())
        switch today {
        case 1:
            return monHours += hours ?? 0.0
        case 2:
            return tueHours += hours ?? 0.0
        case 3:
            return wedHours += hours ?? 0.0
        case 4:
            return thurhours += hours ?? 0.0
        case 5:
            return friHours += hours ?? 0.0
        case 6:
            return satHours += hours ?? 0.0
        case 7:
            return sunHours += hours ?? 0.0
        default:
            return sunHours += hours ?? 0.0
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

//        storedArray = []
//        iteratedArray = []
        timeSheetExport = []
        print("week has been cleared - \(timeSheetExport)")

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
        lastJobNumber = 0

        // Clear csvString or the data will stay after its been cleared
        csvString = ""

        /*Call whichDayOfTheWeek() & setHoursOnDaysVC() to reset hours on
         days VC Buttons
         */

        //timeSheetBrain.getwhichDayOfTheWeek()
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
        

       // print("clearTimeSheet Data Run")
        
        let ac = UIAlertController(title: "No Data", message: "You have cleared all time sheet data.", preferredStyle: .alert)
        
        // This puts a button on the alert
        ac.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        
        // This presents the alert
        present(ac, animated: true)
    }

}
