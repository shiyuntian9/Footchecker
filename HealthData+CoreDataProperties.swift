//
//  HealthData+CoreDataProperties.swift
//  Footchecker
//
//  Created by 田诗韵 on 11/19/23.
//
//

import Foundation
import CoreData


extension HealthData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<HealthData> {
        return NSFetchRequest<HealthData>(entityName: "HealthData")
    }

    @NSManaged public var date: Date?
    @NSManaged public var stepCount: Int64
    @NSManaged public var credit: Int64

}

extension HealthData : Identifiable {

}
