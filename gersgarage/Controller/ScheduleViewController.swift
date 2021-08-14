//
//  ScheduleViewController.swift
//  gersgarage
//
//  Created by taylanakbas on 14.08.2021.
//

import UIKit
import Firebase

class ScheduleViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBOutlet var serviceName: UIPickerView!
    @IBOutlet var scheduleDate: UIDatePicker!
    @IBOutlet var comments: UITextField!
    
    let db = Firestore.firestore()
    var services : [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        serviceName.delegate = self
        serviceName.dataSource = self
        
        getServices()

        // Do any additional setup after loading the view.
    }
    
    func getServices(){
        
        db.collection("services")
            .getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    if let snapshotDoc =  querySnapshot?.documents {
                        for doc in snapshotDoc{
                            let documentData = doc.data()
                            let name = documentData["name"] as? String
                            self.services.append(name ?? "" )
                            self.serviceName.reloadComponent(0)
                        }
                    }
        
                    }
            }
        print(services)
    }
    
    @IBAction func confirmButtonPressed(_ sender: Any) {
        
        let dateFormatter = DateFormatter()

        // Set Date Format
        dateFormatter.dateFormat = "dd/MM/yyyy"

        
        let service = services[serviceName.selectedRow(inComponent: 0)]
        let date = dateFormatter.string(from: scheduleDate.date)
            
        let comments = self.comments.text
        let id = Auth.auth().currentUser?.uid
        self.db.collection("appointments").addDocument(data: [
            "customer" : id ?? "",
            "date" : date,
            "service" :service,
            "comments": comments ?? "",
            "status": "Booked"
        
        ])
        let homeViewController = self.storyboard?.instantiateViewController(withIdentifier: "HomeVCTabBar")
            self.view.window?.rootViewController = homeViewController
            
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        services.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return services[row]
       }
                
    


}
