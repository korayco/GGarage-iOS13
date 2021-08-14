//
//  RegisterViewController.swift
//  gersgarage
//
//  Created by taylanakbas on 14.08.2021.
//

import UIKit
import Firebase

class RegisterViewController: UIViewController {

    
    @IBOutlet var usernameTextField: UITextField!
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    
    let db = Firestore.firestore()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func isRegisterButtonPressed(_ sender: Any) {
        // 1
        guard
          let email = emailTextField.text,
          let password = passwordTextField.text,
          !email.isEmpty,
          !password.isEmpty
        else { return }

        // 2
        Auth.auth().createUser(withEmail: email, password: password) { _, error in
          // 3
          if error == nil {
            Auth.auth().signIn(withEmail: email, password: password)
            if let username = self.usernameTextField.text {
                self.db.collection("customers").addDocument(data: [
                    "name" : username,
                    "mail" : email,
                    "id" : Auth.auth().currentUser?.uid.description ?? ""
                ])
            
            }
            
            let homeViewController = self.storyboard?.instantiateViewController(withIdentifier: "HomeVCTabBar")
                self.view.window?.rootViewController = homeViewController
          
          } else {
            print("Error in createUser: \(error?.localizedDescription ?? "")")
          }
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
