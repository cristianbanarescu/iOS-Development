//
//  ContentView.swift
//  SwiftUI-SearchBar
//
//  Created by Cristian Banarescu on 17.06.2024.
//

import SwiftUI

/// Example of a project in which a `UIViewRepresentable` SwiftUI View containing a UISearchBar is integrated
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
    @State var searchText: String = ""
    
    var body: some View {
        VStack {
            SearchBar(text: $searchText)
            
            List {
                let filteredFrameworks = appleFrameworks.filter { searchText.isEmpty ? true : $0.localizedCaseInsensitiveContains(searchText) }
                ForEach(filteredFrameworks, id: \.self) { frameworkName in
                    Text(frameworkName)
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
