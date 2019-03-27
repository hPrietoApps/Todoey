//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Heber Prieto on 3/5/19.
//  Copyright © 2019 Heber Prieto. All rights reserved.
//

import UIKit
import RealmSwift

class CategoryViewController: UITableViewController {

    let realm = try! Realm()
    
    var categoryArray : Results<Category>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadCategories()
        
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return categoryArray?.count ?? 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let categoryCell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        categoryCell.textLabel?.text = categoryArray?[indexPath.row].name ?? "No Category yet added"
        return categoryCell
    }
    
    // MARK: - Table view delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categoryArray?[indexPath.row]
        }
    }
    
    //IBAction
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var catEntered = UITextField()
        
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Add", style: .default, handler: { (action) in
            
            let newCat = Category()
            newCat.name = catEntered.text!
            self.saveCategory(category: newCat)
            
        }))
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create New Category"
            
            catEntered = alertTextField
        }
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func saveCategory(category : Category){
        do {
            try realm.write {
                realm.add(category)
            }
        } catch {
            print(error)
        }
        
        loadCategories()
    }
    
    func loadCategories() {
        
        categoryArray = realm.objects(Category.self)
        tableView.reloadData()
       
    }
}
