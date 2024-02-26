//
//  AppDelegate.swift
//  Cloud Demo
//
//  Created by Ankit Sharma on 26/02/24.
//

import UIKit
import MobileRTC
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    // Your JWT Token should NEVER be publicly accessible.
    // We are hardcoding these values here for demonstration purposes only.
    // For your production app, generate a JWT on the server side instead of storing it directly on the Client.
    let jwtToken = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhcHBLZXkiOiJNNkpsVzJXRlNmNmwzYVA4Sm9JUGciLCJpYXQiOjE3MDg5NDUyODEsInRva2VuRXhwIjoxNzA4OTQ4ODgxLCJleHAiOjM0MTc5NzY5NjJ9.Xwczg36Df2iwuVqcvGJfEi2RnmOf9Z8R7vUStrBjKzc"
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setupSDK(jwtToken: jwtToken)
        return true
    }
    /// setupSDK Creates, initializes, and authorizes an instance of the Meeting SDK. Call this before calling any other SDK functions.
    /// - Parameters:
    ///   - jwtToken: A valid generated JWT.
    func setupSDK(jwtToken: String) {
        // Create a MobileRTCSDKInitContext. This class contains attributes for determining how the SDK will be used. You must supply the context with a domain.
        let context = MobileRTCSDKInitContext()
        // The domain we will use is zoom.us
        context.domain = "zoom.us"
        // Turns on SDK logging. This is optional.
        context.enableLog = true
        // Call initialize(_ context: MobileRTCSDKInitContext) to create an instance of the Zoom SDK. Without initialization, the SDK will not be operational. This call will return true if the SDK was initialized successfully.
        let sdkInitializedSuccessfully = MobileRTC.shared().initialize(context)
        // Check if initialization was successful. Obtain a MobileRTCAuthService, this is for supplying credentials to the SDK for authorization.
        if sdkInitializedSuccessfully == true, let authorizationService = MobileRTC.shared().getAuthService() {
// Supply the SDK with a JWT.
            authorizationService.jwtToken = jwtToken
            // Assign AppDelegate to be a MobileRTCAuthDelegate to listen for authorization callbacks.
            authorizationService.delegate = self
            // Call sdkAuth to perform authorization.
            authorizationService.sdkAuth()
        }
    }
}
// MARK: - MobileRTCAuthDelegate
// Conform AppDelegate to MobileRTCAuthDelegate.
// MobileRTCAuthDelegate listens to authorization events like SDK authorization, user login, etc.
extension AppDelegate: MobileRTCAuthDelegate {
    // Result of calling sdkAuth(). MobileRTCAuthError_Success represents a successful authorization.
    func onMobileRTCAuthReturn(_ returnValue: MobileRTCAuthError) {
        switch returnValue {
        case MobileRTCAuthError.success:
            print("SDK successfully initialized.")
        case MobileRTCAuthError.tokenWrong:
            assertionFailure("JWT Token Authentication is invalid.")
        case MobileRTCAuthError.networkIssue:
            print("network issue")
        default:
            assertionFailure("SDK Authorization failed with MobileRTCAuthError: \(returnValue).")
        }
    }
  }

