//
//  UpdateArticTableViewController.swift
//  AnimalKingdom_FinalProject
//
//  Created by Zaimone Miranda on 11/17/25.
//

import UIKit

protocol UpdateArticDelegate: AnyObject {
    func didUpdateAnimal(_ animal: Animals, at index: Int)
}

class UpdateArticTableViewController: UITableViewController {
    
    
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtDesc: UITextView!
    @IBOutlet weak var txtType: UITextField!
    
    weak var delegate: UpdateArticDelegate?
    var animalToEdit: Animals?
    var indexToEdit: Int?
    
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
    
    @IBAction func btnSave(_ sender: Any) {
        guard let index = indexToEdit else {return}
        
        let updated = Animals (
            type: txtType.text ?? "",
            name: txtName.text ?? "",
            desc: txtDesc.text ?? "",
            imageFile: animalToEdit?.imageFile ?? "bear")
        
        delegate?.didUpdateAnimal(updated, at: index)
        navigationController?.popViewController(animated: true)
    }
    
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
