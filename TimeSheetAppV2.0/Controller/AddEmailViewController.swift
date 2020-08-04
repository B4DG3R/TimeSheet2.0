//
//  addEmailViewController.swift
//  TimeSheetAppV2.0
//
//  Created by Matthew Hollyhead on 24/06/2020.
//  Copyright © 2020 Matthew Hollyhead. All rights reserved.
//

import Foundation
import UIKit

class AddEmailViewController: UIViewController, UITextFieldDelegate {
    
    var emailBrain = EmailBrain()
    var userEmailSet: String?
    
    @IBAction func addEmailButtonPressed(_ sender: UIButton) {
        
        NotificationCenter.default.post(name: Notification.Name("emailTextField"), object: emailTextField.text)
        
        dismiss(animated: true, completion: nil)
    }
    @IBOutlet weak var emailTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailTextField.delegate = self
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Dismisses keyboard when you hit return key
        emailTextField.endEditing(true)
        return true
    }
}
