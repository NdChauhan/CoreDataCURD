//
//  ListViewController.swift
//  InnvonixPracticalDemo
//
//  Created by Nidhi Chauhan on 31/05/23.
//

import UIKit

//MARK: Protocol

protocol EditData {
    func data(object:[String:String], index:Int, isEdit:Bool)
}

class ListViewController: UIViewController{
    
    //MARK: Veriable & Outlet
    
    @IBOutlet weak var listtableview: UITableView!
    var arruserdata = [UserData]()
    var delegate:EditData!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        arruserdata = DatabaseHelper.sharedInstance.getEmployeeData()
    }
    
    //MARK: Button Action
    
    @IBAction func NewUserButtonClicked(_ Sender: UIButton) {
        let loginVc = self.storyboard?.instantiateViewController(withIdentifier: "RegisterViewController") as! RegisterViewController
        self.navigationController?.pushViewController(loginVc, animated: true)
    }
}

//MARK: Tableview Methods

extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        arruserdata.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        cell.viewMainView.layer.shadowColor = UIColor.black.cgColor
        cell.viewMainView.layer.shadowOpacity = 0.2
        cell.viewMainView.layer.shadowOffset = .zero
        cell.viewMainView.layer.shadowRadius = 6
        cell.viewMainView.layer.cornerRadius = 10
        cell.user = arruserdata[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            arruserdata = DatabaseHelper.sharedInstance.deleteEmployeeData(index: indexPath.row)
            self.listtableview.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let dict = ["firstname":arruserdata[indexPath.row].firstname,
                    "lastname":arruserdata[indexPath.row].lastname,
                    "email":arruserdata[indexPath.row].email,
                    "mobileno":arruserdata[indexPath.row].mobileno,
                    "password":arruserdata[indexPath.row].password]
        delegate.data(object: dict as! [String:String], index: indexPath.row, isEdit: true)
        if let viewControllers = self.navigationController?.viewControllers {
               for vc in viewControllers {
                    if vc.isKind(of: RegisterViewController.classForCoder()) {
                         print("It is in stack")
                         //Your Process
                        self.navigationController?.popToViewController(vc, animated: true)
                    }
               }
         }
        
        //self.navigationController?.popViewController(animated: true)
//        for controller in self.navigationController!.viewControllers as Array {
//            if controller.isKind(of: RegisterViewController.self) {
//                self.navigationController!.popToViewController(controller, animated: true)
//                break
//            }
//        }
    }
}
