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
     var handle: AuthStateDidChangeListenerHandle?

   
    @IBOutlet var popOver: UIView!
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var newUserName: UITextField!
    @IBOutlet weak var newPassword: UITextField!
    @IBOutlet weak var confirmPassword: UITextField!
    @IBOutlet weak var newUserLabel: UILabel!
    
    
    
     var treatments: [String] = []
    var blue = UIColor(red: 100.0/255.0, green: 130.0/255.0, blue: 230.0/255.0, alpha: 1.0)
    
    @IBAction func openSignUp(_ sender: UIButton) {
        self.view.addSubview(popOver)
        popOver.layer.borderColor = blue.cgColor
        popOver.layer.borderWidth = 3.0
        popOver.center = self.view.center
    }
    @IBAction func createUser(_ sender: UIButton) {
        var newName = newUserName.text!
        var newPass = newPassword.text!
        var confirmPass = confirmPassword.text!
        
        if newPass == confirmPass || newPass.count > 6 {
            Auth.auth().createUser(withEmail: newName, password: newPass) { authResult, error in
                if (error == nil) {
                    print("created user")
                } else {
                    print("error!!! \(error)")
                }
            }
            self.popOver.removeFromSuperview()
        }
        else {
            newUserLabel.text = "Lösenord måste vara lika och minst 6 tecken"
        }
    }
    @IBAction func signIn(_ sender: UIButton) {
        var mail = userName.text!
        var pass = password.text!
        Auth.auth().signIn(withEmail: mail, password: pass) { [weak self] user, error in
            guard let strongSelf = self else { return }
            if  Auth.auth().currentUser != nil {
                //segue to next view
                print("login successful")
                
            }
            else{
                print("login unsuccessful")
            }
        }
        
        
        
    }
    
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        handle = Auth.auth().addStateDidChangeListener { (auth, user) in
            // ...
        }
    }
    override func viewWillDisappear(_ animated: Bool) {
        Auth.auth().removeStateDidChangeListener(handle!)

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

