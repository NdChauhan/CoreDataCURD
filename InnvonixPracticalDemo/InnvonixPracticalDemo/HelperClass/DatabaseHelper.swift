//
//  DatabaseHelper.swift
//  InnvonixPracticalDemo
//
//  Created by Nidhi Chauhan on 31/05/23.
//

import Foundation
import UIKit
import CoreData

class DatabaseHelper {
    
    static var sharedInstance = DatabaseHelper()
    let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    
    //MARK: SaveData
    
    func saveEmployeeData(object:[String:String]) {
        
        let employee = NSEntityDescription.insertNewObject(forEntityName: "UserData", into: context!) as! UserData
        employee.firstname = object["firstname"]
        employee.lastname = object["lastname"]
        employee.email = object["email"]
        employee.password = object["password"]
        employee.mobileno = object["mobileno"]
        do{
            try context?.save()
        } catch{
            print("data is not save")
        }
    }
    
    //MARK: GetData
    
    func getEmployeeData() -> [UserData] {
        var userdata = [UserData]()
        let fetchdata = NSFetchRequest<NSManagedObject>(entityName: "UserData")
        do {
            userdata = try context?.fetch(fetchdata) as! [UserData]
        } catch {
            print("data not fatched")
        }
        return userdata
    }
    
    //MARK: DeleteData
    
    func deleteEmployeeData(index:Int) -> [UserData]{
        var userdata = getEmployeeData()
        context?.delete(userdata[index])
        userdata.remove(at: index)
        do {
            try context?.save()
        } catch {
            print("data not deleted")
        }
        return userdata
    }
    
    //MARK: EditData
    
    func editEmployeeData(object:[String:String], index:Int) {
        let userdata = getEmployeeData()
        userdata[index].firstname = object["firstname"]
        userdata[index].lastname = object["lastname"]
        userdata[index].email = object["email"]
        userdata[index].password = object["password"]
        userdata[index].mobileno = object["mobileno"]
        do{
            try context?.save()
        } catch {
            print("data not edited")
        }
        
    }
}
