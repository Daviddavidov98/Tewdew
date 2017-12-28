//
//  CategoryViewController.swift
//  Tewdew
//
//  Created by David Davidov on 12/26/17.
//  Copyright © 2017 David Davidov. All rights reserved.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController {

    var categoryArray = [Category]()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadItems()
    
    }
    
    //MARK: - TableView Datasource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return categoryArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        let item = categoryArray[indexPath.row]
        
        cell.textLabel?.text = item.name
        
        return cell
    }
    
    //MARK: - Data Manipulation Methods
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem)
    {
        
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            //what happens when user clicks add category on UIAlert
            
            let newItems = Category(context: self.context)
            newItems.name = textField.text!
            
            self.categoryArray.append(newItems)
            
            self.saveItems()
            
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new category"
            textField = alertTextField
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    //MARK: - Saving and Loading
    func saveItems(){
        do{
            try context.save()
        }catch{
            print("Error saving data: \(error)")
        }
        tableView.reloadData()
    }
    func loadItems(with request: NSFetchRequest<Category> = Category.fetchRequest()){
        
        do{
            categoryArray = try context.fetch(request)
        }catch{
            print("Error fetching items \(error)")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TewdewListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow{
            
            destinationVC.selectedCategory = categoryArray[indexPath.row]
            
        }
    }
    
    
    //MARK: - TableView Delagate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        performSegue(withIdentifier: "goToItems", sender: self)
    }

    
}
