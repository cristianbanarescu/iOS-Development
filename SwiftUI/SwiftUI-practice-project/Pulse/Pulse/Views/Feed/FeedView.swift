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
    @State private var activities: [Activity] = [
        Activity(id: "1", title: "first one", body: "first one body"),
        Activity(id: "2", title: "second one", body: "second one body"),
        Activity(id: "3", title: "third one", body: "third one body")
    ]
    @State private var selectedActivity: Activity?
    
    init(showThirdLine: Bool = true, activities: [Activity]) {
        self.showThirdLine = showThirdLine
        self.activities = activities
    }

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
                ForEach(activities, id: \.id) { activity in
                    ActivityRowView(activity: activity) {
                        print(activity.id)
                        selectedActivity = activity
                    }
                }
            }

            Spacer()
        }
        .padding()
    }
}

#Preview {
    FeedView(activities: [
        Activity(id: "1", title: "first one", body: "first one body"),
        Activity(id: "2", title: "second one", body: "second one body"),
        Activity(id: "3", title: "third one", body: "third one body"),
    ])
}

