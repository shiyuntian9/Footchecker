//
//  AccessDeniedView.swift
//  Footchecker
//
//  Created by 田诗韵 on 11/18/23.
//

import Foundation
import SwiftUI

struct AccessDeniedView: View {
    var tryAgainAction: () -> Void
    var cancelAction: () -> Void

    var body: some View {
        VStack(spacing: 20) {
            Text("You cannot use this app without HealthKit authorization.")
                .padding()
                .multilineTextAlignment(.center)

            Button("Agree", action: tryAgainAction)
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(8)

            Button("Cancel", action: cancelAction)
                .padding()
                .background(Color.gray)
                .foregroundColor(.white)
                .cornerRadius(8)
        }
    }
}
