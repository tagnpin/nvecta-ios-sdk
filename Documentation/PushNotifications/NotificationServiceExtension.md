# Notification Service Extension

Notification Service Extension has been introduced in iOS 10 by Apple which allows you to add images, audio or video content to your push notification. NVECTA SDK will use it to enable you to add Action buttons, badge counts, and to track delivery counts in your NVECTA panel as well. So It is an Important step which you need to configure properly as described in this documentation.

Official Documentation:  
https://www.nvecta.com/docs/notification-service-extension

---

## 1. Add Notification Service Extension

**1.1.** Create `Notification Service Extension` in your project to do so in Xcode go to `File >> New >> Target`.

**1.2** Now Select `Notification Service Extension` template under iOS section of the dialog box and click the next button to proceed.

![Notification Service Extension Template Selection](../Images/notification-service-ext/nse-template.png)

**1.3** In the next prompt, provide the name of the extension target and select the programming language which you want to use and then click on the Finish button as shown in the screenshot below.

![Notification Service Extension Name & Language Selection](../Images/notification-service-ext/nse-name-and-language.png)

**1.4** Once the target is created, press 'Cancel' when prompted to activate the scheme. After this your notification service extension will be added to the project you will see a class with the extension name you specified during creation, as well as an info.plist file associated with it.

### Swift

![Notification Service Extension Swift Project Navigator](../Images/notification-service-ext/nse-project-navigator-swift.png)

<details>
    <summary>Objective-C</summary>

![Notification Service Extension Objective-C Project Navigator](../Images/notification-service-ext/nse-project-navigator-objc.png)

</details>

<br>

**1.5** Now we can proceed to add further configuration to this newly created target. Under this target you need to complete Import NVECTA SDK, Configure info.plist, add code to NotificationService file and configure AppGroup properly to complete this setup.

Further steps are defined below in detail to complete this setup.

## 2. Import Notification Service SDK into Notification Service Extension Target:

### Install Notification Service SDK

Same as we did in main target you can install our Notifiation Service extension SDK into your application's `Notification Service Extension` target using any of the following methods:

1. [Swift Package Manager (Recommended)](./Documentation/Installation/SwiftPackageManager.md)
2. [CocoaPods](./Documentation/Installation/CocoaPods.md)

### Import Notification Service SDK

Goto yoyr NotificationService.swift/NotificationService.m file inside your `Notification Service Extension` tager sirce code files and Import `notifyvisitorsNotificationService` SDK to use it inside it.

##### Swift

```swift
import UserNotifications
import notifyvisitorsNotificationService
```

<details>
<summary>Objective-C</summary>

```objective-c
#import "UserNotifications.h"
#import <notifyvisitorsNotificationService/notifyvisitorsNotificationService.h>
```

</details>

## 3. Configure the Notification Service Extension info.plist

Open your iOS project in Xcode, select the `Notification Service Extension` target, and open its `Info.plist` file as source code (right click on `info.plist` and click on `Open as >> Source code`) and add the following code in it.

```xml
<key>App Bundle identifier</key>
         <string>YOUR_APP_MAIN_TARGRT_BUNDLE_ID</string>
         <key>NSExtension</key>
         <dict>
                     <key>NSExtensionPointIdentifier</key>
                     <string>com.apple.usernotifications.service</string>
                     <key>NSExtensionPrincipalClass</key>
                     <string>$(PRODUCT_MODULE_NAME).NotificationService</string>
                     <key>NSExtensionAttributes</key>
                    <dict>
                               <key>UNNotificationExtensionDefaultContentHidden</key>
                               <true/>
                               <key>UNNotificationExtensionInitialContentSizeRatio</key>
                               <real>0.7</real>
                    </dict>
         </dict>
```

> **Important**
>
> The value of **App Bundle identifier** must exactly match the **Bundle Identifier** of your application's main target. An incorrect value may prevent the Notification Service Extension from communicating with the main application.

## 4. Configure Push in SignIn and Capabilities:

Go to `Signing & Capabilities` tab of your `Notification Service Extension` target and click on `+` symbol on the left corner of this tab and add `Push Notifications` and if you have upgraded `Xcode` and `Push Notifications` was already added in previous version of Xcode then remove `Push Notifications` and add it again to configure push notification properly for the upgraded devices.

![Notification Service Extension Push Capabilities](../Images/notification-service-ext/nse-push-capabilities.png)

## 5. Modify Push Payload in Notification Service Extension

Now you need to update the code to download and attach media content if available in your push payload to display rich media content (`image, audio or video`). To do so, go to your `NotificationService.swift/NotificationService.m` file simple replace the existing code as shown below example.

### Swift

```swift
import UserNotifications
import notifyvisitorsNotificationService

class NotificationService: notifyvisitorsNotificationService {

    var contentHandler: ((UNNotificationContent) -> Void)?
    var bestAttemptContent: UNMutableNotificationContent?

    override func didReceive(_ request: UNNotificationRequest, withContentHandler contentHandler: @escaping (UNNotificationContent) -> Void) {
        super.didReceive(request, withContentHandler: contentHandler)
    }

}
```

</details>
<details>
    <summary>Objective-C</summary>

