//
//  MainView.swift
//  Footchecker
//
//  Created by 田诗韵 on 11/18/23.
//


import SwiftUI
import HealthKit
import CoreData



struct MainView: View {
    // Example data - replace with actual data fetching logic
    @State private var footstepCount: Int = 0 // Example step count
    @State private var tripDistance: Double = 7.5 // Example distance in kilometers
    @Environment(\.managedObjectContext) var context
    @State private var userCredits: Int64 = 0

    
    let cardWidth: CGFloat = 360 // Fixed width for the cards
    let cardHeight: CGFloat = 150
    
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Text("Summary")
                    .font(.system(size: 40, weight: .bold, design: .rounded
                                 )) // Custom font style
                                        .foregroundColor(Color.purple) // Set your desired text color here
                                        .padding()
                                        .frame(maxWidth: .infinity, alignment: .leading)
                CardView {
                                    stepCountView
                                }
                                .frame(width: 360, height: 150)

                                // Credit Card View
                                CreditCardView(credits: userCredits)
                
                CardView {
                    stepCountView
                }
                .frame(width: cardWidth, height: cardHeight)

                CardView {
                    tripDistanceView
                }
                
                
            }.onAppear {
                fetchHealthKitData()
                fetchUserCredits()
            }
            .padding()
        }
    }

    func fetchHealthKitData() {
        let healthStore = HKHealthStore()
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
                let creditsEarned = self.calculateCredits(fromSteps: Int(steps))
                self.updateUserCredits(credits: creditsEarned)
            }
        }

        healthStore.execute(query)
    }

    func calculateCredits(fromSteps steps: Int) -> Int64 {
        // Assuming 5000 steps = 10 credits
        return Int64((steps / 5000) * 10)
    }

    func updateUserCredits(credits: Int64) {
        // Fetch the User entity and update credits
        // Assuming a single user in this example
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        do {
            let users = try context.fetch(fetchRequest)
            if let user = users.first {
                user.credit += credits
                try context.save()
            }
        } catch {
            print("Error updating user credits: \(error)")
        }
    }
    private func fetchUserCredits() {
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()

        do {
            let users = try context.fetch(fetchRequest)
            if let user = users.first { // Assuming you are dealing with a single user
                DispatchQueue.main.async {
                    self.userCredits = user.credit
                }
            }
        } catch {
            print("Error fetching user credits: \(error)")
        }
    }


    
    var stepCountView: some View {
        VStack(alignment: .leading) {
            Text("Steps Today")
                .font(.headline)
            
            ProgressView(value: Double(footstepCount), total: 10000)
                .progressViewStyle(LinearProgressViewStyle())
            
            HStack {
                Text("0")
                Spacer()
                Text("\(footstepCount) steps")
                Spacer()
                Text("10,000")
            }
        }
        .padding()
    }

    var tripDistanceView: some View {
        VStack(alignment: .leading) {
            Text("Offline Shopping")
                .font(.headline)
            
                .multilineTextAlignment(.leading)
                .lineLimit(nil)
                .padding(.leading, 0.0)
                
            
            HStack {
                Image(systemName: "car.fill")
                    .foregroundColor(.blue)
                Text("\(String(format: "%.2f", tripDistance)) km")
                    .font(.title)
            }
        }
        .frame(width: 300.0, height: 100.0)
        
    }
}



struct CreditCardView: View {
    var credits: Int64

    var body: some View {
        VStack {
            Text("Your Credits")
                .font(.headline)
                .padding(.top)

            Text("\(credits)")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.purple)
                .padding(.bottom)
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 100)
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
        .padding([.top, .horizontal])
    }
}


struct CardView<Content: View>: View {
    let content: Content

    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    var body: some View {
        VStack {
            content
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
        .padding([.top, .horizontal])
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
