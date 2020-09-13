//
//  AddEditViewController.swift
//  TimeSheetAppV2.0
//
//  Created by Matthew Hollyhead on 16/06/2020.
//  Copyright © 2020 Matthew Hollyhead. All rights reserved.
//

import Foundation
import UIKit

class AddEditViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate{
    
    var timeSheetBrain = TimeSheetBrain()
    
    var jobNumber: Int?
    var jobDescription: String?
    var hours: String?
    var yNumber: String?
    var jobCode: String?
    var pickerData: [(jobCode: String, jobDescription: String)] = [(String, String)]()
    var jobCodeData: [String: String] = [:]
    var dataReload = true
    
    var editJob: [JobCellDataModel] = []
    
    
    
    @IBAction func addTaskButtonClicked(_ sender: UIButton) {
        
        let controllers = self.navigationController?.viewControllers
        
        NotificationCenter.default.post(name: Notification.Name("jobNumberTextField"), object: jobNumberTextField.text)
        NotificationCenter.default.post(name: Notification.Name("yNumberTextField"), object: yNumberTextField.text)
        NotificationCenter.default.post(name: Notification.Name("hoursTextField"), object: hoursTextField.text)
        NotificationCenter.default.post(name: Notification.Name("jobCodeTextField"), object: jobCodeTextField.text)
        NotificationCenter.default.post(name: Notification.Name("jobDescriptionTextField"), object: jobDescriptionTextField.text)
        NotificationCenter.default.post(name: Notification.Name("notesTextField"), object: notesTextField.text)
        
        
        NotificationCenter.default.post(name: Notification.Name("ReloadData"), object: dataReload)
        
        // Dismisses back to root view controller
        self.navigationController?.popToRootViewController(animated: true)
        
    }
    
    
    @IBOutlet weak var jobNumberTextField: UITextField!
    @IBOutlet weak var jobDescriptionTextField: UITextField!
    @IBOutlet weak var hoursTextField: UITextField!
    @IBOutlet weak var yNumberTextField: UITextField!
    @IBOutlet weak var jobCodeTextField: UITextField!
    @IBOutlet weak var notesTextField: UITextField!
    @IBOutlet weak var jobCodePickerClicked: UIPickerView!
    
    @IBAction func hoursFieldClicked(_ sender: Any) {
        hoursTextField.keyboardType = UIKeyboardType.decimalPad
        jobCodePickerClicked.isHidden = true;
    }
    
    @IBAction func jobCodeTextFieldClicked(_ sender: UITextField) {
        
        jobCodePickerClicked.isHidden = false
        
    }
    
    
    // number of colums of data
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    //number of rows of data
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    //Place UIPicker View data view in return
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return pickerData[row].jobDescription
    }
    
    // fills job code and job description fields with data from pickerData
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        jobCodeTextField.text = pickerData[row].jobCode
        jobDescriptionTextField.text = pickerData[row].jobDescription
        jobCodePickerClicked.isHidden = true;
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        jobDescriptionTextField.delegate = self
        hoursTextField.delegate = self
        yNumberTextField.delegate = self
        notesTextField.delegate = self
        
        // Connect Picker Data
        jobCodePickerClicked.delegate = self
        jobCodePickerClicked.dataSource = self


        self.jobCodePickerClicked.isHidden = true;

        jobCodeTextField.delegate = self
        jobCodeTextField.inputView = jobCodePickerClicked
        
        // Picker Data
        pickerData = [("WVTA", "Electrical Repair"), ("WVYB", "Chassis Repair"), ("WVTG", "Cutter Head Repair"), ("WVYH", "Engine Repair"), ("WVTN", "Tyre Repair"), ("WVYP", "Transmission Repair"), ("WVTV", "Hydraulic Repair"), ("9A01", "Annual Leave"), ("9A05", "Statatory Holiday"), ("9N10", "Training/Development"), ("9N03", "Supervision"),  ("9N23", "Workshop Cleraning")]
        
        jobNumberTextField.text = String(jobNumber!)
        yNumberTextField.text = yNumber ?? ""
        jobCodeTextField.text = jobCode ?? ""
        hoursTextField.text = hours ?? ""
        
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Dismisses keyboard when you hit return key
        jobNumberTextField.endEditing(true)
        jobDescriptionTextField.endEditing(true)
        hoursTextField.endEditing(true)
        yNumberTextField.endEditing(true)
        notesTextField.endEditing(true)
        return true
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        var showPicker = true
        
        // if jobCode text field clicked picker is shown
        if textField == jobCodeTextField {
            
            showPicker = false
            
            jobCodePickerClicked.isHidden = showPicker
            
        }
        
        return showPicker
    }

}
