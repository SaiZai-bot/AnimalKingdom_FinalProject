//
//  OceanDescViewController.swift
//  AnimalKingdom_FinalProject
//
//  Created by Zaimone Miranda on 11/16/25.
//

import UIKit

class OceanDescViewController: UIViewController, UpdateOceanDelegate {
    
    var sendItem:Animals?
    var selectedIndex: Int?
    weak var updateDelegate: UpdateOceanDelegate?
    
    @IBOutlet weak var animalImage: UIImageView!
    @IBOutlet weak var animalName: UILabel!
    @IBOutlet weak var animalDesc: UILabel!
    @IBOutlet weak var animalType: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        
        // Do any additional setup after loading the view.
    }
    
    func didUpdateAnimal(_ updatedAnimal: Animals, at index: Int) {
        sendItem = updatedAnimal
        updateUI()
        
        updateDelegate?.didUpdateAnimal(updatedAnimal, at: index)
    }

    func updateUI(){
        animalName.text = sendItem?.name
        animalDesc.text = sendItem?.desc
        animalType.text = sendItem?.type
        if let imageName = sendItem?.imageFile {
                animalImage.image = UIImage(named: imageName)
            }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateUI()
    }

    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "UpdateOceanSegue" {
            let updateVC = segue.destination as! UpdateOceanTableViewController
            updateVC.animalToEdit = sendItem
            updateVC.indexToEdit = selectedIndex
            updateVC.delegate = self
        }
    }

}
