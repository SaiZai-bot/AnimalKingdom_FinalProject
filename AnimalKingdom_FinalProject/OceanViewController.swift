//
//  OceanViewController.swift
//  AnimalKingdom_FinalProject
//
//  Created by Zaimone Miranda on 11/16/25.
//

import UIKit

class OceanViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var txtField: UITextField!
    @IBOutlet weak var tableViewItem: UITableView!
    
    var Ocean:[Animals] = [
        Animals(type: "Ocean1", name: "Octopus", desc: "Add later", imageFile: "octopus"),
        Animals(type: "Ocean2", name: "Turtle", desc: "Add later", imageFile: "turtle"),
        Animals(type: "Ocean3", name: "Whale", desc: "Add later", imageFile: "whale")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

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

    @IBAction func btnAdd(_ sender: Any) {
        let name = txtField.text ?? ""
        if name.isEmpty { return }
        
        let newAnimal = Animals(
            type: "Ocean",
            name: name,
            desc: "Add Later",
            imageFile: "Add Later")
        
        Ocean.append(newAnimal)
        tableViewItem.reloadData()
        txtField.text = ""
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        let vc = segue.destination as! OceanDescViewController
        if let indexPath = self.tableViewItem.indexPathForSelectedRow{
            let animal = Ocean[indexPath.row]
            vc.sendItem = animal
        }
    }
    

}
