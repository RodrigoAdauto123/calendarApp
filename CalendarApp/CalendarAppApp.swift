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
    @State private var isAuthenticated: Bool = false
    @State private var showFailedAuthAlert = false
    @State private var showUnavailableAuthAlert = false
    private let biometricIDAuth = BiometricIDAuth()
    @StateObject private var audioRecorder = AudioRecorder()

    var body: some Scene {
        WindowGroup {
            if isAuthenticated {
                MainView()
                    .environmentObject(audioRecorder)
            } else {
                CalendarSplashView()
                    .onAppear() {
                        authenticatedUser()
                    }
                    .alert("You need available Biometric Authentication",
                           isPresented: $showUnavailableAuthAlert) {
                        Button("Retry", role: .cancel) {
                            showUnavailableAuthAlert = false
                            authenticatedUser()
                        }
                    }
                    .alert("Failed to authenticated", isPresented: $showFailedAuthAlert) {
                        Button("Retry", role: .cancel) {
                            showFailedAuthAlert = false
                            authenticatedUser()
                        }
                    }
            }
        }
        .modelContainer(for: [Task.self])
    }
    
    private func authenticatedUser() {
        biometricIDAuth.canEvaluate { canEvaluate, _, error in
            guard canEvaluate else {
                showUnavailableAuthAlert = true
                return
            }
            biometricIDAuth.evaluatePolicy { success, error in
                if success {
                    isAuthenticated = true
                } else {
                    showFailedAuthAlert = true
                }
            }
        }
    }
}

struct LoadingView: View {
    var body: some View {
        VStack {
           
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .edgesIgnoringSafeArea(.all)
        .background(Color.blue)
    }
}
