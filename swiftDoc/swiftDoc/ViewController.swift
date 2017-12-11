//
//  ViewController.swift
//  swiftDoc
//
//  Created by Nicola Solazzo on 11/12/17.
//  Copyright © 2017 Nicola Solazzo. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {

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

