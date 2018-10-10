//
//  SiriHelper.swift
//  SiriKitTry
//
//  Created by Daniel Vela Angulo on 10/10/2018.
//  Copyright © 2018 veladan. All rights reserved.
//

import Intents

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
}
