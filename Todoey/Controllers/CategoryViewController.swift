//
//  CategoryViewController.swift
//  Todoey
//
//  Created by SL on 19/12/2017.
//  Copyright © 2017 Ofir Maler. All rights reserved.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController {
//    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var categoryArray = [Category]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        let test = appDelegate.persistentContainer.viewContext
        loadItems()
        tableView.reloadData()
    }

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var localTextfield = UITextField()
        
        let alertController = UIAlertController(title: "Add New Section", message: "", preferredStyle: .alert)
        
        let alertAction = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //here we will handle user button press
            let newCategory = Category(context : self.context)
            newCategory.name = localTextfield.text
            self.categoryArray.append(newCategory)
            self.saveItems()
            self.tableView.reloadData()
            
            
        }
        alertController.addTextField { (textfield) in
            localTextfield = textfield
            localTextfield.placeholder = "Add new item "
        }
        alertController.addAction(alertAction)
        
        present(alertController, animated: true,completion:  nil)
    }
    //MARK - Segue methods

    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let destinationSegue = segue.destination as! TodoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
                destinationSegue.selectedCategory = categoryArray[indexPath.row]
        }
    }
    
    
    
    //MARK - Table view delegate methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return categoryArray.count
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell", for: indexPath)
        
        cell.textLabel?.text = categoryArray[indexPath.row].name
        
        return cell
    }
    
    //MARK - Core data Methods
    
    func saveItems () {
        do {
        try context.save()
        } catch {
            print("Failed to save item \(error)")
        }
    }
    
    func loadItems() {
        let request : NSFetchRequest<Category> = Category.fetchRequest()
        
        do {
            print("inside loadItems")
            categoryArray = try context.fetch(request)
            print(categoryArray.count)
        } catch {
            print("Error fetching requested items \(error)")
        }
        tableView.reloadData()
    }
    
}
