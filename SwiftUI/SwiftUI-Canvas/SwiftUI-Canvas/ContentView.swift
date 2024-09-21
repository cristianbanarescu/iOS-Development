//
//  ContentView.swift
//  SwiftUI-Canvas
//
//  Created by Cristian Banarescu on 21.09.2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        // A view type that supports immediate mode drawing.
        Canvas { context, size in
            context.fill(Path(ellipseIn: CGRect(x: 30, y: 30, width: 100, height: 100)),
                         with: .color(.red)) // draw a red circle
            context.draw(Image(systemName: "pencil"), at: CGPoint(x: 300, y: 300)) // draw SF symbols image
            context.stroke(Path(ellipseIn: CGRect(x: 200, y: 100, width: 100, height: 100)), with: .color(.black)) // draw a circle only with stroke
            
            var path = Path()
            path.move(to: CGPoint(x: 200, y: 300))
            path.addLine(to: CGPoint(x: 200, y: 500))
            path.addLine(to: CGPoint(x: 200, y: 600))
            path.addLine(to: CGPoint(x: 200, y: 700))
            
            context.stroke(path, with: .color(.blue), style: StrokeStyle(lineWidth: 5))
            // draw a custom line and stroke it blue 
        }
    }
}

#Preview {
    ContentView()
}
