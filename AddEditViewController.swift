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
    
    var jobDescription: String?
    var hours: Double?
    var yNumber: Int?
    var jobCode: String?
    var pickerData: [(jobCode: String, jobDescription: String)] = [(String, String)]()
    var jobCodeData: [String: String] = [:]
    var dataReload = true
    
    @IBAction func addTaskButtonClicked(_ sender: UIButton) {
        
        NotificationCenter.default.post(name: Notification.Name("jobDescriptionTextField"), object: jobDescriptionTextField.text)
        NotificationCenter.default.post(name: Notification.Name("hoursTextField"), object: hoursTextField.text)
        NotificationCenter.default.post(name: Notification.Name("yNumberTextField"), object: yNumberTextField.text)
        NotificationCenter.default.post(name: Notification.Name("jobCodeTextField"), object: jobCodeTextField.text)
        NotificationCenter.default.post(name: Notification.Name("notesTextField"), object: notesTextField.text)
        
        
        NotificationCenter.default.post(name: Notification.Name("ReloadData"), object: dataReload)
        
        self.dismiss(animated: true, completion: nil)
    }
    
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
        pickerData = [("WVTA", "Electrical Repair"), ("WVYB", "Chassis Repair"), ("WVTG", "Cutter Head Repair"), ("WVYH", "Engine Repair"), ("WVTN", "Tyre Repair"), ("WVYP", "Transmission Repair"), ("WVTV", "Hydraulic Repair"), ("9N03", "Supervision")]
        
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Dismisses keyboard when you hit return key
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
