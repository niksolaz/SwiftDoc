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
/*
     Create costant to connect database
     where Database.database().reference() reference "nameApp-****.firebaseio.com/"
     and .child(pathString) is /name databse
     
 */
    
    //let todolist_DB_Ref: DatabaseReference = Database.database().reference().child("todolistSwift")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //call login anonymous
        loginAnonymous()
    
        //***test connection database
        //***add item with child test
        //let item = todolist_DB_Ref.child("test")
        //***add value set
        //let values: [String: Any] = ["name":"test connection"]
        //***set item with value
        //item.setValue(values)
 
    }
    //Create login anonymous to firebase
    func loginAnonymous(){
        Auth.auth().signInAnonymously { (User, Error) in
            if let error = Error {
                //in case Error
                print(error)
            } else {
                if let user = User {
                    //in case Correct Login
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

