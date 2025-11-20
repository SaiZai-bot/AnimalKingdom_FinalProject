//
//  articDescViewController.swift
//  AnimalKingdom_FinalProject
//
//  Created by Zaimone Miranda on 11/16/25.
//

import UIKit

// Delcares the description view controller
// Adopts UpdateDelegate fro the update screen and forward ipdates back to the previous screen
class articDescViewController: UIViewController, UpdateArticDelegate {
    
    // sendItem sends Animals object passed from the list
    var sendItem:Animals?
    
    // Which index in the array is selected
    var selectedIndex: Int?
    
    // Reference tot he controller that hosuld receive udpates callbacks
    weak var updateDelegate: UpdateArticDelegate?

    // UI elemnts in the storay to show the animal's data
    @IBOutlet weak var animalImage: UIImageView!
    @IBOutlet weak var animalName: UILabel!
    @IBOutlet weak var animalDesc: UILabel!
    @IBOutlet weak var animalType: UILabel!
    
    // Ensures UI is refreshed whenever the view is about to appear
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        // Do any additional setup after loading the view.
    }
    
    // Implementation fo UpdateDelegate sot his controller can receive updates from the update view
    func didUpdateAnimal(_ updatedAnimal: Animals, at index: Int) {
        
        // Update its local sendItem
        sendItem = updatedAnimal
        
        // Refreshes the UI
        updateUI()
        
        // Forward the update ot updateDelegate so the list screen can update model & UI
        updateDelegate?.didUpdateAnimal(updatedAnimal, at: index)
    }
    
    // Sets labels and imafe from sendItem
    func updateUI(){
        animalName.text = sendItem?.name
        animalDesc.text = sendItem?.desc
        animalType.text = sendItem?.type
        if let imageName = sendItem?.imageFile {
                animalImage.image = UIImage(named: imageName)
            }
    }
    
    // Ensures UI is refreshes whenever the view is about to appear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateUI()
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        // Passes the current sendItem and selectedIndex so the update screen can edit them
        if segue.identifier == "UpdateArticSegue" {
            let updateVC = segue.destination as! UpdateArticTableViewController
            updateVC.animalToEdit = sendItem
            updateVC.indexToEdit = selectedIndex
            updateVC.delegate = self
        }
    }
    

}
