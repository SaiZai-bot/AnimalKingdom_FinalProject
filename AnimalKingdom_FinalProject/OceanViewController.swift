//
//  OceanViewController.swift
//  AnimalKingdom_FinalProject
//
//  Created by Zaimone Miranda on 11/16/25.
//

import UIKit

class OceanViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, AddOceanDelegate {
    
    
    @IBOutlet weak var txtField: UITextField!
    @IBOutlet weak var tableViewItem: UITableView!
    
    var Ocean:[Animals]{
        get { AnimalData.shared.oceanAnimals }
        set { AnimalData.shared.oceanAnimals = newValue }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableViewItem.delegate = self
        tableViewItem.dataSource = self
        
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Ocean.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ocean", for: indexPath)
        
        let animal = Ocean[indexPath.row]
        cell.textLabel?.text = animal.name
        cell.imageView?.image = UIImage(named: Ocean[indexPath.row].imageFile)
        
        return cell
    }
    
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            Ocean.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    func didAddAnimal(_ animal: Animals) {
        Ocean.append(animal)
        tableViewItem.reloadData()
    }
    
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "AddAnimalSegue" {
            let addVC = segue.destination as! AddOceanTableViewController
            addVC.delegate = self
        } else if segue.identifier == "ShowOceanDescSegue" {
            let descVC = segue.destination as! OceanDescViewController
            if let indexPath = tableViewItem.indexPathForSelectedRow {
                descVC.sendItem = Ocean[indexPath.row]
                descVC.selectedIndex = indexPath.row
                descVC.updateDelegate = self
            }
        }
    }
}

extension OceanViewController: UpdateOceanDelegate {
    func didUpdateAnimal(_ updateAnimal: Animals, at index: Int){
        Ocean[index] = updateAnimal
        tableViewItem.reloadData()
    }
}
