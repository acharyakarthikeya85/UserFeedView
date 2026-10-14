//
//  UserFeedViewApp.swift
//  UserFeedView
//
//  Created by Karthikeya K on 13/10/26.
//

import SwiftUI

@main
struct UserFeedViewApp: App {
    // Flag to lock the UI if jailbreak indicators are caught
    @State private var isSecurityCompromised = false
    var body: some Scene {
        WindowGroup {
            if isSecurityCompromised {
                // Secure blocking view preventing data exposure
                VStack(spacing: 16) {
                    Image(systemName: "shield.slash.fill")
                        .font(.system(size: 64))
                        .foregroundColor(.red)
                    
                    Text("Security Alert")
                        .font(.title)
                        .bold()
                    
                    Text("This application cannot run on a modified or jailbroken operating system due to data safety constraints.")
                        .font(.body)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 32)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color(.systemBackground))
            } else {
                // Normal application flow
                PostListView()
                    .onAppear {
                        // Perform the check as soon as the main view draws
                        if JailbreakCheckService.isDeviceJailbroken() {
                            isSecurityCompromised = true
                        }
                    }
            }
        }
    }
}
