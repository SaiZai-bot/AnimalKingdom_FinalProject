//
//  desertViewController.swift
//  AnimalKingdom_FinalProject
//
//  Created by Zaimone Miranda on 11/16/25.
//

import UIKit

class desertViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, AddDesertDelegate {
    
    @IBOutlet weak var txtField: UITextField!
    @IBOutlet weak var tableViewItem: UITableView!
    
    var Desert:[Animals] {
        get { AnimalData.shared.desertAnimals }
        set { AnimalData.shared.desertAnimals = newValue }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableViewItem.delegate = self
        tableViewItem.dataSource = self

        // Do any additional setup after loading the view.
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Desert.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "desert", for: indexPath)
        
        let animal = Desert[indexPath.row]
        cell.textLabel?.text = animal.name
        cell.imageView?.image = UIImage(named: Desert[indexPath.row].imageFile)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            Desert.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    func didAddAnimal(_ animal: Animals) {
        Desert.append(animal)
        tableViewItem.reloadData()
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "AddAnimalSegue" {
            let addVC = segue.destination as! AddDesertTableViewController
            addVC.delegate = self
        } else if segue.identifier == "ShowDesertDescSegue" {
            let descVC = segue.destination as! DesertDescViewController
            if let indexPath = tableViewItem.indexPathForSelectedRow {
                descVC.sendItem = Desert[indexPath.row]
                descVC.selectedIndex = indexPath.row
                descVC.updateDelegate = self
            }
        }
    }


}

extension desertViewController: UpdateDesertDelegate {
    func didUpdateAnimal(_ updateAnimal: Animals, at index: Int){
        Desert[index] = updateAnimal
        tableViewItem.reloadData()
    }
}
