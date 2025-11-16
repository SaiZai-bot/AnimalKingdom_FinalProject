//
//  ForestViewController.swift
//  AnimalKingdom_FinalProject
//
//  Created by Zaimone Miranda on 11/16/25.
//

import UIKit

class ForestViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var txtField: UITextField!
    @IBOutlet weak var TableViewItem: UITableView!
    
    
    var Forest:[Animals] = [
        Animals(type: "Forest1", name: "Bear", desc: "Add later", imageFile: "bear"),
        Animals(type: "Forest2", name: "Fox", desc: "Add later", imageFile: "fox"),
        Animals(type: "Forest3", name: "Squirrel", desc: "Add later", imageFile: "squirrel")
    ]
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Forest.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "forest", for: indexPath)
        
        let animal = Forest[indexPath.row]
        cell.textLabel?.text = animal.name
        cell.imageView?.image = UIImage(named: Forest[indexPath.row].imageFile)
        
        return cell
    }
    
    @IBAction func btnAdd(_ sender: Any) {
        let name = txtField.text ?? ""
        if name.isEmpty { return }
        
        let newAnimal = Animals(
            type: "Forest",
            name: name,
            desc: "Add Later",
            imageFile: "Add Later")
        
        Forest.append(newAnimal)
        TableViewItem.reloadData()
        txtField.text = ""
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let vc = segue.destination as! ForestDescViewController
        if let indexPath = self.TableViewItem.indexPathForSelectedRow{
            let animal = Forest[indexPath.row]
            vc.sendItem = animal
        }
        
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }

}
