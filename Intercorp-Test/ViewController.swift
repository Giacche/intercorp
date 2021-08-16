//
//  ViewController.swift
//  Intercorp-Test
//
//  Created by Lucas Giacche on 15/08/2021.
//

import UIKit
import FBSDKLoginKit
import FirebaseAuth
import SVProgressHUD

class ViewController: UIViewController, LoginButtonDelegate {
    
    @IBOutlet weak var textToShow: UILabel!
    @IBOutlet weak var continueBtn: UIButton!

    @IBAction func continueBtnAction(_ sender: Any) {
        goToRegisterView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let loginButton = FBLoginButton()
        loginButton.delegate = self
        loginButton.center = view.center
        view.addSubview(loginButton)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        checkLoginStatus()
    }
    
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        SVProgressHUD.show()
        if let error = error {
            print("Error")
            SVProgressHUD.dismiss()
            return;
        }
            
        let credential = FacebookAuthProvider.credential(withAccessToken: AccessToken.current?.tokenString ?? "")
        Auth.auth().signIn(with: credential, completion: { (user, error) in
                
            if let error = error {
               print("Login error: \(error.localizedDescription)")
               let alertController = UIAlertController(title: "Login Error", message: error.localizedDescription, preferredStyle: .alert)
               let okayAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
               alertController.addAction(okayAction)
               self.present(alertController, animated: true, completion: nil)
    
               return
            }
            
            self.goToRegisterView()
        })
        SVProgressHUD.dismiss()
    }
        
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
        checkLoginStatus()
    }
    
    func goToRegisterView(){
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "UserFormViewController") as! UserFormViewController
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
    
    func checkLoginStatus(){
        if AccessToken.current != nil {
            textToShow.text = "Ya te has logueado con Facebook, puedes desloguearte o continuar a completar tu registro de Usuario"
            continueBtn.isHidden = false
        }
        else {
            textToShow.text = "Por favor logueate con Facebook para continuar"
            continueBtn.isHidden = true
        }
    }
}