```objC

#import "NotificationService.h"
#import <notifyvisitorsNotificationService/notifyvisitorsNotificationService.h>

@interface NotificationService ()

@property (nonatomic, strong) void (^contentHandler)(UNNotificationContent *contentToDeliver);
@property (nonatomic, strong) UNMutableNotificationContent *bestAttemptContent;

@end

@implementation NotificationService

- (void)didReceiveNotificationRequest:(UNNotificationRequest *)request withContentHandler:(void (^)(UNNotificationContent * _Nonnull))contentHandler {
    self.contentHandler = contentHandler;
    self.bestAttemptContent = [request.content mutableCopy];

    [notifyvisitorsNotificationService didReceiveNotificationRequest: request withBestAttemptContent: self.bestAttemptContent withContentHandler: self.contentHandler];

}

- (void)serviceExtensionTimeWillExpire {
    // Called just before the extension will be terminated by the system.
    // Use this as an opportunity to deliver your "best attempt" at modified content, otherwise the original push payload will be used.
    self.contentHandler(self.bestAttemptContent);

    [notifyvisitorsNotificationService serviceExtensionTimeWillExpire];
}

@end
```

</details>

## ⚠️ Important Note

Once the above steps are completed, your app will be able to receive rich push. Action Buttons and badge counts can be displayed but till now delivery count is not enabled so you will see 0 as delivery count. To enable push delivery count in from your app to our panel, you need to follow the next step to configure AppGroup properly to enable delivery count.

<br>

# 6. Configure App Groups for All Targets:

Let's set up `AppGroups` in your app to count push deliveries in your NVECTA panel. First, we'll select an `AppGroupID` and set it up in each of the `info.plist` of your two targets (i.e. Your App's `Main Target` and Your `Notification Service Extension Target`), and then we'll use the same `AppGroupID` to create and activate the same `AppGroup` in both target’s `Signing & Capabilities` Tabs. To configure this way, follow the steps listed below.

**6.1.** Let’s assume the `AppGroupID` we want to use is `group.{Your App Bundle Identifier}.NVECTA` where `{Your App Bundle identities}` is the same as your App Bundle Identifier of your Main App Target.

**6.2.** Now from the Project Navigator, go to your Main App project target, open `info.plist` as source code (right-click on `info.plist` and select `Open as >> Source code`), and paste the following code into it.

```xml
<key>nvAppGroupKey</key>
    <string>group.{Your App Bundle Identifier}.NVECTA</string>
```

### OR

You can simply open the `info.plist`, add a new row, and define a `nvAppGroupKey` as a `String` with a value of `group.{your app bundle identifier}.NVECTA`

![Notification Service Extension Custom AppGroup ID](../Images/notification-service-ext/nse-info-plist-custom-app-group-id.png)

**6.3.** Repeat `step 6.2` for the `info.plist` file in your `Notification Service Extension` Target project folder and enter the exact same key and values as in `step 6.2`.

## 📘 Note

Make sure it is `case sensitive` and is exactly the same in both the `info.plist` files.

**6.4.** Now, from the Project Navigator, select your app's Main Target and go to the `Signing & Capabilities` tab. If `App Groups` have not already been added, click `+ Capabilities` symbol in the left corner of this tab and add `App Groups`, as shown in the screenshot below.

![Main Target AppGroup Capabilities](../Images/notification-service-ext/main-target-app-group-capabilites.png)

**6.5.** Once you have finished adding `AppGroups` capabilities you will be able to see it in your `Signing & Capabilities` and then under `AppGroups` click `+` button to create a new app group with the same name as the value added to `info.plist` for both targets (i.e `group.{Your App Bundle Identifier}.NVECTA`), as shown in the screenshot below. Finally, click OK.

![New AppGroup ID](../Images/notification-service-ext/nse-app-group-id.png)

**6.6. Example:** If you have set the `AppGroupID` to `group.com.mySampleiOSApp.NVECTA` in both `info.plist` files, then add the same `AppGroup` to `Signing & Capabilities`, and ensure that this newly created `AppGroup` is checked (Turned On), as shown in the screenshot below.

![Active AppGroup ID](../Images/notification-service-ext/nse-active-app-group-id.png)

**6.7.** Once you have configured `AppGroups` in your `Main App Target`, you must `activate` the same `AppGroup` in your `Notification Service Extension Target`. To do so, select your `Notification Service Extension target` from the Project Navigator and go to the `Signing & Capabilities` tab. If `AppGroups` have not already been added, click the `+ Capabilities` symbol in the left corner of this tab and add `App Groups` as shown in the screenshot below.

![Notification Service Extension AppGroup Capabilities](../Images/notification-service-ext/nse-app-group-capabilites.png)

Once you've added `AppGroups capabilities`, you'll be able to see them in your `Notification Service Extension` Target's `Signing & Capabilities`. If a previously created `AppGroupID` isn't visible, click the refresh button next to the `+` symbol under `App Groups` to refresh the list of `AppGroups` configured in your Apple Developer account. Select the previously created app group and ensure that the same `AppGroupID` is checked (Turned on) in your `Notification Service Extension Target` as you did for your `Main App Target`.

**Example:** You have recently created an `AppGroupID` called `group.com.mySampleiOSApp.NVECTA` for your `Main App Target`, and make sure the same `AppGroupID` is visible and checked (Turned On) in the `Signing & Capabilities` of your `Notification Service Extension Target`.

![Active AppGroup ID](../Images/notification-service-ext/nse-active-app-group-id.png)

---

# Support

If you encounter any issues during integration:

- Contact the NVECTA Support Team.
- Raise a support request from the NVECTA Dashboard.
