//
//  SiriHelper.swift
//  SiriKitTry
//
//  Created by Daniel Vela Angulo on 10/10/2018.
//  Copyright © 2018 veladan. All rights reserved.
//

import Foundation
import UIKit
import Intents
import CoreSpotlight
import CoreServices

class SiriHelper {
    public static var siriAvailable: Bool = false

    static func requireAuthorizationIfNeeded() {
        let status = INPreferences.siriAuthorizationStatus()
        switch status {
        case .notDetermined:
            INPreferences.requestSiriAuthorization { (newStatus) in
                // New status
                if newStatus == .authorized {
                    siriAvailable = true
                } else {
                    siriAvailable = false
                }
            }
        case .restricted:
            // Restricted. The app is not authorized to use Siri services. This status could be the result of active
            // restrictions on Siri services rather than on the user denying access.
            siriAvailable = false
            break
        case .denied:
            // The user explicitly denied authorization for this app.
            siriAvailable = false
            break
        case .authorized:
            // Authorized. Siri is enabled and your app is authorized to interact with it.
            siriAvailable = true
            break
        }

    }

    static func donateAskForACoffee(_ viewController: UIViewController) {
        let userActivity = NSUserActivity(activityType: NSUserActivity.askForACoffeType)
        userActivity.isEligibleForSearch = true
        userActivity.isEligibleForPrediction = true  // To add it to Siri Shortcuts
        userActivity.title = "¿Quieres un café?"
        userActivity.userInfo = ["key": "askForCoffee"]
        userActivity.suggestedInvocationPhrase = "Quiero un café"
        #if canImport(CoreSpotlight)
            let attributes = CSSearchableItemAttributeSet(itemContentType: kUTTypeContent as String)
            attributes.thumbnailData = #imageLiteral(resourceName: "tomato").pngData() // Used as an icon in Search.
            attributes.keywords = ["Order", "Coffe"]
            attributes.displayName = "Ordenar café"
            attributes.contentDescription = "Para ordenar un café"
            userActivity.contentAttributeSet = attributes
        #endif
        viewController.userActivity = userActivity
    }

    static func suggestShortcut() {
        // Add a user activity to the list of suggestions.
//        var suggestions = [INShortcut(userActivity: orderFavoriteBeverageUserActivity)]

//        // Add an intent to the list of suggestions. To create
//        // a shortcut from an intent, the intent must be valid.
//        if let shortcut = INShortcut(intent: orderSoupOfTheDayIntent) {
//            suggestions.append(shortcut)
//        }
        // Suggest the shortcuts.
//        INVoiceShortcutCenter.shared.setShortcutSuggestions(suggestions)

//        let shortcut = [INShortcut(userActivity: orderSoupOfTheDayIntent)]
//
//        // Suggest the shortcuts.
//        INVoiceShortcutCenter.shared.setShortcutSuggestions(shortcut)
    }
}
