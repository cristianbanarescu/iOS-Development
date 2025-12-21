//
//  FeedView.swift
//  Pulse
//
//  Created by Cristian Banarescu on 21.12.2025.
//

import SwiftUI

struct FeedView: View {
    // @State answers “what can this view change?” What does THIS view control?
    // A view owns state only when it owns the user interaction that changes it.
    @State private var showThirdLine = true

    var body: some View {
        VStack(spacing: 16) {
            Button(showThirdLine ? "Hide details" : "Show details") {
                showThirdLine.toggle()
            }

            Text("Pulse")
                .font(.largeTitle)
                .fontWeight(.bold)

            Divider()

            VStack(spacing: 12) {
                ActivityRowView(title: "First activity", subtitle: "This is a placeholder", thirdLine: showThirdLine ? "Extra details": nil)
                ActivityRowView(title: "Another activity", subtitle: "Static data for now", thirdLine: showThirdLine ? "Extra details": nil)
                ActivityRowView(title: "One more", subtitle: "We’ll make this dynamic later", thirdLine: showThirdLine ? "Extra details": nil)
            }

            Spacer()
        }
        .padding()
    }
}

#Preview {
    FeedView()
}

