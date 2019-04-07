//
//  medicinerViewController.swift
//  SjukStugan
//
//  Created by joakim lundberg on 2019-04-07.
//  Copyright © 2019 joakim. All rights reserved.
//

import UIKit

class medicinerViewController: UIViewController {

    var myMedicins: [String] = []
    var treatments: [String] = []
    var treatCount = 0

    @IBOutlet var popOver: UIView!
    @IBOutlet weak var medicinList: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("is in my medicins _________________________")
        print(treatments)
        
      
    }
    @IBAction func openPopover(_ sender: UIBarButtonItem) {
        self.view.addSubview(popOver)
        popOver.center = self.view.center
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "backToMain" {
            if let destination = segue.destination as? profileViewController {
                destination.treatments = treatments
                
                print(treatments)
                destination.countTreatments = treatCount
               
            }
            
        }
    }
    
  
    

}
