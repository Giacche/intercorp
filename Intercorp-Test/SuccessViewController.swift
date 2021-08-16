//
//  SuccessViewController.swift
//  Intercorp-Test
//
//  Created by Lucas Giacche on 15/08/2021.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class SuccessViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var lastNameLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var birthdayLabel: UILabel!
    
    //Firebase RealTimeDataBase
    var ref: DatabaseReference!
    var values: NSDictionary!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        
        getUserData()
    }
    
    
    func getUserData(){
        let userID = Auth.auth().currentUser!.uid
        self.ref.child("users/\(userID)").getData { (error, snapshot) in
            if let error = error {
                print("Error getting data \(error)")
            }
            else if snapshot.exists() {
                print("Got data \(snapshot.value!)")
                self.values = snapshot.value as? NSDictionary
                DispatchQueue.main.async { [self] in
                    if(values != nil){
                        self.nameLabel.text = "Nombre: \(values!["userName"] as? String ?? "")"
                        self.lastNameLabel.text = "Apellido: \(values!["userLastName"] as? String ?? "")"
                        self.ageLabel.text = "Edad: \(values!["userAge"] as? String ?? "")"
                        self.birthdayLabel.text = "Fecha de nacimiento: \(values!["userDateOfBirth"] as? String ?? "")"
                    }
                }
            }
            else {
                print("No data available")
            }
        }
        
        
            
    }

}
