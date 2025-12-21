//
//  FeedView.swift
//  Pulse
//
//  Created by Cristian Banarescu on 21.12.2025.
//

import SwiftUI

struct FeedView: View {
    var body: some View {
        VStack(spacing: 16) {
            Text("Pulse")
                .font(.largeTitle)
                .fontWeight(.bold)

            Divider()

            VStack(spacing: 12) {
                ActivityRowView(title: "First activity", subtitle: "This is a placeholder", thirdLine: nil)
                ActivityRowView(title: "Another activity", subtitle: "Static data for now", thirdLine: nil)
                ActivityRowView(title: "One more", subtitle: "We’ll make this dynamic later", thirdLine: nil)
            }

            Spacer()
        }
        .padding()
    }
}

#Preview {
    FeedView()
}

