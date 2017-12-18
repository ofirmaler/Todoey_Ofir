//
//  ViewController.swift
//  Todoey
//
//  Created by SL on 18/12/2017.
//  Copyright © 2017 Ofir Maler. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    
    var todoArray  = ["Find Mike", "Destroy the Demogorgon","Eleven"]
    override func viewDidLoad() {
        super.viewDidLoad()
       
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
    

}

