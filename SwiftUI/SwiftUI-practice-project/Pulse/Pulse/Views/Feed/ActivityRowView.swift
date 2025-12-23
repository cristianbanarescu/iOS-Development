//
//  ActivityRowView.swift
//  Pulse
//
//  Created by Cristian Banarescu on 21.12.2025.
//

import SwiftUI

/*
 - Layout modifiers first (frame, padding), visual modifiers after (background, overlay)
 - SwiftUI layout works like this:
    - Child proposes its ideal size
    - Parent constrains it
    - Child adapts
 - Closures are for actions, bindings are for shared mutable state.
 - A @Binding means:
    The child can directly mutate parent state
    The child knows too much about how state is stored
    You’ve coupled the child to the parent’s state shape
 - A closure lets the child say:
     “Something happened”
     not
     “Change this value to X”
 - So:
     Child does not own state
     Child does not mutate state
     Parent decides what to do
 - Mental rule (very important)
     If a child edits ongoing state → binding
     If a child signals an event → closure

     Tap, delete, select, submit → closure
     TextField, Toggle, Slider → binding
 - Bindings are for continuous two-way state, closures are for one-off events.
 */


struct ActivityRowView: View {
    let activity: Activity
    let onTap: () -> Void

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            Circle()
                .fill(Color.blue)
                .frame(width: 40, height: 40)

            VStack(alignment: .leading, spacing: 4) {
                Text(activity.title)
                    .font(.headline)

                Text(activity.body)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                
                if let thirdLine = activity.thirdLine {
                    Text(thirdLine)
                        .font(.caption2)
                        .foregroundStyle(.secondary)
                }
            }

            Spacer()
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color(.secondarySystemBackground))
        )
        .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
        .onTapGesture {
            onTap()
        }
    }
}

#Preview {
    ActivityRowView(activity: Activity(id: "testID",
                                       title: "Preview Activity",
                                       body: "This is what a row looks like",
                                       thirdLine: nil),
                    onTap: { })
    .padding()
}
