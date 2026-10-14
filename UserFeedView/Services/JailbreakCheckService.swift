//
//  JailbreakCheckService.swift
//  UserFeedView
//
//  Created by Karthikeya K on 14/10/26.
//

import Foundation
import UIKit

final class JailbreakCheckService: Sendable {
    /// Executes basic ambient checks to verify device integrity.
    static func isDeviceJailbroken() -> Bool {
        #if targetEnvironment(simulator)
        return false
        #else
        
        // Check 1: Search for common jailbreak application paths & binaries
        let commonJailbreakPaths = [
            "/Applications/Cydia.app",
            "/Applications/FakeCarrier.app",
            "/Applications/Icy.app",
            "/Applications/Sileo.app",
            "/Library/MobileSubstrate/MobileSubstrate.dylib",
            "/bin/bash",
            "/usr/sbin/sshd",
            "/etc/apt",
            "/usr/bin/ssh"
        ]
        
        for path in commonJailbreakPaths {
            if FileManager.default.fileExists(atPath: path) {
                return true
            }
        }
        
        // Check 2: Sandbox Violation Test (Attempting to write outside the app sandbox container)
        let testString = "Jailbreak Sandbox Test Data"
        let systemRootPath = "/private/jailbreak_test.txt"
        
        do {
            try testString.write(toFile: systemRootPath, atomically: true, encoding: .utf8)
            // If the write succeeds without throwing an error, the app sandbox has been broken.
            // Clean up the file and flag the security breach.
            try FileManager.default.removeItem(atPath: systemRootPath)
            return true
        } catch {
            // A healthy, locked sandbox will fail to write here, throwing an error correctly.
        }
        
        // Check 3: Check system URI schemes (Seeing if Cydia opens)
        if let cydiaURL = URL(string: "cydia://package/com.example.test") {
            if UIApplication.shared.canOpenURL(cydiaURL) {
                return true
            }
        }
        
        return false
        #endif
    }
}
