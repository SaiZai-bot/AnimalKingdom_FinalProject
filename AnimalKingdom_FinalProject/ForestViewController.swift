//
//  ForestViewController.swift
//  AnimalKingdom_FinalProject
//
//  Created by Zaimone Miranda on 11/16/25.
//

import UIKit

// Declares the view controller class, inheriting UIViewController, UITableViewDelegate, UITableViewDataSource
// AddArticDelegate is a custom protocol so that Add Forest view can tell this view when a new animal was added
class ForestViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, AddForestDelegate {
    
    @IBOutlet weak var TableViewItem: UITableView!
    
    // Declares artic array of animals
    // Gets and sets the shared AnimalData.shared.forestAnimals
    // Keepss this controller's data tied to the single source the AnimalData
    var Forest:[Animals] {
        get { AnimalData.shared.forestAnimals }
        set { AnimalData.shared.forestAnimals = newValue }
    }
    
    
    // Outputs the number of rows based on the Artic array
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Forest.count
    }
    
    // Uses the identifier artic view in the storyboard
    // Animal fetches the mdoel for this row
    // Sets the cell's text and image usine the Animal
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "forest", for: indexPath)
        
        let animal = Forest[indexPath.row]
        cell.textLabel?.text = animal.name
        cell.imageView?.image = UIImage(named: Forest[indexPath.row].imageFile)
        
        return cell
    }
    
    
    // Enables swipe-to-delete functionality for table view rows
    // Adds alert messages for deletion confirmation
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            
            // Create and present an alert controller to confirm the delection action
            let alert = UIAlertController(
                title: "Delete Animal",
                message: "Are you sure you want to delete this animal?",
                preferredStyle: .alert
            )
            
            // Action to cancel or confirm deletion
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { _ in
                
                // Confirmed deletion remove the animal from the local data array
                // Update array to UserDefaults via the Singleton AnimalData
                // Animate the deletion of the corresponding row in the table view
                self.Forest.remove(at: indexPath.row)
                AnimalData.shared.saveForest()
                tableView.deleteRows(at: [indexPath], with: .automatic)
            }))
            present(alert, animated: true, completion: nil)
        }
    }
    
    
    // Delegate method called by their corresponding 'Add[BIOME]TableViewController' when a new animal is saved
    // Parameter animal: the newly created Animals object
    func didAddAnimal(_ animal: Animals) {
        
        // Append new animal to the corresponding array (triggers the computer setter)
        // Save the updated list to persistent storage
        // Refresh the table view to display the new added item
        Forest.append(animal)
        AnimalData.shared.saveForest()
        TableViewItem.reloadData()
    }
    
    
    // Runs once when teh view loads
    // Sets the table view's delegate and datasoruce to this view controller so the table methods are used
    override func viewDidLoad() {
        super.viewDidLoad()
        
        TableViewItem.delegate = self
        TableViewItem.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    
    // Prepates for a sqgue by passing data or setting delegates on the destination view controller
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // If going to Add animal view it will set the controller as delegate so Add can call didAddAnimal
        if segue.identifier == "AddAnimalSegue" {
            let addVC = segue.destination as! AddForestTableViewController
            addVC.delegate = self
            
            //if going to decription pass the selected animal and index to the decription controller, and set updateDelegate so updates made in description screen can be sent back here
        } else if segue.identifier == "ShowForestDescSegue" {
            let descVC = segue.destination as! ForestDescViewController
            if let indexPath = TableViewItem.indexPathForSelectedRow {
                descVC.sendItem = Forest[indexPath.row]
                descVC.selectedIndex = indexPath.row
                descVC.updateDelegate = self
            }
        }
    }
}

// Extension to conform to corresponding Update[BIOME]Delegate
extension ForestViewController: UpdateForestDelegate {
    
    // Replaces the animal at the given index witht he udpated mnodel and reloads the table
    func didUpdateAnimal(_ updateAnimal: Animals, at index: Int){
        Forest[index] = updateAnimal
        
        // Calling AnimalData after updating to persist changes
        // Refresh the table view to show the updated information
        AnimalData.shared.saveForest()
        TableViewItem.reloadData()
    }
}
