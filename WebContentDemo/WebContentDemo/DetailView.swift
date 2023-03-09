//
//  DetailView.swift
//  WebContentDemo
//
//  Created by Cristian Banarescu on 09.03.2023.
//

import SwiftUI

struct DetailView: View {
    
    var text: String
    
    var body: some View {
        Text(text)
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(text: "test")
    }
}
