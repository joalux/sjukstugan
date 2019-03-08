//
//  DiagnosViewController.swift
//  SjukStugan
//
//  Created by joakim lundberg on 2019-03-04.
//  Copyright © 2019 joakim. All rights reserved.
//

import UIKit

class DiagnosViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet var treatmentDone: [UISwitch]!
    @IBOutlet weak var addTreatment: UIButton!
    @IBOutlet var treatmentName: [UILabel]!
    @IBOutlet weak var newTreatment: UITextField!
    
    var newPlace = 0
    var nameForTreatment = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for i in 0...11{
            treatmentDone[i].isOn = false
            treatmentDone[i].isHidden = true
            treatmentName[i].isHidden = true
        }
    }
    func addTreatment(treatment: String, place: Int){
        treatmentDone[place].isEnabled = true
        treatmentName[place].text = treatment
        print(treatmentName[place])
        treatmentName[place].isHidden = false
        treatmentDone[place].isHidden = false
        treatmentDone[place].isOn = false

        
    }
    
    @IBAction func addNew(_ sender: UIButton) {
        
        let treatmentText: String = newTreatment.text!
        addTreatment(treatment: treatmentText, place: newPlace)
        
        newPlace += 1
        print("newtreatment name === \(treatmentName[0].text ?? "default"))")

        print("adding treatment")
        print(treatmentName[0].text!)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "backToMain" {
            let destinationVC = segue.destination as! profileViewController
            print("treatment name is ========")
            print(treatmentName[0].text!)
            print(destinationVC.newTreatment[0].text)
            destinationVC.newTreatment[0].text = treatmentName[0].text
            
        }
    }
    
}
