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
 */


struct ActivityRowView: View {
    let title: String
    let subtitle: String
    let thirdLine: String?

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            Circle()
                .fill(Color.blue)
                .frame(width: 40, height: 40)

            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.headline)

                Text(subtitle)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                
                if let thirdLine {
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
    }
}

#Preview {
    ActivityRowView(
        title: "Preview Activity",
        subtitle: "This is what a row looks like",
        thirdLine: "Third line text"
    )
    .padding()
}
