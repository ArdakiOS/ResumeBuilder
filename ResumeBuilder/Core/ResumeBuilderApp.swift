//
//  ResumeBuilderApp.swift
//  ResumeBuilder
//
//  Created by Ardak Tursunbayev on 18.12.2024.
//

import SwiftUI
import ApphudSDK

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
//        Apphud.start(apiKey: "app_CnVzrjreCtVwWEMPqg2naTytdJZDCu") //PROD KEY
        Apphud.start(apiKey: "app_qzQufrUDpx4RwSgorgiw7qbf8KzFW4") //TEST KEY
        return true
    }
}

@main
struct AIFishChatApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @StateObject private var subsMan = ApphudSubsManager()
    var body: some Scene {
        WindowGroup {
            NavigationStack{
                ContentView()
                    .preferredColorScheme(.light)
                    .environmentObject(subsMan)
            }
        }
    }
}
