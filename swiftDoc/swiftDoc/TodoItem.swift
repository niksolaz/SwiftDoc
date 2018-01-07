//
//  TodoItem.swift
//  swiftDoc
//
//  Created by Nicola Solazzo on 13/12/17.
//  Copyright © 2017 Nicola Solazzo. All rights reserved.
//

import Foundation

class TodoItem: Codable {
    var name:String?
    var notice:String?
    var items: [TodoItem]?
    
    init?(json: [String:Any]?){
        if json == nil {
            return nil
        }
        
        guard let name = json!["name"] as? String,
            let notice = json!["notice"] as? String
            else {
                return nil
        }
        self.name = name
        self.notice = notice
        
        if let items = json!["items"] as? [String: Any]{
            self.items = parseItems(items: items)
        }
    }
    
    init(name:String, notice: String){
        self.name = name
        self.notice = notice
        self.items = nil
    }
    
    
    func parseItems(items: [String: Any]?) -> [TodoItem]? {
        var todoItems: [TodoItem]?
        if (items == nil) {
            return todoItems
        }else{
            // Fai qualcosa qui...
            items?.forEach({ (arg: (key: String, value: Any)) in
                
                let (key, itemValue) = arg
                
                let item = TodoItem(json: itemValue as? [String : Any])
                if todoItems == nil {
                    todoItems = []
                }
                
                if (item != nil) {
                    todoItems?.append(item!)
                }
            })
        }
       
        
        
        return todoItems
        
    }
}

