//
//  ContentView.swift
//  SwiftUI-Maps
//
//  Created by Cristian Banarescu on 29.07.2024.
//

import SwiftUI
import MapKit

struct ContentView: View {
    var body: some View {
        VStack {
            Map(initialPosition: .region(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 45, longitude: 43),
                                                            span: MKCoordinateSpan(latitudeDelta: 33, longitudeDelta: 33)))) {
                
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
