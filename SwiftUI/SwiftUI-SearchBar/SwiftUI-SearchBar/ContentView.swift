//
//  ContentView.swift
//  SwiftUI-SearchBar
//
//  Created by Cristian Banarescu on 17.06.2024.
//

import SwiftUI

/// Example of a project in which a `UIViewRepresentable` SwiftUI View containing a UISearchBar is integrated
/// App also uses UserDefaults to store the search terms and show them to the user when user re-opens the app
struct ContentView: View {
    
    let appleFrameworks = [
        "Accelerate",
        "Accessibility",
        "Accounts",
        "AdSupport",
        "AppTrackingTransparency",
        "ARKit",
        "AuthenticationServices",
        "AVFoundation",
        "AVKit",
        "BackgroundTasks",
        "BusinessChat",
        "CallKit",
        "CarPlay",
        "ClassKit",
        "CloudKit",
        "Combine",
        "Contacts",
        "ContactsUI",
        "CoreAudio",
        "CoreAudioKit",
        "CoreBluetooth",
        "CoreData",
        "CoreGraphics",
        "CoreHaptics",
        "CoreImage",
        "CoreLocation",
        "CoreMedia",
        "CoreML",
        "CoreMotion",
        "CoreNFC",
        "CoreServices",
        "CoreSpotlight",
        "CoreTelephony",
        "CoreText",
        "CoreVideo",
        "CryptoKit",
        "DeviceCheck",
        "EventKit",
        "EventKitUI",
        "ExternalAccessory",
        "FileProvider",
        "FileProviderUI",
        "Foundation",
        "GameController",
        "GameKit",
        "GameplayKit",
        "HealthKit",
        "HomeKit",
        "iAd",
        "IdentityLookup",
        "ImageCaptureCore",
        "ImageIO",
        "Intents",
        "IntentsUI",
        "IOBluetooth",
        "IOBluetoothUI",
        "IOMobileFramebuffer",
        "IOSurface",
        "JavaScriptCore",
        "Kernel",
        "LinkPresentation",
        "LocalAuthentication",
        "MapKit",
        "MediaAccessibility",
        "MediaPlayer",
        "MediaToolbox",
        "MessageUI",
        "Metal",
        "MetalKit",
        "MetalPerformanceShaders",
        "MetricKit",
        "MobileCoreServices",
        "ModelIO",
        "MultipeerConnectivity",
        "NaturalLanguage",
        "NearbyInteraction",
        "Network",
        "NetworkExtension",
        "NotificationCenter",
        "OSLog",
        "PassKit",
        "PencilKit",
        "Photos",
        "PhotosUI",
        "PushKit",
        "QuickLook",
        "QuickLookThumbnailing",
        "ReplayKit",
        "SafariServices",
        "SceneKit",
        "Security",
        "SensorKit",
        "ShazamKit",
        "Social",
        "SoundAnalysis",
        "Speech",
        "SpriteKit",
        "StoreKit",
        "SwiftUI",
        "SystemConfiguration",
        "UIKit",
        "UserNotifications",
        "UserNotificationsUI",
        "VideoToolbox",
        "Vision",
        "WatchConnectivity",
        "WatchKit",
        "WebKit",
        "WidgetKit",
        "XCTest"
    ]
    @State private var viewModel = SearchViewModel()
    @State var searchText: String = ""
    @State var searchTermSearched: String = ""
    @State var searchTerms: [String] = []
    
    var body: some View {
        VStack {
            SearchBar(text: $searchText, searchTermSearched: $searchTermSearched)
            
            VStack(alignment: .leading) {
                HStack {
                    Text("Last 3 search terms: ")
                    Spacer()
                }
                
                ForEach(searchTerms, id: \.self) { searchTerm in
                    Text(searchTerm)
                        .italic()
                        .bold()
                }
            }
            .padding(.horizontal, 20)
            
            List {
                let filteredFrameworks = appleFrameworks.filter { searchText.isEmpty ? true : $0.localizedCaseInsensitiveContains(searchText) }
                ForEach(filteredFrameworks, id: \.self) { frameworkName in
                    Text(frameworkName)
                }
            }
        }
        .onChange(of: searchTermSearched) { _, newValue in
            searchTerms.append(newValue)
            viewModel.store(searchTerms: searchTerms)
        }
        .onAppear {
            searchTerms = viewModel.retrieveSearchTerms()
        }
    }
}

#Preview {
    ContentView()
}
