//
//  ContentView.swift
//  SwiftUI-StarPath
//
//  Created by Cristian Banarescu on 20.06.2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            starPath
                .stroke(.black, lineWidth: 5)
                .fill(.orange)
        }
        .padding()
    }
    
    var starPath: Path {
        var path = Path()
        path.move(to: CGPoint(x: UIScreen.main.bounds.width / 2 - 10, y: 100)) // starting point of the path
        
        path.addLine(to: CGPoint(x: UIScreen.main.bounds.width / 2 - 100, y: 300)) // add a line from the current position to this point
        path.addLine(to: CGPoint(x: UIScreen.main.bounds.width / 2 - 200, y: 300)) // add a line from the current position to this point
        path.addLine(to: CGPoint(x: UIScreen.main.bounds.width / 2 - 100, y: 400)) // add a line from the current position to this point
        path.addLine(to: CGPoint(x: UIScreen.main.bounds.width / 2 - 150, y: 600)) // add a line from the current position to this point
        path.addLine(to: CGPoint(x: UIScreen.main.bounds.width / 2 - 10, y: 500)) // add a line from the current position to this point
        path.addLine(to: CGPoint(x: UIScreen.main.bounds.width / 2 + 100, y: 600)) // add a line from the current position to this point
        path.addLine(to: CGPoint(x: UIScreen.main.bounds.width / 2 + 50, y: 400)) // add a line from the current position to this point
        path.addLine(to: CGPoint(x: UIScreen.main.bounds.width / 2 + 150, y: 300)) // add a line from the current position to this point
        path.addLine(to: CGPoint(x: UIScreen.main.bounds.width / 2 + 50, y: 300)) // add a line from the current position to this point
        path.addLine(to: CGPoint(x: UIScreen.main.bounds.width / 2 - 10, y: 100)) // add a line from the current position to this point
        
        return path
    }
}

#Preview {
    ContentView()
}
