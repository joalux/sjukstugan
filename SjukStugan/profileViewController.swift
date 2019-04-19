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
    
    var datab: Firestore!

    @IBOutlet weak var diagnosLabel: UILabel!
    @IBOutlet weak var totTreatmentsLabel: UILabel!
    
    @IBOutlet weak var progressCounter: UILabel!
    @IBOutlet weak var divider: UILabel!
    @IBOutlet var newTreatment: [UILabel]!
    @IBOutlet var bokningar: [UIStackView]!
    @IBOutlet weak var nameLabel: UILabel!
    
    var treatments: [Treatment] = []
    var docRefs: [String] = []
    var meds: [String] = []
    var timer: Timer!
    var countTreatments = 0
    var i = 0
    var userName = ""
    var loadTreatments = false
    let data: [String: Any] = [:]
    //var label: UILabel
   

    override func viewDidLoad() {
        print(treatments)
        super.viewDidLoad()
        progressCounter.text = ""
        nameLabel.text = userName
        totTreatmentsLabel.font = UIFont.boldSystemFont(ofSize: 16.0)
        totTreatmentsLabel.text = "Avklarade \n behandlingar"
        datab = Firestore.firestore()
        
        print("load is = \(loadTreatments)")
       // if loadTreatments == false {
            print("loading treats")
           
            datab.collection("users").document(userName).collection("treatments").getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for document in querySnapshot!.documents {
       
                        var docID = document.documentID
                        
                        
                        var newTreat = Treatment(snapshot: document)
                        print("new treatment id------------------------")
                        print(docID)
                        self.docRefs.append(docID)
                        
                        print("docrefs------------------------")
                        print(self.docRefs)
                        
                        
                        let formatter = DateFormatter()
                        
                        formatter.dateFormat = "yyyy-MM-dd HH:mm"
                        
                        let myString = formatter.string(from: Date())
                        //print("Dateformat string \(myString)")
                        
                        print("new treatment-------- \(newTreat.name)")
                        if(self.i < 6){
                            let myString = formatter.string(from: newTreat.date)
                            self.newTreatment[self.i].text = "\(newTreat.name) \n \(myString)"
                        }
                        if self.loadTreatments == false {
                            print("loading treats")
                            self.treatments.append(newTreat)
                        }
                        
                        print("treatments arrayen")
                        print(self.treatments)
                        self.progressCounter.text = "\(self.treatments.count)"
                        self.i = self.i + 1
                    }
                }
            }
            
        
            
        


        view.bringSubviewToFront(divider)
        view.bringSubviewToFront(diagnosLabel)
        
   }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toTreatments"  {
            if let destination = segue.destination as? NumberViewController {
                destination.loadFirstTime = loadTreatments
                destination.treatments = treatments
                print(treatments)
                destination.treatCount = countTreatments
                destination.username = userName
                print("Going to treatments count: \(countTreatments)")
                loadTreatments = true
                destination.loadFirstTime = loadTreatments
                destination.docRefs = docRefs
            }
        }
        if segue.identifier == "toContacts"  {
            if let destination = segue.destination as? contactsViewController {
                destination.treatments = treatments
                print(treatments)
                destination.treatCount = countTreatments
                destination.loadFirstTime = loadTreatments
                destination.username = userName
                print("Going to contacts count: \(countTreatments)")
            }
        }
        if segue.identifier == "toMedicine"  {
            
            if let destination = segue.destination as? medTableViewController {
                
                destination.meds = meds
                destination.loadFirstTime = loadTreatments
                destination.treatCount = countTreatments
                destination.username = userName
                
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


