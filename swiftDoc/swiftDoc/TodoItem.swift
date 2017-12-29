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
    var list:Any?
    
    init(name:String, notice:String, list:Any?){
        self.name = name
        self.notice = notice
        self.list = list
    }
}
