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
    
    var treatments: [String] = []
    var timer: Timer!
    var countTreatments = 0
    var i = 0
    

    override func viewDidLoad() {
        progressCounter.text = ""
        
        
        print("treatments Arrayen from start \(treatments)")
        
        /*db.collection("treatments").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    print("\(document.documentID) => \(document.data())")
                }
            }
        }*/
        
        
        /*db.collection("treatments").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    print("document ID: \(document.documentID)")
                    print("\(document.documentID) => \(document.data())")
                    self.treatments.append(document.documentID)
                    
                    print("treatments arrayen i for loopen \(self.treatments)")
                    print("treatments arrayens längd \(self.treatments.count)")
                    self.progressCounter.text = "\(self.treatments.count)"

                    self.newTreatment[self.i].text = self.treatments[self.i]
                   
                }
            }
        }*/
        
        print("treatments arrayen utanför for loopen \(treatments)")
        print("treatments arrayens längd utanför for loopen \(treatments.count)")
        
        
        
        countTreatments = treatments.count
        progressCounter.text = "\(countTreatments)"
        var lastIn = treatments.count
        lastIn = lastIn - 1
        print("Sistsa objektet i treatments \(treatments[treatments.count - 1])")
        for i in 0...5 {
            newTreatment[i].text = treatments[lastIn]
            lastIn = lastIn - 1
        }
        
        super.viewDidLoad()
        
        view.bringSubviewToFront(divider)
        view.bringSubviewToFront(diagnosLabel)
        
        
        print(newTreatment[0].text!)

   }
   /* @objc func showProgress(){
        let formatted = String(format: "%.0f", progressCounter * 100)
        progressPercentage.text = "\(formatted)%"
    }
    func addProgress(progress: Int){
        for _ in 1...progress {
            progressCounter = progressCounter + progressIncrement
        }
        

        
    }*/
    
   /* private func getAll(){
        db.collection("treatments").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    print("\(document.documentID) => \(document.data())")
                    
                }
            }
        }
    }*/
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toTreatments" {
            if let destination = segue.destination as? NumberViewController {
                destination.treatments = treatments
                print(treatments)
                destination.treatCount = countTreatments
                print("Going to treatments count: \(countTreatments)")
            }
            
        }
    }
    
}




