//
//  VRG_TestAppApp.swift
//  VRG_TestApp
//
//  Created by Дима Губеня on 07.11.2025.
//

import SwiftUI

@main
struct VRG_TestAppApp: App {
    
    let persistenceController = CoreDataManager.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.context)
        }
    }
}
