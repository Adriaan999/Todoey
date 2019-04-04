//
//  CategoryTableViewController.swift
//  Todoey
//
//  Created by Adriaan on 2019/04/01.
//  Copyright © 2019 Adriaan. All rights reserved.
//

import UIKit
import RealmSwift
import ChameleonFramework

class CategoryTableViewController: SwipeTableViewController {
    let realm = try! Realm()
    var categories: Results<Category>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadCategories()
        tableView.separatorStyle = .none
    }

//MARK - TableView Datasource Methods
override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = super.tableView(tableView, cellForRowAt: indexPath)
    cell.textLabel?.text = categories?[indexPath.row].name ?? "No Categories added yet"
    if let colour = UIColor(hexString:categories?[indexPath.row].color ?? "1D9BF6") {
        cell.backgroundColor = colour
        cell.textLabel?.textColor = ContrastColorOf(colour, returnFlat: true)
    }
    return cell
}

override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return categories?.count ?? 1
}

override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    performSegue(withIdentifier: "goToItems", sender: self)
}

override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    let destinationViewController = segue.destination as! TodoListViewController
    if let indexPath = tableView.indexPathForSelectedRow {
        destinationViewController.selectedCategory = categories?[indexPath.row]
    }
}

@IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
    var textField = UITextField()
    let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
    
    let action = UIAlertAction(title: "Add", style: .default) { (action) in
        let newCategory = Category()
        newCategory.name = textField.text!
        newCategory.color = UIColor.randomFlat.hexValue()
        self.saveCategories(category: newCategory)
    }
    
    alert.addTextField { (alertTextField) in
        alertTextField.placeholder = "Add a new category"
        textField = alertTextField
    }
    alert.addAction(action)
    present(alert, animated: true, completion: nil)
}

func saveCategories(category: Category) {
    do {
        try realm.write {
            realm.add(category)
        }
    } catch {
        print("Error saving context, \(error)")
    }
    tableView.reloadData()
}

func loadCategories() {
    categories = realm.objects(Category.self)
    tableView.reloadData()
}

override func updateModel(at indexPath: IndexPath) {
    if let categoryForDeletion = categories?[indexPath.row] {
        do {
            try self.realm.write {
                self.realm.delete(categoryForDeletion)
            }
        } catch {
            print("Error deleting category, \(error)")
        }
    }
}
}
