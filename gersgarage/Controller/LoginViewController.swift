//
//  LoginViewController.swift
//  gersgarage
//
//  Created by taylanakbas on 14.08.2021.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {

    @IBOutlet var usernameTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        usernameTextField.text = "koraycosar@gmail.com"
        passwordTextField.text = "8d86afe5"

        // Do any additional setup after loading the view.
    }
    
    @IBAction func loginPressed(_ sender: Any) {
        if let username = usernameTextField.text, let psw = passwordTextField.text {
                   Auth.auth().signIn(withEmail: username, password: psw) { authResult, error in
                       if let e = error {
                        print(e)
   
                       }else{
                        let homeViewController = self.storyboard?.instantiateViewController(withIdentifier: "HomeVCTabBar")
                            self.view.window?.rootViewController = homeViewController

                       }
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
