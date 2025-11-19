//
//  articViewController.swift
//  AnimalKingdom_FinalProject
//
//  Created by Zaimone Miranda on 11/16/25.
//

import UIKit

class articViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, AddArticDelegate {


    @IBOutlet weak var tableViewItem: UITableView!
    
    var Artic:[Animals] {
        get { AnimalData.shared.arcticAnimals }
        set { AnimalData.shared.arcticAnimals = newValue }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableViewItem.delegate = self
        tableViewItem.dataSource = self

        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Artic.count
    }
    
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
        if segue.identifier == "AddAnimalSegue" {
            let addVC = segue.destination as! AddArticTableViewController
            addVC.delegate = self
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

extension articViewController: UpdateArticDelegate {
    func didUpdateAnimal(_ updateAnimal: Animals, at index: Int){
        Artic[index] = updateAnimal
        AnimalData.shared.saveArctic()
        tableViewItem.reloadData()
    }
}

