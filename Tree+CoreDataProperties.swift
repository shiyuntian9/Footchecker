//
//  Tree+CoreDataProperties.swift
//  Footchecker
//
//  Created by 田诗韵 on 11/19/23.
//
//

import Foundation
import CoreData


extension Tree {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Tree> {
        return NSFetchRequest<Tree>(entityName: "Tree")
    }

    @NSManaged public var type: String?
    @NSManaged public var amount: Int64

}

extension Tree : Identifiable {

}
