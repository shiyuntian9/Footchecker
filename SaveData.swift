//
//  SaveData.swift
//  Footchecker
//
//  Created by 田诗韵 on 11/18/23.
//

import Foundation
import HealthKit
import CoreData
import UIKit

// Assuming `steps` is the data fetched from HealthKit
func saveHealthData(steps: Int, date: Date) {
    let context = PersistenceController.shared.container.viewContext
    let healthData = HealthData(context: context)
    healthData.stepCount = Int64(steps)
    healthData.date = date

    do {
        try context.save()
    } catch {
        // Handle the error
        print("Error saving context: \(error)")
        
    }
}

func fetchHealthData() -> [HealthData] {
    let context = PersistenceController.shared.container.viewContext
    let fetchRequest = NSFetchRequest<HealthData>(entityName: "HealthData")

    do {
        let results = try context.fetch(fetchRequest)
        return results
    } catch {
        // Handle the error
        print("Error fetching data: \(error)")
          return []
        
    }
}




