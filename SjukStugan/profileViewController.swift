//
//  profileViewController.swift
//  SjukStugan
//
//  Created by joakim lundberg on 2019-02-28.
//  Copyright © 2019 joakim. All rights reserved.
//

import UIKit

class profileViewController: UIViewController {


    @IBOutlet weak var diagnosLabel: UILabel!
   
    @IBOutlet weak var progressCounter: UILabel!
    @IBOutlet weak var divider: UILabel!
    @IBOutlet weak var bokningar: UIStackView!
    @IBOutlet var newTreatment: [UILabel]!
    
    var treatments: [String] = ["","","","","",""]
    var timer: Timer!
    var countTreatments = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        progressCounter.text = "\(countTreatments)"
        
        newTreatment[0].text = treatments[0]
        newTreatment[1].text = treatments[1]
        newTreatment[2].text = treatments[2]
        newTreatment[3].text = treatments[3]
        newTreatment[4].text = treatments[4]
        newTreatment[5].text = treatments[5]

        
        view.bringSubviewToFront(divider)
        view.bringSubviewToFront(diagnosLabel)
        
       
        
        view.bringSubviewToFront(bokningar)
        //diagnosLabel.text = "Kommande behandlingar"
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




