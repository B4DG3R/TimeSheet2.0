//
//  SettingsViewController.swift
//  TimeSheetAppV2.0
//
//  Created by Matthew Hollyhead on 14/06/2020.
//  Copyright © 2020 Matthew Hollyhead. All rights reserved.
//

import Foundation
import UIKit

class SettingsViewController: UIViewController {
    
    var clearData = true
    var dataReload = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func addEmailButtonPressed(_ sender: UIButton) {
        
        let addEmailController = storyboard?.instantiateViewController(identifier: "AddEmailViewController") as! AddEmailViewController
        present(addEmailController, animated: true)
    }
    @IBAction func clearWeekButtonPressed(_ sender: UIButton) {
        
        NotificationCenter.default.post(name: Notification.Name("clearTimeSheetData"), object: clearData)
        //NotificationCenter.default.post(name: Notification.Name("ReloadData"), object: dataReload)
        
        dismiss(animated: true, completion: nil)

    }
    
}

