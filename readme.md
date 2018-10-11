# SiriKit

https://developer.apple.com/documentation/sirikit#2979425


## NSUserActivity

- From https://developer.apple.com/videos/play/wwdc2018/211/

Able to:
- To open something in your app
- Spotlight 
- Handoff

How to adopt:

- Define your shortcut: Add to your Info.plist

        <key>NSUserActivityTypes</key>
        <array>
        <string>com.myapp.name.my-activity-type</string>
        </array>

- Donate your shortcut:

        let userActivity = NSUserActivity(activityType: NSUserActivity.viewMenuActivityType)  // com.myapp.name.my-activity-type
        userActivity.isElegibleForSearch = true
        userActivity.isEligibleForPrediction = true  // To add it to Siri Shortcuts
        userActivity.title = "Titulo"
        userActivity.userInfo = ["key": "value"]
        userActivity.suggestedInvocationPhrase = "I wnat a coffee"
        #if canImport(CoreSpotlight)
            let attributes = CSSearchableItemAttributeSet(itemContentType: kUTTypeContent as String)
            attributes.thumbnailData = #imageLiteral(resourceName: "tomato").pngData() // Used as an icon in Search.
            attributes.keywords = ["Order", "Soup", "Menu"]
            attributes.displayName = NSLocalizedString("ORDER_LUNCH_TITLE", comment: "View menu activity title")
            let localizationComment = "View menu content description"
            attributes.contentDescription = NSLocalizedString("VIEW_MENU_CONTENT_DESCRIPTION", comment: localizationComment)
            userActivity.contentAttributeSet = attributes
        #endif
        viewController.userActivity = userActivity

- Handle shortcut activation:

        func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
            if userActivity.activityType == "com.myapp.name.my-activity-type" {
            // restore state for userActivity
            }
        }



## Intents

- More info https://developer.apple.com/videos/play/wwdc2018/214/


- Custom UI
- Custom voice response
- Relevant intents


