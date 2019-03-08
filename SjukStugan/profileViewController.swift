//
//  profileViewController.swift
//  SjukStugan
//
//  Created by joakim lundberg on 2019-02-28.
//  Copyright © 2019 joakim. All rights reserved.
//

import UIKit

class profileViewController: UIViewController {

    @IBOutlet weak var behandlingar: UILabel!
    @IBOutlet weak var diagnosLabel: UILabel!
    @IBOutlet weak var progressBar: ProgressBarView!
    @IBOutlet weak var progressPercentage: UILabel!
    @IBOutlet weak var divider: UILabel!
    @IBOutlet weak var bokningar: UIStackView!
    @IBOutlet var newTreatment: [UILabel]!
    
    var treatments: [UILabel] = []
    var timer: Timer!
    var progressCounter:Float = 0
    var progressIncrement:Float = 0.1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newTreatment[0].text = "sdasdasd"
        newTreatment[1].text = ""
        newTreatment[2].text = ""
        newTreatment[3].text = ""
        view.bringSubviewToFront(divider)
        view.bringSubviewToFront(diagnosLabel)
        view.bringSubviewToFront(behandlingar)
        view.bringSubviewToFront(bokningar)
        diagnosLabel.text = "Kommande behandlingar"
        print("Testing ")
        print(newTreatment[0].text!)
        
       
        showProgress()
       



   }
    @objc func showProgress(){
        let formatted = String(format: "%.0f", progressCounter * 100)
        progressBar.progress = progressCounter
        progressPercentage.text = "\(formatted)%"
    }
    func addProgress(progress: Int){
        for _ in 1...progress {
            progressCounter = progressCounter + progressIncrement
        }
        

        
    }
    
    
}

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


