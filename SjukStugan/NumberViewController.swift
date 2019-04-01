//
//  NumberViewController.swift
//  SjukStugan
//
//  Created by joakim lundberg on 2019-03-27.
//  Copyright © 2019 joakim. All rights reserved.
//

import UIKit
import Firebase

class NumberViewController: UITableViewController {
    
    var db: Firestore!
    var treatments: [String] = []
    var i = 0
    var treatCount = 0
    var loadFirstTime = false
    
    
    @IBOutlet var treatmentsTableView: UITableView!
    @IBOutlet weak var navBar: UINavigationItem!
    @IBOutlet weak var newTreatment: UITextField!
    @IBOutlet var popOver: UIView!
    @IBAction func openPopButton(_ sender: UIBarButtonItem) {
        self.view.addSubview(popOver)
        popOver.center = self.view.center
    }
    @IBAction func doneButton(_ sender: UIButton) {

        self.popOver.removeFromSuperview()
        /*if i < 6 {
            db.collection("treatments").document(newTreatment.text!).setData(["name": newTreatment.text!,]) { err in
                if let err = err {
                    print("Error writing document: \(err)")
                } else {
                    print("Document successfully written!")
                }
            }
            
            i = i + 1
        }
        else{*/
            db.collection("treatments").addDocument(data: ["treatment" :  newTreatment.text!])
            treatments.append(newTreatment.text!)
        
        treatCount = 1 + treatCount
        
        print(treatments)
        newTreatment.text = ""
        self.tableView.reloadData()
    }
    
    
    
    
    
    
    override func viewDidLoad() {
        
        db = Firestore.firestore()
        print("treatments Arrayen from start \(treatments)")
        /*db.collection("treatments").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                
                if self.loadFirstTime == true{
                    for document in querySnapshot!.documents {
                        print("document ID: \(document.documentID)")
                        print("\(document.documentID) => \(document.data())")
                        self.treatments.append(document.documentID)
                        print("treatments arrayen \(self.treatments)")
                    }
                    self.treatmentsTableView.reloadData()
                     self.loadFirstTime = false
                }
            }
        }*/
        

        print("treatments arrayen \(treatments)")
        super.viewDidLoad()
        
        self.popOver.layer.cornerRadius = 10
        self.popOver.backgroundColor = UIColor.lightGray
        
        //tableView.backgroundColor = UIColor.gray
        tableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        //tableView.separatorColor = UIColor.black
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    // Add a new document with a generated ID
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return treatments.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        cell.textLabel?.text = treatments[indexPath.row]
        cell.backgroundColor = UIColor.clear
        
        return cell
    }
    
    
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
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
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "backToStart" {
            
            if let destination = segue.destination as? profileViewController {
                destination.countTreatments = treatCount
                destination.treatments = treatments
            }
            print(treatments)
            print("Going to start totTreatments: \(treatCount)")
        }
    }
    
    
    
}

