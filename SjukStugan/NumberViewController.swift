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
    var treatments: [Treatment] = []
    var treatmentList = [Treatment]()
    var i = 0
    var treatCount = 0
    var index = 0
    var loadFirstTime = false
    let unwrapped: String = ""
    var blue = UIColor(red: 100.0/255.0, green: 130.0/255.0, blue: 230.0/255.0, alpha: 1.0)
    var username = ""
    let data: [String: Any] = [:]
    
    var docRefs: [String] = []
    
    @IBOutlet var treatmentsTableView: UITableView!
    @IBOutlet weak var newTreatment: UITextField!
    @IBOutlet var popOver: UIView!
    @IBAction func openPopButton(_ sender: UIBarButtonItem) {
        self.view.addSubview(popOver)
        popOver.layer.borderColor = blue.cgColor
        popOver.layer.borderWidth = 3.0
        popOver.center = self.view.center
    }
    @IBAction func doneButton(_ sender: UIButton) {
        
        let date = Date()
        let calendar = Calendar.current
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        
        let myString = formatter.string(from: Date()) // string purpose I add here
        print("Dateformat string \(myString)")
        // convert your string to date
        let yourDate = formatter.date(from: myString)
        print("date is formatted \(yourDate)")
        
        print(newTreatment.text)
        let test = newTreatment.text
        
        if let unwrapped = test{
            print("unwrappade \(unwrapped)")
        
            let treat = Treatment(name: unwrapped, date: date)
            treatments.append(treat)

            
            var ref: DocumentReference? = nil

            ref = db.collection("users").document("\(username)").collection("treatments").addDocument(data: treat.toDictionary()){ err in
                if let err = err {
                    print("Error adding document: \(err)")
                } else {
                    print("Document added with ID: \(ref!.documentID)")
                    self.docRefs.append(ref!.documentID)
                }
            }
        }
        
        self.popOver.removeFromSuperview()
        treatCount = 1 + treatCount
        print(treatments)
        newTreatment.text = ""
        self.tableView.reloadData()
    }
 
    override func viewDidLoad() {
        
        let date = Date()
        print("Docrefs")
        print(docRefs)
       
        let formatter = DateFormatter()
        // initially set the format based on your datepicker date / server String
        formatter.dateFormat = "yyyy/MM/dd"
        
        let myString = formatter.string(from: Date()) // string purpose I add here
        print("Dateformat string \(myString)")
        // convert your string to date
        let yourDate = formatter.date(from: myString)
        print("date is formatted \(yourDate)")

        print("----------------------------------")
        print("username \(username)")
         db = Firestore.firestore()
        
        let itemsRef = db.collection("users").document("\(username)").collection("behandlingar")
        
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day], from: date)
        
        let year =  components.year
        let month = components.month
        let day = components.day
        
        print("dagar, månad, år")
        print(year!)
        print(month!)
        print(day!)
        
      
        

        super.viewDidLoad()
        
        self.popOver.layer.cornerRadius = 10
        
        
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
        
        
        cell.textLabel?.text = "\(treatments[indexPath.row].name) \(treatments[indexPath.row].date)"
        cell.backgroundColor = UIColor.clear
        
        return cell
    }
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            print("deleting document")
            
            print(treatments[indexPath.row].name)
            print(docRefs[indexPath.row])
            db.collection("users").document("\(username)").collection("treatments").document(docRefs[indexPath.row]).delete() { err in
                if let err = err {
                    print("Error removing document: \(err)")
                } else {
                    print("Document successfully removed!")
                }
            }
            
            treatments.remove(at: indexPath.row)
            
         
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.endUpdates()
        }
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
            
            print(treatments)
            print("Going to start totTreatments: \(treatCount)")
            if let destination = segue.destination as? profileViewController {
                destination.countTreatments = treatCount
                destination.treatments = treatments
                destination.userName = username
                destination.loadTreatments = loadFirstTime
            }
           
        }
    }
    
    
    
}

