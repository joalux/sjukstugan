//
//  ViewController.swift
//  SjukStugan
//
//  Created by joakim lundberg on 2019-02-28.
//  Copyright © 2019 joakim. All rights reserved.
//

import UIKit
import Firebase


class ViewController: UIViewController {
    
    
    var datab : Firestore!

   
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
     var treatments: [String] = []
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewDidLoad() {
        
        datab = Firestore.firestore()
        
        datab.collection("treatments").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    print("document ID: \(document.documentID)")
                    print("\(document.documentID) => \(document.data())")
                    self.treatments.append(document.documentID)
                    
                }
            }
        }
        
       
        
        super.viewDidLoad()
        
        print("treatments arrayen")
        print(treatments)
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toMain" {
            if let destination = segue.destination as? profileViewController {
                destination.treatments = treatments
            }
            print(treatments)
            print("Going to start totTreatments: \(treatments.count)")
        }
    }


}

