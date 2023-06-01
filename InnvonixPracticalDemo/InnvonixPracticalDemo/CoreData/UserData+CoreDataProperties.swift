//
//  UserData+CoreDataProperties.swift
//  InnvonixPracticalDemo
//
//  Created by Nidhi Chauhan on 31/05/23.
//
//

import Foundation
import CoreData


extension UserData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserData> {
        return NSFetchRequest<UserData>(entityName: "UserData")
    }

    @NSManaged public var firstname: String?
    @NSManaged public var lastname: String?
    @NSManaged public var email: String?
    @NSManaged public var mobileno: String?
    @NSManaged public var profilepic: String?
    @NSManaged public var password: String?

}

extension UserData : Identifiable {

}
