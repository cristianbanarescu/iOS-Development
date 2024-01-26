//
//  ContentView.swift
//  SwiftUI-ScrollViewDemo
//
//  Created by Cristian Banarescu on 26.01.2024.
//

import SwiftUI

/*
 - ScrollView - a container view for other child views
 - user can scroll the child views to make them appear in front of them if the child view is not visible
 - horizontal or vertical scrollView
 - .scrollIndicators modifier to show or hide scroll indicator
 */

struct ContentView: View {
    private let foodArray = ["Pizza", "Burger", "Spaghetti", "Sushi", "Tacos", "Salad", "Ice Cream", "Pancakes", "Chicken Curry", "Fruit Salad", "Steak", "Lasagna", "Burrito", "Hamburger", "Ramen", "Chocolate Cake", "Cupcakes", "Popcorn", "Mango", "Guacamole", "Donuts", "Shrimp Scampi", "Nachos", "Cinnamon Rolls"]
    
    var body: some View {
        GeometryReader { geometryProxy in
            NavigationStack {
                ScrollView { // vertical scrollview
                    ForEach(foodArray, id: \.self) { food in
                        HStack {
                            Text(food)
                                .font(.largeTitle)
                            Spacer()
                        }
                    }
                }
                .frame(width: geometryProxy.size.width, height: 500, alignment: .leading) // make ScrolLView width the width of parent view
                .padding(.leading, 50)
                .navigationTitle("Foods")
                
                ScrollView(.horizontal) { // horizontal scrollview
                    HStack {
                        ForEach(foodArray, id: \.self) { food in
                            RoundedRectangle(cornerRadius: 30)
                                .fill(randomColor())
                                .frame(width: geometryProxy.size.width - 100, height: 100)
                        }
                    }
                }
//                .scrollIndicators(.hidden) // use this to hide the scroll indicator
                .frame(width: geometryProxy.size.width, alignment: .leading)
                .padding(.leading, 20)
            }
        }
    }
    
    func randomColor() -> Color {
        let red = Double.random(in: 0...1)
        let green = Double.random(in: 0...1)
        let blue = Double.random(in: 0...1)
        
        return Color(red: red, green: green, blue: blue)
    }
}

#Preview {
    ContentView()
}
