//
//  DetailViewController.swift
//  swiftDoc
//
//  Created by Domenico Solazzo on 1/1/18.
//  Copyright © 2018 Nicola Solazzo. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var itemName: UILabel!
    @IBOutlet weak var itemNotice: UILabel!
    @IBOutlet weak var iitemTopics: UITableView!
    var todoItem:TodoItem?
    var items: [TodoItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = self.todoItem?.name ?? ""
        self.items = todoItem?.items ?? []
        self.itemName.text = self.todoItem?.name
        self.itemNotice.text = self.todoItem?.notice
        
        self.checkIfYouHaveItems()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.checkIfYouHaveItems()
    }
    
    func checkIfYouHaveItems(){
        if(self.items.count <= 0){
            self.iitemTopics.isHidden = true
        }else{
            self.iitemTopics.isHidden = false
        }
    }
   

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "todoItemCell", for: indexPath)
        
        let todoSwD = self.items[indexPath.row]
        cell.textLabel?.text = todoSwD.name
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "followingItemSegue" {
            //let navigationController = segue.destination as! UINavigationController
            //let vc = segue.destination as! SegueSwDTableViewController
            if let detailVC = segue.destination as? DetailViewController {
                let row = iitemTopics.indexPathForSelectedRow!.row
                detailVC.todoItem = self.items[row]
            }
            
        }
    }

}
