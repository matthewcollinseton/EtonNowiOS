//
//  AppDelegate.swift
//  EtonNowiOS
//
//  Created by Collins, Matthew - MC on 24/02/2024.
//

import Foundation
import UIKit
import UserNotifications

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { allowed, error in
            if allowed {
                // register for remote push notification
                DispatchQueue.main.async {
                    UIApplication.shared.registerForRemoteNotifications()
                }
                print("Push notification allowed by user")
            } else {
                print("Error while requesting push notification permission. Error \(error?.localizedDescription ?? "error")")
            }
        }
        return true
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let tokenString = deviceToken.reduce("", {$0 + String(format: "%02x", $1)})
        print("Device push notification token - \(tokenString)")
    }

    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Failed to register for remote notification. Error \(error) moogie")
    }
}
