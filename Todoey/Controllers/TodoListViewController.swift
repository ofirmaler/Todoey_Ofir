//
//  ViewController.swift
//  Todoey
//
//  Created by SL on 18/12/2017.
//  Copyright © 2017 Ofir Maler. All rights reserved.
//

import UIKit
import CoreData

class TodoListViewController: UITableViewController {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var filePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")

    var itemArray = [Item]()
    
    var selectedCategory : Category? {
        didSet {
            loadItems()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        
        tableView.reloadData()
    }
    
    
    
    
    
    //MARK - TableView DataSource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row].title
        
        let item = itemArray[indexPath.row]
        
        cell.accessoryType = item.done ? .checkmark : .none
        
    return cell
        
    }
    
    
    //MARK - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        

//        context.delete(itemArray[indexPath.row])
//        itemArray.remove(at: indexPath.row)
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
    
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        saveItems()
        
        
    }
    
    //MARK - Add items Todo list Methods
    

    @IBAction func addItemButton(_ sender: UIBarButtonItem) {
        
        
        var localTextField = UITextField()
        let alertController  = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //What will happens when the user click the add item
            print("Success")
            
            let item = Item(context: self.context)
            item.title = localTextField.text!
            item.done = false
            item.parentCategory = self.selectedCategory
            self.itemArray.append(item)
           
            self.saveItems()
          
          
            
        }
        alertController.addTextField(configurationHandler: { (textField) in
            textField.placeholder = "Add new item"
            localTextField = textField
           
    
        })
        alertController.addAction(action)
        present(alertController, animated: true, completion: nil)
        
    }
    
    func saveItems() {
        do {
            
        try context.save()
            
        } catch {
            print("Error saving item : \(error)")
        }
        self.tableView.reloadData()
        
    }
    
    func loadItems(with request : NSFetchRequest<Item> = Item.fetchRequest(), predicate : NSPredicate? = nil) {
//        let request : NSFetchRequest<Item> = Item.fetchRequest()
        do {
            let categoryPredicate = NSPredicate(format: "parentCategory.name MATCHES %@", selectedCategory!.name!)
            if let additionalPredicate = predicate {
                
                let compoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate, additionalPredicate])
                request.predicate = compoundPredicate
            } else {
                request.predicate = categoryPredicate
            }

            itemArray =  try context.fetch(request)
            print("Success fetching items")
        } catch {
            print("Error fetching the requested items \(error)")
        }
        
        tableView.reloadData()
    }
}

extension TodoListViewController : UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        let request : NSFetchRequest<Item> = Item.fetchRequest()
        
        let predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
        
        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        
        loadItems(with: request, predicate: predicate)

        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            
            self.loadItems()
            
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        }
    }
    
}

