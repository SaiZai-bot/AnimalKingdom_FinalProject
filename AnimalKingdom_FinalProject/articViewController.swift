//
//  articViewController.swift
//  AnimalKingdom_FinalProject
//
//  Created by Zaimone Miranda on 11/16/25.
//

import UIKit

class articViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {


    @IBOutlet weak var txtField: UITextField!
    @IBOutlet weak var tableViewItem: UITableView!
    
    var Artic:[Animals] = [
        Animals(type: "Artic1", name: "Artic Bear", desc: "Add later", imageFile: "articbear"),
        Animals(type: "Artic2", name: "Artic Fox", desc: "Add later", imageFile: "articfox"),
        Animals(type: "Artic3", name: "Walrus", desc: "Add later", imageFile: "walrus")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

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

    @IBAction func btnAdd(_ sender: Any) {
        let name = txtField.text ?? ""
        if name.isEmpty { return }
        
        let newAnimal = Animals(
            type: "Forest",
            name: name,
            desc: "Add Later",
            imageFile: "Add Later")
        
        Artic.append(newAnimal)
        tableViewItem.reloadData()
        txtField.text = ""
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        let vc = segue.destination as! articDescViewController
        if let indexPath = self.tableViewItem.indexPathForSelectedRow{
            let animal = Artic[indexPath.row]
            vc.sendItem = animal
        }
        
    }
    

}
