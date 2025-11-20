//
//  AddOceanTableViewController.swift
//  AnimalKingdom_FinalProject
//
//  Created by Zaimone Miranda on 11/17/25.
//

import UIKit

// Protocol definition that the add screen uses to tell another obeject that a new animal was created
// The corresponding `[BIOME]ViewController` (List Screen) conforms to this to receive the new model
protocol AddOceanDelegate: AnyObject {
    
    // Callback method invoked after a user saves a new animal
    // - Parameter animal: The newly created `Animals` object
    func didAddAnimal(_ animal: Animals)
}

class AddOceanTableViewController: UITableViewController {
    
    // Reference to the delegate (the List screen) that will receive the new animal model
    weak var delegate: AddOceanDelegate?
    
    
    @IBOutlet weak var nametxtfield: UITextField!
    @IBOutlet weak var desctxtview: UITextView!
    @IBOutlet weak var typetxtfield: UITextField!
    
    // Called once when the view is loaded into memory
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    // Handles the "Add" button tap to create and save a new animal
    @IBAction func btnAdd(_ sender: Any) {
        let trimname = nametxtfield.text ?? ""
        let name = trimname.trimmingCharacters(in: .whitespacesAndNewlines)
        let descri = desctxtview.text ?? ""
        let type = typetxtfield.text ?? ""
        
        // Input Validation: Check if any required field is empty
        if name.isEmpty || descri.isEmpty || type.isEmpty { return }
       
        // Get a list of all existing Arctic animal names, converted to lowercase for case-sensitive check
        let existingNames = AnimalData.shared.oceanAnimals.map { $0.name.lowercased() }
        
        // Check if the new name already exists in the list
        if existingNames.contains(name.lowercased()){
            
            // If duplicate is found, show an alert
            let alert = UIAlertController(
                title: "Duplicate Name",
                message: "An animal with this name already exists.",
                preferredStyle: .alert
            )
            
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
            
            // Clear the name field for the user to try again and stop execution
            nametxtfield.text = ""
            
            return
        }
        
        // Create the new `Animals` object. Uses a default placeholder image for new entries
        let newAnimal = Animals(
            type: type,
            name: name,
            desc: descri,
            imageFile: "app_logo2")
        
        // Notify the delegate (List screen) to add the new animal to the main array and save it
        delegate?.didAddAnimal(newAnimal)
        
        // Dismiss the current view controller and return to the List screen
        navigationController?.popViewController(animated: true)
        
    }
    
    // Clears all input fields (name, description, and type)
    @IBAction func btnClear(_ sender: Any) {
        nametxtfield.text = ""
        desctxtview.text = ""
        typetxtfield.text = ""
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
