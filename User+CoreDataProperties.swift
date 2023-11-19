//
//  User+CoreDataProperties.swift
//  Footchecker
//
//  Created by 田诗韵 on 11/19/23.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var password: String?
    @NSManaged public var username: String?
    @NSManaged public var healthPermit: Bool
    @NSManaged public var credit: Int64

}

extension User : Identifiable {

}
