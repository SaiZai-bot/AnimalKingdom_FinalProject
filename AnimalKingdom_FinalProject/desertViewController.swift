//
//  desertViewController.swift
//  AnimalKingdom_FinalProject
//
//  Created by Zaimone Miranda on 11/16/25.
//

import UIKit

class desertViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var txtField: UITextField!
    @IBOutlet weak var tableViewItem: UITableView!
    
    var Desert:[Animals] = [
        Animals(type: "Desert1", name: "Camel", desc: "Add later", imageFile: "camel"),
        Animals(type: "Desert2", name: "Rattle Snake", desc: "Add later", imageFile: "rattlesnake"),
        Animals(type: "Desertt3", name: "Fennec Fox", desc: "Add later", imageFile: "fennecfox")
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnAdd(_ sender: Any) {
        let name = txtField.text ?? ""
        if name.isEmpty { return }
        
        let newAnimal = Animals(
            type: "Forest",
            name: name,
            desc: "Add Later",
            imageFile: "Add Later")
        
        Desert.append(newAnimal)
        tableViewItem.reloadData()
        txtField.text = ""
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
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        let vc = segue.destination as! DesertDescViewController
        if let indexPath = self.tableViewItem.indexPathForSelectedRow{
            let animal = Desert[indexPath.row]
            vc.sendItem = animal
        }
    }


}
