//
//  ContentView.swift
//  Footchecker
//
//  Created by 田诗韵 on 11/18/23.
//

import SwiftUI
import CoreData
import HealthKit

import SwiftUI
import HealthKit

struct ContentView: View {
    @State private var hasHealthKitPermission: Bool? = nil
    @State private var showingHealthKitUnavailableAlert = false
    @Environment(\.managedObjectContext) var context
    
    var body: some View {
        NavigationView {
            Group {
                if let hasPermission = hasHealthKitPermission {
                    if hasPermission {
                        // Navigate to the next view if permission is granted
                        LoginView()
                        
                    } else {
                        // Show message that the app cannot be used without permission
                        Text("HealthKit permission is required to use this app.")
                    }
                } else {
                    // Show a button to request HealthKit permission
                    Button("Request HealthKit Permission") {
                        requestHealthKitPermission()
                    }
                }
            }
            .onAppear {
                checkHealthKitAvailability()
            }
            .alert(isPresented: $showingHealthKitUnavailableAlert) {
                Alert(
                    title: Text("HealthKit Unavailable"),
                    message: Text("HealthKit is not available on this device."),
                    dismissButton: .default(Text("OK"))
                )
            }
        }
    }

    private func checkHealthKitAvailability() {
        if !HKHealthStore.isHealthDataAvailable() {
            showingHealthKitUnavailableAlert = true
        }
    }

    private func requestHealthKitPermission() {
        guard HKHealthStore.isHealthDataAvailable() else {
            showingHealthKitUnavailableAlert = true
            return
        }

        let healthStore = HKHealthStore()
        let stepType = HKObjectType.quantityType(forIdentifier: .stepCount)!
        let readTypes = Set([stepType])

        healthStore.requestAuthorization(toShare: nil, read: readTypes) { success, error in
            DispatchQueue.main.async {
                if success {
                    self.hasHealthKitPermission = true
                    self.saveHealthKitPermissionStatus(true)
                } else {
                    self.hasHealthKitPermission = false
                    self.saveHealthKitPermissionStatus(false)
                }
            }
        }
    }

    func fetchStepCountData() {
        guard let stepType = HKQuantityType.quantityType(forIdentifier: .stepCount) else {
            return
        }

        let now = Date()
        let startOfDay = Calendar.current.startOfDay(for: now)
        let predicate = HKQuery.predicateForSamples(withStart: startOfDay, end: now, options: .strictStartDate)

        let query = HKStatisticsQuery(quantityType: stepType, quantitySamplePredicate: predicate, options: .cumulativeSum) { _, result, _ in
            DispatchQueue.main.async {
                guard let result = result, let sum = result.sumQuantity() else {
                    return
                }
                let steps = sum.doubleValue(for: HKUnit.count())
                self.saveStepDataToCoreData(stepCount: Int64(steps), date: startOfDay)
            }
        }
        

        let healthStore = HKHealthStore()
        healthStore.execute(query)
    }

    func saveStepDataToCoreData(stepCount: Int64, date: Date) {
        let healthData = HealthData(context: context)
        healthData.stepCount = stepCount
        healthData.date = date

        do {
            try context.save()
        } catch {
            print("Error saving health data to CoreData: \(error)")
        }
    }

    
    private func saveHealthKitPermissionStatus(_ granted: Bool) {
        let user = User(context: context)
        user.healthPermit = granted

        do {
            try context.save()
        } catch {
           
            print("Error saving health permission status: \(error)")
        }
    }

}

#Preview {
    ContentView()
}


