//
//  LoginViewController.swift
//  InnvonixPracticalDemo
//
//  Created by Nidhi Chauhan on 31/05/23.
//

import UIKit
import CoreData

class LoginViewController: UIViewController, EditData {
    
    //MARK: veriables & outlets
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    var arrstudent = [UserData]()
    var i = Int()
    var isUpdate = Bool()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        arrstudent = DatabaseHelper.sharedInstance.getEmployeeData()
    }
    
    //MARK: button action method
    
    @IBAction func LoginButtonClicked(_ Sender: UIButton) {
        
        guard let email = emailField.text, !email.isEmpty else {
            openAlert(message: "Please enter your email address")
            return
        }
        
        guard let password = passwordField.text, !password.isEmpty else {
            openAlert(message: "Please enter your password")
            return
        }
        
        let request : NSFetchRequest<UserData> = UserData.fetchRequest()
        //let predicate = NSPredicate(format: "machineType = %@", type)
        request.predicate = NSPredicate(format: "email == %@", emailField.text!)
        request.predicate = NSPredicate(format: "password == %@", passwordField.text!)
        request.fetchLimit = 2
        do{
            let count = try DatabaseHelper.sharedInstance.context?.count(for: request)
            
            if(count == 0){
                print("no matches")
                openAlert(message: "Authentication Credential not match!!! Please enter your valid Credentials")
            }
            else{
                print("match found")
                let listVc = self.storyboard?.instantiateViewController(withIdentifier: "ListViewController") as! ListViewController
                listVc.delegate = self
                self.navigationController?.pushViewController(listVc, animated: true)
            }
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
        
    }
    
    //MARK: delegate method
    
    func data(object: [String : String], index: Int, isEdit: Bool) {
        emailField.text = object["email"]
        passwordField.text = object["password"]
        arrstudent[index].mobileno = object["mobileno"]
        arrstudent[index].lastname = object["lastname"]
        arrstudent[index].firstname = object["firstname"]
        i = index
        isUpdate = isEdit
    }
    
}

//MARK: extension for alert

extension LoginViewController {
    
    //MARK: openAlert
    
    func openAlert(message: String){
        let alertController = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        let okay = UIAlertAction(title: "Okay", style: .default)
        alertController.addAction(okay)
        present(alertController, animated: true)
    }
    
}
