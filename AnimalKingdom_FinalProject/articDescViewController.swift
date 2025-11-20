//
//  articDescViewController.swift
//  AnimalKingdom_FinalProject
//
//  Created by Zaimone Miranda on 11/16/25.
//

import UIKit

//delcares the description view controller
//adopts UpdateDelegate fro the update screen and forward ipdates back to the previous screen
class articDescViewController: UIViewController, UpdateArticDelegate {
    
    //sendItem sends Animals object passed from the list
    var sendItem:Animals?
    
    //which index in the array is selected
    var selectedIndex: Int?
    
    //reference tot he controller that hosuld receive udpates callbacks
    weak var updateDelegate: UpdateArticDelegate?

    //UI elemnts in the storay to show the animal's data
    @IBOutlet weak var animalImage: UIImageView!
    @IBOutlet weak var animalName: UILabel!
    @IBOutlet weak var animalDesc: UILabel!
    @IBOutlet weak var animalType: UILabel!
    
    //ensures UI is refreshed whenever the view is about to appear
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        // Do any additional setup after loading the view.
    }
    
    //implementation fo UpdateDelegate sot his controller can receive updates from the update view
    func didUpdateAnimal(_ updatedAnimal: Animals, at index: Int) {
        
        //updaate its lcoal sendItem
        sendItem = updatedAnimal
        
        //refreshes the UI
        updateUI()
        
        //forward the update ot updateDelegate so the list screen can update model & UI
        updateDelegate?.didUpdateAnimal(updatedAnimal, at: index)
    }
    
    // sets labes and imafe from sendItem
    func updateUI(){
        animalName.text = sendItem?.name
        animalDesc.text = sendItem?.desc
        animalType.text = sendItem?.type
        if let imageName = sendItem?.imageFile {
                animalImage.image = UIImage(named: imageName)
            }
    }
    
    //ensures UI is refreshes whenever the view is about to appear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateUI()
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        // passes the current sendItem and selectedIndex so the update screen can edit them
        if segue.identifier == "UpdateArticSegue" {
            let updateVC = segue.destination as! UpdateArticTableViewController
            updateVC.animalToEdit = sendItem
            updateVC.indexToEdit = selectedIndex
            updateVC.delegate = self
        }
    }
    

}
