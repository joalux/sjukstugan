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
    var i = 0, checker = 0
    

    override func viewDidLoad() {
        progressCounter.text = ""
        
        db = Firestore.firestore()
        
        print("treatments arrayen utanför for loopen \(treatments)")
        print("treatments arrayens längd utanför for loopen \(treatments.count)")
        
        countTreatments = treatments.count
        progressCounter.text = "\(countTreatments)"
       countTreatments = countTreatments - 1
        print("Sistsa objektet i treatments \(treatments.count)")
        if treatments.count > 0{
            for i in 0...countTreatments{
                
                print("testing")
                newTreatment[i].text = treatments[i]
                checker = checker + 1
                
            }
        }
        
        super.viewDidLoad()
        
        view.bringSubviewToFront(divider)
        view.bringSubviewToFront(diagnosLabel)
        
   }
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




