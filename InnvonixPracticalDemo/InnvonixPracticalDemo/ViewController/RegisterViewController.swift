//
//  RegisterViewController.swift
//  InnvonixPracticalDemo
//
//  Created by Nidhi Chauhan on 31/05/23.
//

import UIKit
import PhotosUI

class RegisterViewController: UIViewController, EditData {
    
    // MARK: - veriables & Outlets
    
    @IBOutlet weak var firstNameField: UITextField!
    @IBOutlet weak var lastNameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var mobilenoField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var profileImageView: UIImageView!
    
    var i = Int()
    var isUpdate = Bool()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        uiconfiguration()
        addGesture()
    }
    
    //MARK: Configuration Method
    
    func uiconfiguration() {
        profileImageView.layer.cornerRadius = profileImageView.frame.size.height / 2
    }
    
    //MARK: AddGesture method
    
    func addGesture() {
        let imageTap = UITapGestureRecognizer(target: self, action: #selector(RegisterViewController.openGallery))
        profileImageView.addGestureRecognizer(imageTap)
    }
    
    //MARK: Button Action method
    
    @IBAction func RegisterButtonClicked(_ sender: UIButton) {
        guard let firstName = firstNameField.text, !firstName.isEmpty else {
            openAlert(message: "Please enter your first name")
            return
        }
        guard let lastName = lastNameField.text, !lastName.isEmpty else {
            openAlert(message: "Please enter your last name")
            return
        }
        guard let email = emailField.text, !email.isEmpty else {
            openAlert(message: "Please enter your email address")
            return
        }
        
        guard let password = passwordField.text, !password.isEmpty else {
            openAlert(message: "Please enter your password")
            return
        }
        
        guard let mobileno = mobilenoField.text, !mobileno.isEmpty else {
            openAlert(message: "Please enter your mobileno")
            return
        }
        
        let dict = ["firstname":firstNameField.text,
                    "lastname":lastNameField.text,
                    "email":emailField.text,
                    "password":passwordField.text,
                    "mobileno":mobilenoField.text]
        if isUpdate {
            DatabaseHelper.sharedInstance.editEmployeeData(object: dict as! [String:String], index: i)
        } else {
            DatabaseHelper.sharedInstance.saveEmployeeData(object: dict as! [String:String])
            //clearData()
        }
        let listVc = self.storyboard?.instantiateViewController(withIdentifier: "ListViewController") as! ListViewController
        listVc.delegate=self
        self.navigationController?.pushViewController(listVc, animated: true)
        
    }
    
    @IBAction func LoginButtonClicked(_ sender: UIButton) {
        let loginVc = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        loginVc.delegate = self
        self.navigationController?.pushViewController(loginVc, animated: true)
    }
    
    //MARK: Cleardata method
    
    func clearData() {
        firstNameField.text = ""
        lastNameField.text = ""
        mobilenoField.text = ""
        passwordField.text = ""
        emailField.text = ""
    }
    
    //MARK: protocol Method
    
    func data(object: [String : String], index: Int, isEdit: Bool) {
        firstNameField.text = object["firstname"]
        lastNameField.text = object["lastname"]
        emailField.text = object["email"]
        passwordField.text = object["password"]
        mobilenoField.text = object["mobileno"]
        i = index
        isUpdate = isEdit
    }
    
}

//MARK: extension

extension RegisterViewController {
    
    //MARK: OpenAlert
    
    func openAlert(message: String){
        let alertController = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        let okay = UIAlertAction(title: "Okay", style: .default)
        alertController.addAction(okay)
        present(alertController, animated: true)
    }
    
    //MARK: openGallery
    
    @objc func openGallery() {
        var config = PHPickerConfiguration()
        config.selectionLimit = 1 // 0 - Unlimited
        
        let pickerVC = PHPickerViewController(configuration: config)
        pickerVC.delegate = self
        present(pickerVC, animated: true)
    }
    
}

//MARK: extension for imagepicker

extension RegisterViewController: PHPickerViewControllerDelegate {
    
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        dismiss(animated: true)
        for result in results {
            // Background Thread
            result.itemProvider.loadObject(ofClass: UIImage.self) { image, error in
                guard let image = image as? UIImage else { return }
                DispatchQueue.main.async {
                    // Main - UI related work
                    self.profileImageView.image = image
                }
            }
        }
    }
}
