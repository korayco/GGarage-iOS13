//
//  AppointmentViewController.swift
//  gersgarage
//
//  Created by taylanakbas on 14.08.2021.
//

import UIKit
import Firebase

class AppointmentViewController: UIViewController, UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    let db = Firestore.firestore()
    var appointments : [Appointment] = []

    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        // Do any additional setup after loading the view.
        getAppointments()
    }
    
    func getAppointments() {
        
        
        if let user = Auth.auth().currentUser {
            print(user.uid.description)
            db.collection("appointments").whereField("customer", isEqualTo: user.uid.description)
                .getDocuments() { (querySnapshot, err) in
                    if let err = err {
                        print("Error getting documents: \(err)")
                    } else {
                        if let snapshotDoc =  querySnapshot?.documents {
                            print(snapshotDoc)
                            for doc in snapshotDoc{
                                let documentData = doc.data()
                                let date = documentData["date"] as? String
                                let mechanic = documentData["mechanic"] as? String
                                let service = documentData["service"] as? String
                                let status = documentData["status"] as? String
                                let new = Appointment(customer: user.uid.description, date: date ?? "", mechanic: mechanic ?? "", service: service ?? "", status: status ?? "")
                                self.appointments.append(new)
                                DispatchQueue.main.async {
                                    self.tableView.reloadData()
                                }
                            }
                        }

                    }
            }
            

        }
        

    }
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return appointments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let appoinment = tableView.dequeueReusableCell(withIdentifier: "AppointmentCell") as! AppointmentTableViewCell
        
        var status_color = UIColor()
        if self.appointments[indexPath.row].status == "Booked" {
            status_color = (UIColor.orange)
        }else if self.appointments[indexPath.row].status == "In Service" {
            status_color = (UIColor.blue)
        }else if self.appointments[indexPath.row].status == "Completed" {
            status_color = (UIColor.green)
        }else if self.appointments[indexPath.row].status == "Unrepairable" {
            status_color = (UIColor.red)
        }
        
        appoinment.serviceType.text  = self.appointments[indexPath.row].service
        appoinment.serviceStatus.image = UIImage(systemName:"circle.dashed.inset.fill")
        appoinment.serviceStatus.tintColor = status_color
        appoinment.date.text = self.appointments[indexPath.row].date
        return appoinment
        

    }
    

    


}
