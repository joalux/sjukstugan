//
//  medTableViewController.swift
//  SjukStugan
//
//  Created by joakim lundberg on 2019-04-08.
//  Copyright © 2019 joakim. All rights reserved.
//

import UIKit
import Firebase

class medTableViewController: UITableViewController {
    
    @IBOutlet weak var medStepper: UIStepper!
    @IBOutlet var addMedPop: UIView!
    @IBOutlet weak var newMedTextField: UITextField!
    @IBOutlet var medList: UITableView!
    
    
    
    let data: [String: Any] = [:]
    var db: Firestore!
    var meds: [String] = []
    var newPost = "test"
    
    
    var blue = UIColor(red: 100.0/255.0, green: 130.0/255.0, blue: 230.0/255.0, alpha: 1.0)
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        db = Firestore.firestore()
    
       
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    @IBAction func addMeds(_ sender: UIBarButtonItem) {
        self.view.addSubview(addMedPop)
        addMedPop.layer.borderColor = blue.cgColor
        addMedPop.layer.borderWidth = 3.0
        addMedPop.center = self.view.center
    }
   
    @IBAction func addNewMeds(_ sender: UIButton) {
       
        
        if let unwrapped = newMedTextField.text{
            print("unwrapped \(unwrapped) \(medStepper.value)")
            newPost = "\(unwrapped) \(medStepper.value) "
             meds.append(unwrapped)
            
        }
        let post = meds[meds.count-1]
        print("!!!!!:)")
        print(post)
        db.collection("medicine").document(post).setData(data)
        
        newMedTextField.text = ""
       self.tableView.reloadData()
        self.addMedPop.removeFromSuperview()
    }
    
    
    @IBAction func addMed(_ sender: UIStepper) {
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return meds.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        

        cell.textLabel?.text = meds[indexPath.row]
        // Configure the cell...
        

        return cell
    }
     
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            meds.remove(at: indexPath.row)
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
            print(meds)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
 

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
