//
//  EmailBrain.swift
//  TimeSheetApp
//
//  Created by Matthew Hollyhead on 18/05/2020.
//  Copyright © 2020 Matthew Hollyhead. All rights reserved.
//

import UIKit

struct EmailBrain {
    
    var userEmail: UserEmail?
    
    let userEmailKey = "userEmailKey"
    
    mutating func setUserEmail(emailAddress: String) {
        userEmail = UserEmail(email: emailAddress)
        print("Email Set to \(userEmail?.email ?? "")")
        
//        let defaults = UserDefaults.standard
//        defaults.set(userEmail, forKey: "userEmailKey")
//    
    }
    
    func getUserEmail() -> String {
        //let sendEmail = String(userEmail?.email ?? "No Email")
        //print("got right email to send - \(sendEmail)")
        
//        let defaults = UserDefaults.standard
//        
//           if let name = defaults.string(forKey: userEmailKey) {
//               print("name is - \(name)")
//           }
        
        return userEmail?.email ?? "No Email"
        
        
    }
    
}
