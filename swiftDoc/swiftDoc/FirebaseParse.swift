//
//  FirebaseParse.swift
//  swiftDoc
//
//  Created by Nicola Solazzo on 29/12/17.
//  Copyright © 2017 Nicola Solazzo. All rights reserved.
//

import Foundation
import Firebase

class FirebaseParse {
    
    let ref: DatabaseReference =  Database.database().reference().child("todolistSwift")
    
    override func firebaseParse{
        
        super.firebaseParse()
        ref.observe(.value) { (snapshot) in
        for item in snapshot.children {
        
        let todoData = item as! DataSnapshot
        
        let itemSwD = todoData.value as! [String:Any]
        
        let name:String = itemSwD["name"] as! String
        print(name)
        let notice:String = itemSwD["notice"] as! String
        print(notice)
        
        let todoSwD = TodoItem(name:name, notice:notice)
        print(todoSwD)
        self.todoItemsSwD.append(todoSwD)
        }
        self.tableView.reloadData()
        }
    }
}
