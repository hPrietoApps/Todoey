//
//  ViewController.swift
//  Todoey
//
//  Created by Heber Prieto on 2/18/19.
//  Copyright © 2019 Heber Prieto. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    var itemArray = [String]()
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let items = defaults.array(forKey: "ToDoList") as? [String] {
            itemArray = items
        }


    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row]
        return cell
    }
    
    //TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.deselectRow(at: indexPath, animated: true)
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
        
    }
    // IBAction Connected elements
    
    @IBAction func addItemPressed(_ sender: UIBarButtonItem) {
        var itemEntered = UITextField()
        
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Add Item", style: .default, handler: { (action) in
            
            self.itemArray.append(itemEntered.text!)
            self.defaults.set(self.itemArray, forKey: "ToDoList")
            self.tableView.reloadData()
            
        }))
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
    
            itemEntered = alertTextField
            }
        
        self.present(alert, animated: true, completion: nil)
    }
    
}

