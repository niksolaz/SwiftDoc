//
//  swiftDocViewControllerTableViewController.swift
//  swiftDoc
//
//  Created by Nicola Solazzo on 12/12/17.
//  Copyright © 2017 Nicola Solazzo. All rights reserved.
//

import UIKit
import Firebase
import WebKit

class swiftDocViewControllerTableViewController: UITableViewController {
    // SwiftDoc --> SwD
    var todoItemsSwD:[TodoItem] = []
    
    let ref: DatabaseReference =  Database.database().reference().child("todolistSwift")
    func firebaseParse() {
        
        ref.observe(.value) { (snapshot) in
            for item in snapshot.children {
                
               
                let todoData = item as! DataSnapshot
                
                let itemSwD = todoData.value as! [String:Any]
                
                let name:String = itemSwD["name"] as! String
                print(name)
                let notice:String = itemSwD["notice"] as! String
                print(notice)
                
                let list:Any = itemSwD["list"] as Any
                print(list)
                
                let todoSwD = TodoItem(name:name, notice:notice, list:list)
                print(todoSwD)
                self.todoItemsSwD.append(todoSwD)
            }
            self.tableView.reloadData()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
       firebaseParse()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return todoItemsSwD.count
    }

   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoListCell", for: indexPath)

        let todoSwD = todoItemsSwD[indexPath.row]
        cell.textLabel?.text = todoSwD.name
        
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "SwDDetail", sender: todoItemsSwD)
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "SwDDetail" {
            let vc = segue.destination
            if vc is SegueSwDTableViewController {
                vc.loadView()
            }
            
        }
    }
    
    

}
