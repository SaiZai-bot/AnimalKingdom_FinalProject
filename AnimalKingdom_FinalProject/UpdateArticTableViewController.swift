//
//  UpdateArticTableViewController.swift
//  AnimalKingdom_FinalProject
//
//  Created by Zaimone Miranda on 11/17/25.
//

import UIKit

// Protocol for communicating that an animal has been successfully updated
// Their corresponding '[BIOME]DescViewController' conforms to this to receive the updated model
protocol UpdateArticDelegate: AnyObject {
    
    // Callback metho invoked after a user saves changes to an animal
    // Animals object wiht the edited data
    // The original index of the animal in the array
    func didUpdateAnimal(_ animal: Animals, at index: Int)
}

class UpdateArticTableViewController: UITableViewController {
    
    
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtDesc: UITextView!
    @IBOutlet weak var txtType: UITextField!
    
    // Reference to the delegate (Description view) that will receive the updated animal model
    weak var delegate: UpdateArticDelegate?
    
    // The original 'Animals' object passed from the previous screen, used to pre-fill fields
    var animalToEdit: Animals?
    
    // The index of the animal in the main data array, needed for the delegate callback
    var indexToEdit: Int?
    
    // Called once when the view is loaded into memory
    override func viewDidLoad() {
        super.viewDidLoad()
        txtName.text = animalToEdit?.name
        txtDesc.text = animalToEdit?.desc
        txtType.text = animalToEdit?.type

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    // Handles the "Save" button to validate and commit changes
    @IBAction func btnSave(_ sender: Any) {
        
        // Ensure the index to edit is available. If not, stop the save process
        guard let index = indexToEdit else {return}
        
        // Get the new name, trim whitespace, and default to an empty string if nil
        let newName = txtName.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        
        // Get all animals in the Arctic array, except the one currently being edited
        let otherAnimals = AnimalData.shared.arcticAnimals.enumerated().filter { $0.offset != index }
        
        // Extract and lowercase the names of all 'other' animals for comparison
        let nameList = otherAnimals.map{ $0.element.name.lowercased() }
        
        // Check if the new name (case-insensitive) already exists among the other animals
        if nameList.contains(newName.lowercased()){
            
            // If duplicate is found, show an alert to the user
            let alert = UIAlertController(
                title: "Duplicate Name",
                message: "Another animal already has this name.",
                preferredStyle: .alert
            )
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
            
            // Clear the name field and stop execution
            txtName.text = ""
            return
        }
        
        // Create a new `Animals` object using the updated text field values
        let updated = Animals (
            type: txtType.text ?? "",
            name: txtName.text ?? "",
            desc: txtDesc.text ?? "",
            
            // Retain the original image file name as images are not changed here
            imageFile: animalToEdit?.imageFile ?? "bear")
        
        // Notify the delegate (Description screen) that the animal has been updated
        delegate?.didUpdateAnimal(updated, at: index)
        
        // Dismiss the current view controller and return to the Description screen
        navigationController?.popViewController(animated: true)
    }
    
    // Clears all input fields (name, description, and type)
    @IBAction func btnClear(_ sender: Any) {
        txtName.text = ""
        txtDesc.text = ""
        txtType.text = ""
    }
    
    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return 0
//    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
