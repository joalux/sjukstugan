//
//  profileViewController.swift
//  SjukStugan
//
//  Created by joakim lundberg on 2019-02-28.
//  Copyright © 2019 joakim. All rights reserved.
//

import UIKit
import Firebase

class profileViewController: UIViewController {
    
    var db: Firestore!



    @IBOutlet weak var diagnosLabel: UILabel!
   
    @IBOutlet weak var progressCounter: UILabel!
    @IBOutlet weak var divider: UILabel!
    @IBOutlet var newTreatment: [UILabel]!
    @IBOutlet var bokningar: [UIStackView]!
    @IBOutlet weak var nameLabel: UILabel!
    
    var treatments: [String] = []
    var timer: Timer!
    var countTreatments = 0
    var i = 0
    var userName = ""
    

    override func viewDidLoad() {
        progressCounter.text = ""
        nameLabel.text = userName
        db = Firestore.firestore()
        
        
        countTreatments = treatments.count
        progressCounter.text = "\(countTreatments)"
       countTreatments = countTreatments - 1
                if treatments.count > 0{
                    if treatments.count > 5 {
                        for i in 0...5{
                            newTreatment[i].text = treatments[countTreatments]
                            countTreatments = countTreatments - 1
                        }
                    }
                    else {
                        for i in 0...countTreatments{
                            newTreatment[i].text = treatments[countTreatments]
                            countTreatments = countTreatments - 1
                        }
                    }
            
        }
        
        super.viewDidLoad()
        
        view.bringSubviewToFront(divider)
        view.bringSubviewToFront(diagnosLabel)
        
   }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toTreatments"  {
            if let destination = segue.destination as? NumberViewController {
                destination.treatments = treatments
                print(treatments)
                destination.treatCount = countTreatments
                print("Going to treatments count: \(countTreatments)")
            }
        }
        if segue.identifier == "toContacts"  {
            if let destination = segue.destination as? contactsViewController {
                destination.treatments = treatments
                print(treatments)
                destination.treatCount = countTreatments
                print("Going to contacts count: \(countTreatments)")
            }
        }
        if segue.identifier == "toMedicine"  {
            if let destination = segue.destination as? medicinerViewController {
                destination.treatments = treatments
                print(treatments)
                destination.treatCount = countTreatments
                print("Going to medicine count: \(countTreatments)")
            }
        }
        if segue.identifier == "logOut" {
            print("Signng out")
            let firebaseAuth = Auth.auth()
            do {
                try firebaseAuth.signOut()
            } catch let signOutError as NSError {
                print ("Error signing out: %@", signOutError)
        }
        
        }
    }
}
    





