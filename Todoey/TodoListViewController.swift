//
//  ViewController.swift
//  Todoey
//
//  Created by Heber Prieto on 2/18/19.
//  Copyright © 2019 Heber Prieto. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    var itemArray = [Item]()
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("ItemList")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadItems()
        
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row].title
        
        cell.accessoryType = itemArray[indexPath.row].done ? .checkmark : .none
        
        return cell
    }
    
    //TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done

        self.saveData()
    }
    // IBAction Connected elements
    
    @IBAction func addItemPressed(_ sender: UIBarButtonItem) {
        var itemEntered = UITextField()
        
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Add Item", style: .default, handler: { (action) in
            
            let newItem = Item()
            newItem.title = itemEntered.text!
            self.itemArray.append(newItem)
            self.saveData()
        }))
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
    
            itemEntered = alertTextField
            }
        
        self.present(alert, animated: true, completion: nil)
    }
    func saveData(){
        let encoder = PropertyListEncoder()
        
        do {
            let data = try encoder.encode(itemArray)
            try data.write(to: dataFilePath!)
            
        } catch {
            print(error)
        }
        self.tableView.reloadData()
    }
    func loadItems() {
        if let data = try? Data(contentsOf: dataFilePath!) {
            let decoder = PropertyListDecoder()
            do {
            itemArray = try decoder.decode([Item].self, from: data)
            } catch {
                print("Some Error \(error)")
            }
        }
    }
}

