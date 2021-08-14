//
//  ProfileViewController.swift
//  gersgarage
//
//  Created by taylanakbas on 15.08.2021.
//

import UIKit
import Firebase
class ProfileViewController: UIViewController {

    @IBOutlet var nameLabel: UILabel!
    let db = Firestore.firestore()

    override func viewDidLoad() {
        super.viewDidLoad()
        if let user = Auth.auth().currentUser {
            db.collection("customers").whereField("id", isEqualTo: user.uid.description).getDocuments() { (querySnapshot, err) in
                if let e = err {
                    print(e)
                }
                else {
                    self.nameLabel.text = ""
                    for doc in querySnapshot!.documents {
                        let data = doc.data()
                        if let name = data["name"] as? String{
                            self.nameLabel.text = name
                        }
                        
                        }
                    }
            }
        }

        
        // Do any additional setup after loading the view.
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
