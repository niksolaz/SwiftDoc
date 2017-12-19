//
//  TodoItem.swift
//  swiftDoc
//
//  Created by Nicola Solazzo on 13/12/17.
//  Copyright © 2017 Nicola Solazzo. All rights reserved.
//

import Foundation
//create basic Item
class TodoItem {
    var name:String
    var notice:String
    
    init(name:String, notice:String){
        self.name = name
        self.notice = notice
    }
}
