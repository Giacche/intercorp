//
//  UserFormViewController.swift
//  Intercorp-Test
//
//  Created by Lucas Giacche on 15/08/2021.
//

import UIKit
import FBSDKLoginKit
import FirebaseDatabase
import FirebaseAuth

class UserFormViewController: UIViewController {
    
    @IBOutlet weak var nameInput: UITextField!
    @IBOutlet weak var lastNameInput: UITextField!
    @IBOutlet weak var ageInput: UITextField!
    @IBOutlet weak var dateInput: UITextField!
    @IBOutlet weak var registerBtn: UIButton!
    
    @IBAction func registerAction(_ sender: Any) {
        if(!nameInput.text!.isEmpty && !lastNameInput.text!.isEmpty && !ageInput.text!.isEmpty && !dateInput.text!.isEmpty){
            let newUser = User(userFirstName: nameInput.text ?? "", userLastName: lastNameInput.text ?? "", userAge: ageInput.text ?? "", userDateBirth: dateInput.text ?? "")
            saveUserInDataBase(newUser)
        }else{
            let alert = UIAlertController(title: "Atención", message: "Todo los campos deben ser completados", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    var datePicker :UIDatePicker!
    
    //Firebase RealTimeDataBase
    var ref: DatabaseReference!

    override func viewDidLoad() {
        super.viewDidLoad()
        datePicker = UIDatePicker.init(frame: CGRect(x: 0, y: 0, width: view.bounds.size.width, height: 200))
        datePicker.addTarget(self, action: #selector(self.dateChanged), for: .allEvents)
        datePicker.datePickerMode = UIDatePicker.Mode.date
        dateInput.inputView = datePicker
        let doneButton = UIBarButtonItem.init(title: "Hecho", style: .done, target: self, action: #selector(self.datePickerDone))
        let toolBar = UIToolbar.init(frame: CGRect(x: 0, y: 0, width: view.bounds.size.width, height: 44))
        toolBar.setItems([UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil), doneButton], animated: true)
        dateInput.inputAccessoryView = toolBar
        
        ref = Database.database().reference()
        
        self.nameInput.delegate = self
        self.lastNameInput.delegate = self
        self.ageInput.delegate = self
        self.dateInput.delegate = self
    }
    
    @objc func datePickerDone() {
        dateInput.resignFirstResponder()
    }

    @objc func dateChanged() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMMM yyyy"
        dateInput.text = "\(dateFormatter.string(from: datePicker.date))"
    }
    
    func saveUserInDataBase(_ user: User){
        let userID = Auth.auth().currentUser!.uid
        self.ref.child("users/\(userID)").setValue(["userName": user.userFirstName, "userLastName": user.userLastName, "userAge": user.userAge, "userDateOfBirth": user.userDateBirth])
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "SuccessViewController") as! SuccessViewController
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }

}

extension UserFormViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
            case nameInput:
                lastNameInput.becomeFirstResponder()
            case lastNameInput:
                ageInput.becomeFirstResponder()
            case ageInput:
                dateInput.becomeFirstResponder()
            default:
                dateInput.resignFirstResponder()
            }

            return true
    }
}
