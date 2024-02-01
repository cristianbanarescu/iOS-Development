//
//  ContentView.swift
//  SwiftUI-PickerDemo
//
//  Created by Cristian Banarescu on 22.01.2024.
//

import SwiftUI

/*
 - how to bind a value to the picker's value
 - how just an Image can be added near a Picker's Row (Text + Image inside an HStack; used as picker's selection)
 - can have multiple sections inside a picker
 - need to use a row's tag (if not using a ForEach) in order to correctly bind the picker's selection to your variable
 - picker's selection can be changed programatically > just change the value of your binded variable
 - SegmentedControl = Picker with .pickerStyle(.segmented)
 */

struct ContentView: View {
    @State var selectedLanguage: String = "German" // bind Picker to this value
    @State var segmentedSelection: String = "German"
    
    var body: some View {
        VStack {
            Spacer()
            
            Picker("Languages", selection: $selectedLanguage) {
                // you can have multiple sections inside a Picker
//                Section {
//                    HStack {
//                        Text("Romanian").tag("Romanian") // Picker needs to be binded using the 'tag' of a Row
//                        Image(systemName: "list.dash") // this works; if you try to add something else besides the Text for a picker's row, it might not work (for example, adding a Button near a Text, inside a Picker's row, will not work)
//                    }
//                } header: {
//                    Text("Roman languages")
//                }
                
                let nonRomanLanguages: [String] = ["German", "English", "French", "Chineese"]
                Section {
                    ForEach(nonRomanLanguages, id: \.self) { language in
                        Text(language)//.tag(language) Tag is not needed anymore, when using a ForEach
                    }
                    
//                    Text("German").tag("German")
//                    Text("English").tag("English")
//                    Text("French").tag("French")
//                    Text("Chineese").tag("Chineese")
                } header: {
                    Text("Non-Roman languages")
                }
            }
            
            Spacer()
            
            HStack {
                Text("Choose other language:")
                Spacer()
            }
            
            List { // change picker's selection programatically
                Text("French")
                    .onTapGesture {
                        selectedLanguage = "French"
                    }
                Text("Chineese")
                    .onTapGesture {
                        selectedLanguage = "Chineese"
                    }
            }
            .frame(height: 200)
            
            Spacer()
            
            Picker(selection: $segmentedSelection) { // Picker with .pickerStyle(.segmented) = SegmentedControl
                Text("German").tag("German")
                Text("French").tag("French")
                Text("Italian").tag("Italian")
            } label: {
                Text("Segmented picker")
            }
            .pickerStyle(.segmented)
            
            Spacer()

        }
        .padding()
    }
}

#Preview {
    ContentView()
}
