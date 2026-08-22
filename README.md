![NVECTA logo; Formerly NotifyVisitors](https://i.ibb.co/MybKMHDm/NVECTA-000.jpg)

# NVECTA iOS SDK

![iOS 13.0+](https://img.shields.io/badge/iOS-13.0%2B-blue.svg) [![SwiftPM compatible](https://img.shields.io/badge/SwiftPM-compatible-brightgreen.svg)](https://swift.org/package-manager/) ![Formerly](https://img.shields.io/badge/Formerly-Notifyvisitors-blue)

## 🚀 Quick Introduction

The NVECTA iOS SDK helps you integrate powerful customer engagement and analytics features into your native iOS mobile applications. With NVECTA, you can track user activity, send personalized notifications, and improve user engagement through real-time insights and communication tools.

To learn more, visit our [website](https://www.nvecta.com/) and explore the [documentation](https://www.nvecta.com/docs/getting-started-2) for installation and setup guidance.

Ready to get started? [Sign up here](https://console.notifyvisitors.com/console/account/login) to create your account.

<br>

## 📋 Requirements

- iOS 13.0 or later
- Xcode 26.0 or later

## 🎉 Installation

NVECTA iOS SDK can be integrated into your application using any of the following methods:

1. [Swift Package Manager (Recommended)](./Documentation/Installation/SwiftPackageManager.md)
2. [CocoaPods](./Documentation/Installation/CocoaPods.md)
3. [Manual Installation](./Documentation/Installation/Manual.md)

Choose the installation method that best matches your project's dependency management strategy.

## 📦 Integrate NVECTA into Your iOS App

After installing the SDK, complete the following configuration steps.

### 1. Configure Info.plist

Open **Info.plist** and add the following keys.

```xml
<key>CFBundleURLTypes</key>
  <array>
        <dict>
            <key>CFBundleURLName</key>
     	        <string>$(PRODUCT_BUNDLE_IDENTIFIER)</string>
            <key>CFBundleURLSchemes</key>
             	<array>
                    <string>YOUR_URL_SCHEME_COMES_HERE</string>
                </array>
     	</dict>
    </array>

<key>nvBrandID</key>
    <integer>YOUR_BRAND_ID</integer>

<key>nvSecretKey</key>
    <string>YOUR_SECRET_KEY</string>

<key>nvPushCategory</key>
    <string>nvpush</string>

<key>nvViewAutoRedirection</key>
    <true/>
```

#### SDK Configuration

| Key                     | Type    | Description                                                   |
| ----------------------- | ------- | ------------------------------------------------------------- |
| `CFBundleURLTypes`      | Array   | Configures the custom URL scheme used for deep-link handling. |
| `nvBrandID`             | Number  | Your NVECTA Brand ID                                          |
| `nvSecretKey`           | String  | Your NVECTA Secret Key                                        |
| `nvPushCategory`        | String  | Push NVECTA category. Use the default value: `nvpush`.        |
| `nvViewAutoRedirection` | Boolean | Enables automatic view redirection when configured properly.  |

> **Tip**
>
> You can edit `Info.plist` either as a **Property List** or as **Source Code**. Both approaches produce the same result.

> **Important**
>
> Replace the sample values above with your actual Brand ID and Secret Key available from the NVECTA Dashboard.

---

### 2. Configure AppDelegate

The SDK uses iOS application lifecycle callbacks to support:

- SDK Initialisation and lifecycle management
- Session tracking
- Analytics
- Deep-link handling

#### Import NVECTA SDK

Import NVECTASDK in every class file where you need to access any function from the NVECTA iOS SDK.

##### Swift

```swift
import UIKit
import NVECTASDK
```

<details>
<summary>Objective-C</summary>

```objective-c
#import "AppDelegate.h"
#import <NVECTASDK/NVECTASDK-Swift.h>
```

</details>

#### Initialize NVECTA SDK

Initialize the SDK in your `AppDelegate`file and forward the following app lifecycle delegate from your `AppDelegate`.

### Swift

```swift
import UIKit
import NVECTASDK

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        var nvMode:String? = nil

         #if DEBUG
             nvMode = "debug"
         #else
             nvMode = "live"
        #endif

        NVECTA.shared.register(mode: nvMode!)

        return true
    }

    override func applicationDidEnterBackground(
        _ application: UIApplication
    ) {
       NVECTA.shared.applicationDidEnterBackground(application)
    }

    override func applicationWillEnterForeground(
        _ application: UIApplication
    ) {
       NVECTA.shared.applicationWillEnterForeground(application)
    }

    override func applicationDidBecomeActive(
        _ application: UIApplication
    ) {
        NVECTA.shared.applicationDidBecomeActive(application)
    }

    override func applicationWillTerminate(
        _ application: UIApplication
    ) {
       NVECTA.shared.applicationWillTerminate(application)
    }

    override func application(
        _ app: UIApplication,
        open url: URL,
        options: [UIApplication.OpenURLOptionsKey : Any] = [:]
    ) -> Bool {

        NVECTA.shared.application(app, open: url, options: options)

        return true
    }
}
```

<details>
<summary>Objective-C</summary>

```objective-c
#import "AppDelegate.h"
#import <NVECTASDK/NVECTASDK-Swift.h>

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application
didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    NSString *nvMode = nil;

    #if DEBUG
       nvMode = @"debug";
    #else
       nvMode = @"live";
    #endif

    [[NVECTA shared] register: nvMode];

    return YES;
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    [[NVECTA shared] applicationDidEnterBackground:application];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    [[NVECTA shared] applicationWillEnterForeground:application];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    [[NVECTA shared] applicationDidBecomeActive:application];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    [[NVECTA shared] applicationWillTerminate: application];
}

- (BOOL)application:(UIApplication *)app
            openURL:(NSURL *)url
            options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {

    [[NVECTA shared] openUrl:app openURL:url options: options];

    return YES;
}

@end

```

</details>

### Lifecycle Methods

| Method                             | Description                                                          |
| ---------------------------------- | -------------------------------------------------------------------- |
| `register()`                       | Initializes the SDK.                                                 |
| `applicationDidEnterBackground()`  | Notifies the SDK when the application enters the background.         |
| `applicationWillEnterForeground()` | Notifies the SDK when the application returns to the foreground.     |
| `applicationDidBecomeActive()`     | Starts or resumes SDK session tracking.                              |
| `applicationWillTerminate()`       | Allows the SDK to perform cleanup before the application terminates. |
| `openUrl()`                        | Handles custom URL schemes and deep links.                           |

> **Note**
>
> These lifecycle callbacks are required for proper SDK functionality, including analytics, session tracking, and deep-link processing. If your application uses `SceneDelegate`, some application lifecycle events are handled by the scene lifecycle methods instead of the corresponding `AppDelegate` methods. See the next section for the required configuration.

---

### 3. Configure SceneDelegate

If your application uses Apple's `SceneDelegate` architecture, some lifecycle and URL events are delivered through `SceneDelegate` instead of `AppDelegate`.

In this case, forward the corresponding scene lifecycle callbacks to the NVECTA SDK.

> **Important**
>
> Do not implement duplicate lifecycle handling in both `AppDelegate` and `SceneDelegate` unless your application architecture specifically requires it. Forward each event from the lifecycle component that receives it.

### Swift

```swift
import UIKit
import NVECTASDK

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let _ = (scene as? UIWindowScene) else { return }
        NVECTA.shared.scene(scene, willConnectTo: session, options: connectionOptions)
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        NVECTA.shared.sceneDidBecomeActive(scene)
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        NVECTA.shared.sceneWillEnterForeground(scene)
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        NVECTA.shared.sceneDidEnterBackground(scene)
    }

    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        NVECTA.shared.scene(scene, openURLContexts: URLContexts)
    }

}
```

<details>
<summary>Objective-C</summary>

```objective-c
#import "SceneDelegate.h"
#import <NVECTASDK/NVECTASDK-Swift.h>

@implementation SceneDelegate


- (void)scene:(UIScene *)scene willConnectToSession:(UISceneSession *)session options:(UISceneConnectionOptions *)connectionOptions  API_AVAILABLE(ios(13.0)){

    [[NVECTA shared] scene: scene willConnectToSession: session options: connectionOptions];
}

- (void)sceneDidBecomeActive:(UIScene *)scene  API_AVAILABLE(ios(13.0)){

    [[NVECTA shared] sceneDidBecomeActive: scene];
}

- (void)sceneWillEnterForeground:(UIScene *)scene  API_AVAILABLE(ios(13.0)){
    [[NVECTA shared] sceneWillEnterForeground: scene];
}

- (void)sceneDidEnterBackground:(UIScene *)scene  API_AVAILABLE(ios(13.0)){
    [[NVECTA shared] sceneDidEnterBackground: scene];
}

- (void)scene:(UIScene *)scene openURLContexts:(NSSet<UIOpenURLContext *> *)URLContexts  API_AVAILABLE(ios(13.0)){
    [[NVECTA shared] scene: scene openURLContexts: URLContexts];
}

@end
```

</details>

### Lifecycle Methods (SceneDelegate)

| Method                            | Description                                                                                                                           |
| --------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------- |
| `scene(_:willConnectTo:options:)` | Notifies the SDK when a scene is connected and provides the initial scene connection options, including URL or deep-link information. |
| `sceneDidEnterBackground()`       | Notifies the SDK when the application enters the background.                                                                          |
| `sceneWillEnterForeground()`      | Notifies the SDK when the application returns to the foreground.                                                                      |
| `sceneDidBecomeActive()`          | Starts or resumes SDK session tracking.                                                                                               |
| `scene(_:openURLContexts:)`       | Handles custom URL schemes and deep links.                                                                                            |

> **Note**
>
> These lifecycle callbacks are required for proper SDK functionality, including analytics, session tracking, and deep-link processing. If your application uses `SceneDelegate`, implement the required callbacks and forward the relevant events to the SDK.

---

## 🎯 Migration

- [CocoaPods to Swift Package Manager](./Documentation/Migration/CocoaPodsToSPM.md)
- [Manual XCFramework to Swift Package Manager](./Documentation/Migration/ManualToSPM.md)

<br>
The SDK is now initialized and ready to use.

## 📊 What's Next? SDK Features & Guides

Explore the following guides to learn how to use key NVECTA SDK features in your iOS application.

### 🎯 Tracking Screens

Track user screen interactions to better understand user app behavior and engagement within your application.

➡️ [View Screen Tracking Documentation](./Documentation/Features/ScreenTracking.md)

### 🔔 Push Notifications

Configure and send push notifications to re-engage users with real-time updates and personalized communication.

➡️ [View Push Notification Documentation](./Documentation/PushNotifications/PushAppConfiguration.md)

### 🎯 Tracking Events

Track user interactions and custom events to better understand user behavior and engagement within your application.

➡️ [View Event Tracking Documentation](./Documentation/Features/EventTracking.md)

### 👤 Tracking Users

Identify users, manage user profiles, and associate user activity for personalized engagement and analytics.

➡️ [View User Tracking Documentation](./Documentation/Features/UserTracking.md)

### 💬 In-App Notifications & Nudges

Display targeted in-app messages and campaigns to engage users while they are actively using the application.

➡️ [View In-App Notification Documentation](./Documentation/Features/InAppNotifications.md)

### 🎯 In-App Nudges

Guide users with contextual nudges such as embedded banners, cards, tooltips, and other native UI elements to improve engagement and conversions.

➡️ [View In-App Nudges Documentation](./Documentation/Features/InAppNudges.md)

### 📥 Notification Center

Manage and display user notifications within a centralized in-app notification center experience.

➡️ [View Notification Center Documentation](./Documentation/Features/NotificationCenter.md)

<br>

## Troubleshooting

- [Common Issues](./Documentation/Troubleshooting/CommonIssues.md)
