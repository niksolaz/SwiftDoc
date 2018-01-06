//
//  File.swift
//  swiftDoc
//
//  Created by Nicola Solazzo on 06/01/18.
//  Copyright © 2018 Nicola Solazzo. All rights reserved.
//

import Cache
import Firebase

class DataFetcher: NSObject{
    var internalStorage: Cache.Storage
    
    let ref: DatabaseReference =  Database.database().reference().child("todolistSwift")
    let swiftDataOnlineKey: String = "Swift Documentation Online Data"
    let swiftDataOfflineKey: String = "Swift Documentation Offline Data"
    
    override init() {
        let diskConfig = DiskConfig(
            // The name of disk storage, this will be used as folder name within directory
            name: "Floppy",
            // Expiry date that will be applied by default for every added object
            // if it's not overridden in the `setObject(forKey:expiry:)` method
            expiry: .date(Date().addingTimeInterval(3600/60)),
            // Maximum size of the disk cache storage (in bytes)
            maxSize: 10000,
            // Where to store the disk cache. If nil, it is placed in `cachesDirectory` directory.
            directory: try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask,
                                                    appropriateFor: nil, create: true).appendingPathComponent("MyPreferences"),
            // Data protection is used to store files in an encrypted format on disk and to decrypt them on demand
            protectionType: .complete
        )
        
        let memoryConfig = MemoryConfig(
            // Expiry date that will be applied by default for every added object
            // if it's not overridden in the `setObject(forKey:expiry:)` method
            expiry: .date(Date().addingTimeInterval(2*60)),
            /// The maximum number of objects in memory the cache should hold
            countLimit: 50,
            /// The maximum total cost that the cache can hold before it starts evicting objects
            totalCostLimit: 0
        )
        
        do{
            internalStorage = try! Storage(diskConfig: diskConfig, memoryConfig: memoryConfig)
        }catch {
            print(error)
        }
    }
    
    func retrieveData(completionDataOnline: @escaping (_ result: [TodoItem]) -> Void){
        let hasOnlineData = try? self.internalStorage.existsObject(ofType: [TodoItem].self, forKey: self.swiftDataOnlineKey)
        if (hasOnlineData == true){
            let result = try? self.internalStorage.object(ofType: [TodoItem].self, forKey: self.swiftDataOnlineKey)
            completionDataOnline(result!)
        }else{
            self.firebaseParse(completion: { (result:[TodoItem]) in
                try? self.internalStorage.setObject(result, forKey: self.swiftDataOnlineKey)
                completionDataOnline(result)
            })
        }
    }
    
    func retrieveDataOffline(completionDataOffline: @escaping (_ result: [TodoItem])->Void){
        var todoItems:[TodoItem] = []
        
        if let path = Bundle.main.path(forResource: "swiftdoc-offline", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                var json = try JSONSerialization.jsonObject(with: data)
                guard let mainItem = json as? [String: Any],
                    let mainList = mainItem["todolistSwift"] as? [String: Any] else {
                    print("Error!!!")
                    return
                }
                
                // Sort the json list. JSONSerialization could return data that it is not sorted correctly.
                var sortedList = mainList.sorted(by: { $0.0 < $1.0 })
                
                sortedList.forEach({ (key, value) in
                    // For each item, create a new TodoItem
                    var item = value as? [String: Any]
                    var todoItem: TodoItem = TodoItem(json: item)!
                    todoItems.append(todoItem)
                })
                
            } catch {
                // handle error
            }
        }
        // Send the data to the completion handler
        completionDataOffline(todoItems)
    }
    
    
    func firebaseParse(completion: @escaping (_ result: [TodoItem])->Void){
        
        checkIfConnectedToFirebase { (isConnected: Bool) in
            if(isConnected){
                var todoItems:[TodoItem] = []
                self.ref.observe(.value) { (snapshot) in
                    for item in snapshot.children {
                        
                        
                        let todoData = item as! DataSnapshot
                        
                        let itemSwD = todoData.value as! [String:Any]
                        let item = TodoItem(json:itemSwD) // This could be nil
                        if item != nil {
                            todoItems.append(item!)
                        }
                        
                    }
                    completion(todoItems)
                }
            }else{ // It is not connected.
                self.retrieveDataOffline(completionDataOffline: { (offlineData:[TodoItem]) in
                    completion(offlineData)
                })
            }
        }
    }
    
    func checkIfConnectedToFirebase(completion: @escaping (_ result:Bool) -> Void) {
        var result: Bool = false
        let connectedRef = Database.database().reference(withPath: "todolistSwift")
        connectedRef.observe(.value, with: { snapshot in
            if ((snapshot.value as? [String: Any] ?? nil) != nil) {
                result = true
            } else {
                result = false
            }
            completion(result)
        })
    }
    
    
}
