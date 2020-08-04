//
//  JobsTableViewController.swift
//  TimeSheetAppV2.0
//
//  Created by Matthew Hollyhead on 16/07/2020.
//  Copyright © 2020 Matthew Hollyhead. All rights reserved.
//

import UIKit

class JobsTableViewCell: UITableViewCell {
    

    @IBOutlet weak var yNumberLabel: UILabel!
    @IBOutlet weak var jobCodeLabel: UILabel!
    @IBOutlet weak var hoursLabel: UILabel!
    
    
    func setJobCellData(jobList: JobCellDataModel) {
        
        yNumberLabel.text = jobList.yNumber
        jobCodeLabel.text = jobList.jobCode
        hoursLabel.text = String(jobList.hours)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
