//
//  JobsViewController.swift
//  TimeSheetAppV2.0
//
//  Created by Matthew Hollyhead on 19/07/2020.
//  Copyright © 2020 Matthew Hollyhead. All rights reserved.
//

import UIKit
import CoreData

class JobsTableViewController: UIViewController {
    
    var jobList: [JobCellDataModel] = []
    var updateJobList: [JobCellDataModel] = []
    var clearTable = true
    
    @IBOutlet weak var jobsListTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        jobsListTableView.reloadData()
        jobsListTableView.delegate = self
        jobsListTableView.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
    }
}

//MARK: - UITableViewDelegate, UITableViewDataSource

extension JobsTableViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return jobList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let jobs = jobList[indexPath.row]

        let cell = tableView.dequeueReusableCell(withIdentifier: "JobCell") as! JobsTableViewCell

        cell.setJobCellData(jobList: jobs)

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let jobs = jobList[indexPath.row]
        if let vc = storyboard?.instantiateViewController(withIdentifier: "AddEditViewController") as? AddEditViewController {
            vc.jobNumber = Int(jobs.jobNumber)
            vc.yNumber = jobs.yNumber
            vc.jobCode = jobs.jobCode
            vc.hours = jobs.hours

            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
//    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//
//    }

    
}
