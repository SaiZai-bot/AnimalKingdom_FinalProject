//
//  articViewController.swift
//  AnimalKingdom_FinalProject
//
//  Created by Zaimone Miranda on 11/16/25.
//

import UIKit

//Declares the view controller class, inheriting UIViewController, UITableViewDelegate, UITableViewDataSource
// AddArticDelegate is a custom protocol so that Add Artic view can tell this view when a new animal was added
class articViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, AddArticDelegate {

    @IBOutlet weak var tableViewItem: UITableView!
    
    //declares artic array of animals
    //gets and sets the shared AnimalData.shared.articAnimals
    // keepss this controller's data tied to the single source the AnimalData
    var Artic:[Animals] {
        get { AnimalData.shared.arcticAnimals }
        set { AnimalData.shared.arcticAnimals = newValue }
    }
    
    //runs once when teh view loads
    // sets the table view's delegate and datasoruce to this view controller so the table methods are used
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableViewItem.delegate = self
        tableViewItem.dataSource = self

        // Do any additional setup after loading the view.
    }
    
    // outputs the number of rows based on the Artic array
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Artic.count
    }
    
    //uses the identifier artic view in the storyboard
    //animal fetches the mdoel for this row
    //sets the cell's text and image usine the Animal
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "artic", for: indexPath)
        
        let animal = Artic[indexPath.row]
        cell.textLabel?.text = animal.name
        cell.imageView?.image = UIImage(named: Artic[indexPath.row].imageFile)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            let alert = UIAlertController(
                title: "Delete Animal",
                message: "Are you sure you want to delete this animal?",
                preferredStyle: .alert
            )
            
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { _ in
                
                self.Artic.remove(at: indexPath.row)
                AnimalData.shared.saveArctic()
                tableView.deleteRows(at: [indexPath], with: .automatic)
            }))
            present(alert, animated: true, completion: nil)
        }
    }


    func didAddAnimal(_ animal: Animals) {
        Artic.append(animal)
        AnimalData.shared.saveArctic()
        tableViewItem.reloadData()
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        //if going to Add animal view it will set the controller as delegate so Add can call didAddAnimal
        if segue.identifier == "AddAnimalSegue" {
            let addVC = segue.destination as! AddArticTableViewController
            addVC.delegate = self
            
            //if going to decription pass the selected animal and index to the decription controller, and set updateDelegate so updates made in description screen can be sent back here
        } else if segue.identifier == "ShowForestDescSegue" {
            let descVC = segue.destination as! articDescViewController
            if let indexPath = tableViewItem.indexPathForSelectedRow {
                descVC.sendItem = Artic[indexPath.row]
                descVC.selectedIndex = indexPath.row
                descVC.updateDelegate = self
            }
        }
    }
}

//extension to conform to UpdateArticDelegate
extension articViewController: UpdateArticDelegate {
    
    // replaces the animal at the given index witht he udpated mnodel and reloads the table
    func didUpdateAnimal(_ updateAnimal: Animals, at index: Int){
        Artic[index] = updateAnimal
        
        //calling AnimalData after updating to persist changes
        AnimalData.shared.saveArctic()
        tableViewItem.reloadData()
    }
}

