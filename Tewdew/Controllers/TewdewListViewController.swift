//
//  ViewController.swift
//  Tewdew
//
//  Created by David Davidov on 12/22/17.
//  Copyright © 2017 David Davidov. All rights reserved.
//

import UIKit
import RealmSwift

class TewdewListViewController: UITableViewController
{
    let realm = try! Realm()
    
    var items : Results<Items>?

    var selectedCategory : Category? {
        didSet{
            loadItems()
        }
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        loadItems()
        
    }

    //MARK: - Tableview Datasource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return items?.count ?? 1
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TewdewItemCell", for: indexPath)
        
        if let item = items?[indexPath.row]{
            
            cell.textLabel?.text = item.title
            
            if item.done == true{
                cell.accessoryType = .checkmark
            }else {
                cell.accessoryType = .none
            }
        } else {
            cell.textLabel?.text = "No New Items Added"
        }

        return cell
    }
    
    //MARK: - Tableview Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        if let item = items?[indexPath.row]{
            do{
                try realm.write {
                    item.done = !item.done
                }
            }catch{
                print("Error saving done status \(error)")
            }
        }
        tableView.reloadData()
    
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
   
    //MARK: - Add New Items
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem)
    {
        var textField = UITextField()
       
        let alert = UIAlertController(title: "Add New Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            //what happens when user clicks add item on UIAlert
           
            if let currentCategory = self.selectedCategory {
               
                do{
                    try self.realm.write {
                        
                        let newItems = Items()
                        
                        newItems.title = textField.text!
                        
                        currentCategory.items.append(newItems)
                    }
                
                }catch{
                    print("Error saving items, \(error)")
                }
            }
            self.tableView.reloadData()
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
    // MARK: - Loading

    func loadItems(){
        
        items = selectedCategory?.items.sorted(byKeyPath: "title", ascending: true)
        
        tableView.reloadData()
        
    }
}
//MARK: - Search Bar Methods
extension TewdewListViewController: UISearchBarDelegate{

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {

        items = items?.filter("title CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "title", ascending: true)
        
        
        
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            if searchBar.text?.count == 0{

                loadItems() //brings back original search results
            
                DispatchQueue.main.async {

                    searchBar.resignFirstResponder() //gets rid of keyboard and leaves the searchbar

                }

            }
    }
}
