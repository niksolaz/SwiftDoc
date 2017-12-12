//
//  ViewController.swift
//  swiftDoc
//
//  Created by Nicola Solazzo on 11/12/17.
//  Copyright © 2017 Nicola Solazzo. All rights reserved.
//

import UIKit
import Firebase
import WebKit

class ViewController: UIViewController {

    let todolist_DB_Ref: DatabaseReference = Database.database().reference().child("todolistSwift")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginAnonymous()
        
        
    }
    
    func loginAnonymous(){
        Auth.auth().signInAnonymously { (User, Error) in
            if let error = Error {
                print(error)
            } else {
                if let user = User {
                    print(user.uid)
                }
            }
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

