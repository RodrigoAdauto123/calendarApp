//
//  CalendarAppApp.swift
//  CalendarApp
//
//  Created by Rodrigo Adauto Ortiz on 21/05/24.
//

import SwiftUI
import SwiftData

@main
struct CalendarAppApp: App {
    @Environment(\.modelContext) private var context
    var body: some Scene {
        WindowGroup {
            MainView()
        }
        .modelContext(context)
    }
}
