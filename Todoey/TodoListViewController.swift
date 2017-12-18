//
//  ViewController.swift
//  Todoey
//
//  Created by SL on 18/12/2017.
//  Copyright © 2017 Ofir Maler. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    let defualts = UserDefaults.standard
    var todoArray  = ["Find Mike", "Destroy the Demogorgon","Eleven"]
    override func viewDidLoad() {
        super.viewDidLoad()
       
        if let items = defualts.array(forKey: "TodoListItems") as? [String] {
            todoArray = items
        }
        tableView.reloadData()
        
    }
    
    
    
    
    
    //MARK - TableView DataSource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
            cell.textLabel?.text = todoArray[indexPath.row]
        return cell
    }
    
    
    //MARK - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if  tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }
        else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        
        
    }
    
    //MARK - Add items Todo list Methods
    

    @IBAction func addItemButton(_ sender: UIBarButtonItem) {
        
        
        var localTextField = UITextField()
        let alertController  = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //What will happens when the user click the add item
            print("Success")
            print(localTextField.text!)
            self.todoArray.append(localTextField.text!)
            self.defualts.set(self.todoArray, forKey: "TodoListItems")
            self.tableView.reloadData()
          
            
        }
        alertController.addTextField(configurationHandler: { (textField) in
            textField.placeholder = "Add new item"
            localTextField = textField
           
    
        })
        alertController.addAction(action)
        present(alertController, animated: true, completion: nil)
        
    }
}

