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
    //let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var clearData = false
    
    @IBOutlet weak var jobsListTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        jobsListTableView.reloadData()
        jobsListTableView.delegate = self
        jobsListTableView.dataSource = self
        
    }
}

//MARK: - UITableViewDelegate, UITableViewDataSource

extension JobsTableViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("job list number of rows \(jobList.count)")
        return jobList.count

        //return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let jobs = jobList[indexPath.row]

        let cell = tableView.dequeueReusableCell(withIdentifier: "JobCell") as! JobsTableViewCell

        cell.setJobCellData(jobList: jobs)

        print(jobList[0])

        return cell
    }
    
//    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//
//        // Create swipe action
//        let action = UIContextualAction(style: .destructive, title: "Delete") { (action, view, completionHandler) in
//
//            // Which Job removed
//            let jobToRemove = self.jobList[indexPath.row]
//
//            // remove to job
//            self.context.delete(jobToRemove)
//
//            do {
//                try self.context.save()
//            }
//            catch {
//
//            }
//
//            self.fetchData()
//
//
//        }
//
//        return UISwipeActionsConfiguration(actions: [action])
//    }
    
}
