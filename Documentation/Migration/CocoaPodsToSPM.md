# Migrating from CocoaPods to Swift Package Manager

This guide explains how to migrate an existing `notifyvisitors` iOS SDK integration from `CocoaPods` to `Swift Package Manager (SPM)`.

Swift Package Manager is the recommended dependency management method for new and existing `NVECTA` iOS SDK integrations.

The migration can be performed in two stages:

1. Migrate the SDK dependency from `CocoaPods` to `Swift Package Manager`.
2. Optionally migrate the existing `notifyvisitors` integration to `NVECTASDK`.

<br>

> **Recommended:** Existing users of `notifyvisitors` should migrate to `NVECTASDK` when possible. Most existing SDK functionality has a direct equivalent, with only a limited number of APIs renamed to follow modern Swift naming conventions.

---

## Migration Options

If your application currently uses `notifyvisitors` through `CocoaPods`, you have two migration options.

### Option 1 — Migrate to SPM and upgrade to NVECTASDK ⭐ Recommended

Move the dependency from `CocoaPods` to `Swift Package Manager` and migrate your application from:

```text
notifyvisitors
```

to:

```text
NVECTASDK
```

This is the recommended migration path.

Most existing SDK functionality can be migrated directly to the new SDK. Only a limited number of APIs have been renamed or adjusted to follow modern Swift API conventions.

Benefits include:

- Modern Swift API
- Swift-friendly naming
- Recommended SDK architecture
- Future SDK development will primarily target the new API
- Removes the CocoaPods dependency
- Uses Swift Package Manager for SDK distribution

---

### Option 2 — Migrate to SPM and continue using `notifyvisitors`

If you are not ready to migrate your application code to `NVECTASDK`, you can migrate only the dependency management system.

The resulting configuration will be:

```text
CocoaPods
    ↓
notifyvisitors
```

becomes:

```text
Swift Package Manager
    ↓
notifyvisitors
```

Your existing `notifyvisitors` SDK integration can continue to work without changing the SDK APIs.

This option is useful when:

- You want to remove CocoaPods first.
- You need a low-risk dependency migration.
- You want to migrate application code separately.
- Your application is not ready to adopt the new Swift API.

However, we recommend upgrading to `NVECTASDK` when practical.

---

## Recommended Migration Path

For an application currently using:

```text
CocoaPods
    ↓
notifyvisitors
```

the recommended final configuration is:

```text
Swift Package Manager
    ↓
NVECTASDK
```

This separates the migration into two logical changes:

```text
Dependency Migration

CocoaPods
    ↓
Swift Package Manager


SDK API Migration

notifyvisitors
    ↓
NVECTASDK
```

You can perform both changes together or perform them separately.

## Migration Matrix

| Current Integration          | Recommended Destination | Application Code Changes |
| ---------------------------- | ----------------------- | ------------------------ |
| CocoaPods + `notifyvisitors` | SPM + `NVECTASDK` ⭐    | Small API migration      |
| CocoaPods + `notifyvisitors` | SPM + `notifyvisitors`  | Minimal or none          |
| SPM + `notifyvisitors`       | SPM + `NVECTASDK` ⭐    | Small API migration      |

<br>

If you are already using Swift Package Manager with `notifyvisitors`, you do not need to migrate the dependency management system again. You only need to upgrade the SDK API to `NVECTASDK`.

## Before You Begin

Before starting the migration:

- Make sure the existing application builds successfully.
- Commit your current application changes.
- Record the currently used SDK version.
- Review the release notes for the target SPM package version.
- Make sure your Xcode version satisfies the SDK requirements.
- Identify the application targets that currently use the SDK.

Do not combine this migration with unrelated application changes.

---

## Option 1 — CocoaPods to SPM + NVECTASDK

This is the recommended migration path.

### Step 1 — Remove the notifyvisitors SDK from CocoaPods

Open your application's `Podfile`.

Locate the `notifyvisitors` SDK dependency and remove it.

Do not remove unrelated CocoaPods dependencies.

### Step 2 — Update CocoaPods

If your application still uses CocoaPods for other dependencies, run:

```bash
pod install
```

Verify that the `notifyvisitors` SDK is no longer included as a CocoaPods dependency.

If CocoaPods is no longer required by the application, remove the CocoaPods integration according to your application's existing CocoaPods cleanup process.

### Step 3 — Add the NVECTA iOS SDK Using Swift Package Manager

In Xcode select:

**File → Add Package Dependencies...**

Add the NVECTA iOS SDK GitHub repository.

Select the required released package version.

### Step 4 — Add NVECTASDK

When Xcode displays the available package products, select:

```text
NVECTASDK
```

and add it to the **main application target**.

The expected configuration is:

```text
Main Application Target
        │
        └── NVECTASDK
```

### Step 5 — Remove the Old notifyvisitors Reference

After adding `NVECTASDK`, make sure the old manually linked or CocoaPods-provided `notifyvisitors` is no longer linked to the same target.

Check:

**General → Frameworks, Libraries, and Embedded Content**

and:

**Build Phases → Link Binary With Libraries**

Remove duplicate or obsolete references where applicable.

### Step 6 — Update the SDK Import

If your application currently imports:

```objc
#import <notifyvisitors/notifyvisitors.h>
```

update the integration to use the new Swift SDK:

```swift
import NVECTASDK
```

The exact import and initialization pattern should follow the current `NVECTA` iOS SDK documentation.

### Step 7 — Update SDK Initialization

Replace the existing `notifyvisitors` initialization with the corresponding `NVECTASDK` initialization.

Follow the current SDK initialization documentation for the required configuration and initialization sequence.

### Step 8 — Update SDK APIs

Most existing SDK functionality has an equivalent API in `NVECTASDK`.

Update existing SDK calls to their corresponding new APIs.

Some APIs have been renamed to follow modern Swift naming conventions.

> The exact API changes should be reviewed against the SDK version being adopted.

### Step 9 — Update Lifecycle Integration

If your application forwards application or scene lifecycle events to the SDK, update those calls to the corresponding `NVECTASDK` APIs.

Follow the current lifecycle integration documentation.

### Step 10 — Clean the Project

After completing the migration:

1. Select **Product → Clean Build Folder**.
2. Build the application.
3. Run the application.

If necessary, close and reopen Xcode before performing the first build after dependency migration.

### Step 11 — Test the Application

Verify all SDK functionality used by your application.

At minimum, test:

- SDK initialization
- Application launch
- Application lifecycle handling
- Push notification registration
- Push notifications
- Rich Push and Push Delivery count in NVECTA dashboard to verify Notification Service Extension working properly.
- Event tracking
- User/profile tracking
- In-app functionality
- Deep links
- Any other SDK functionality used by your application

---

## API Migration Reference: notifyvisitors → NVECTASDK

When migrating from `notifyvisitors` to `NVECTASDK`, most existing SDK functionality has a direct equivalent. In these cases, the migration generally requires updating the SDK API reference while keeping the same application behavior.

Some APIs have been renamed or redesigned to follow modern Swift naming conventions. The examples below provide a direct reference for the most common migration scenarios.

### Direct Equivalent APIs Example

#### 1. Track Event

**notifyvisitors**

```swift
notifyvisitors.trackEvents("Add to Cart", attributes: eventAttributes, lifetimeValue: "Ltv", scope: scope)
```

**NVECTASDK**

```swift
NVECTA.shared.trackEvent(forEventName: "Add to Cart", attributes: eventAttributes, ltv: "ltv_value", scope: 1)
```

The event-tracking functionality remains equivalent. The new API follows Swift-style naming and uses the shared `NVECTASDK` instance.

#### 2. Track User

**notifyvisitors**

```swift
notifyvisitors.userIdentifier(withUserParams: userParametersDictionary) { (onTrackUserResponse: [AnyHashable : Any]?) in
// Do your stuff here…
}
```

**NVECTASDK**

```swift
NVECTA.shared.userIdentifier(WithUserParams: userParams) { (result: Result<UserTrackResponse, any Error>) in
   // Do your stuff here…
}
```

The user-tracking functionality is available in both SDKs. The new API returns a Swift `Result` containing either a `UserTrackResponse` or an error.

> **Note:** Use the exact parameter and response types exposed by the version of `NVECTASDK` being integrated.

### Renamed or New Equivalent APIs

Some APIs have been renamed or redesigned in `NVECTASDK`. These changes are intentional and follow modern Swift API conventions.

#### 1. Initialize the SDK

**notifyvisitors**

```swift
notifyvisitors.initialize(appMode)
```

**NVECTASDK**

```swift
NVECTA.shared.register(mode: appMode!)
```

#### 2. Push Notification Click Handling

**notifyvisitors**

```swift
notifyvisitors.pushNotificationActionData(from: response, autoRedirectOtherApps: true) { (pushData: NSMutableDictionary?) in
    // Do your stuff here…
    completionHandler()
}
```

**NVECTASDK**

```swift
NVECTASDK.shared.handleNotificationResponse(response, autoRedirect: true) { (pushResponse: NotificationClickResponse?) in
    // Do your stuff here…
    completionHandler()
}
```

The new API uses `NotificationClickResponse` for the callback response and the shorter `autoRedirect` parameter.

## Complete `AppDelegate.swift` Migration Example

The following examples show the complete AppDelegate integration before and after migrating from `notifyvisitors` to `NVECTASDK`.

### Existing `notifyvisitors` Integration

```swift
import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {

        var appMode:String? = nil

         #if DEBUG
             appMode = "debug"
         #else
             appMode = "live"
        #endif

        notifyvisitors.initialize(appMode)

        notifyvisitors.registerPush(
            withDelegate: self,
            app: application,
            launchOptions: launchOptions
        )

        return true
    }

    override func applicationDidEnterBackground(_ application: UIApplication) {
        notifyvisitors.applicationDidEnterBackground(application)
    }

    override func applicationWillEnterForeground(_ application: UIApplication) {
        notifyvisitors.applicationWillEnterForeground(application)
    }

    override func applicationDidBecomeActive(_ application: UIApplication) {
        notifyvisitors.applicationDidBecomeActive(application)
    }

    override func applicationWillTerminate(_ application: UIApplication) {
        notifyvisitors.applicationWillTerminate()
    }

    override func application(
        _ app: UIApplication,
        open url: URL,
        options: [UIApplication.OpenURLOptionsKey: Any] = [:]
    ) -> Bool {

        notifyvisitors.openUrl(with: app, url: url)

        return true
    }

    func application(
        _ application: UIApplication,
        didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data
    ) {
        notifyvisitors.didRegisteredNotification(
            application,
            deviceToken: deviceToken
        )
    }

    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        didReceive response: UNNotificationResponse,
        withCompletionHandler completionHandler: @escaping () -> Void
    ) {
        notifyvisitors.pushNotificationActionData(
            from: response,
            autoRedirectOtherApps: true
        ) { (pushData: NSMutableDictionary?) in

            print("pushData for further action = \(String(describing: pushResponse))")

            /* Here the data received in the pushData variable is required to execute further action and redirect to the desired ViewController. When the target is set to NavigateInApp or Universal Link, those conditions must be handled from here by using target values 0 and 6, respectively.

            If the second parameter for "autoRedirectOtherApps" is false, all push click actions must be handled from here by using pushData values, whereas if true, only NavigateInApp (target = 0) and Universal link (target = 6) values should be handled from here. */
            completionHandler()
        }
    }
}
```

### Migrated `NVECTASDK` Integration

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

    func application(
    _ application: UIApplication,
    didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data
    ) {
        NVECTA.shared.didRegisterPushToken(application, token: deviceToken)
    }

    func userNotificationCenter(
    _ center: UNUserNotificationCenter,
    didReceive response: UNNotificationResponse,
    withCompletionHandler completionHandler: @escaping () -> Void
    ) {
        NVECTA.shared.handleNotificationResponse(response, autoRedirect: true) { (pushResponse: NotificationClickResponse?) in
            print("pushData for further action = \(String(describing: pushResponse))")

            /* Here the data received in the pushData variable is required to execute further action and redirect to the desired ViewController. When the target is set to NavigateInApp or Universal Link, those conditions must be handled from here by using target values 0 and 6, respectively.

            If the second parameter for "autoRedirectOtherApps" is false, all push click actions must be handled from here by using pushData values, whereas if true, only NavigateInApp (target = 0) and Universal link (target = 6) values should be handled from here. */
            completionHandler()
        }
    }
}
```

### AppDelegate Migration Summary

| Area                   | `notifyvisitors`                  | `NVECTASDK`                            |
| ---------------------- | --------------------------------- | -------------------------------------- |
| SDK instance           | Existing SDK API                  | `NVECTASDK.shared`                     |
| Initialization         | `initialize(...)`                 | `register(...)`                        |
| Push registration      | `registerPush(...)`               | `registerPush(...)`                    |
| Event tracking         | `trackEvents(...)`                | `trackEvent(forEventName:...)`         |
| User tracking callback | `[AnyHashable : Any]?`            | `Result<UserTrackResponse, any Error>` |
| Push click handling    | `pushNotificationActionData(...)` | `handleNotificationResponse(...)`      |
| Push click response    | `NSMutableDictionary?`            | `NotificationClickResponse?`           |
| Push token API         | `didRegisteredNotification(...)`  | `didRegisterPushToken(...)`            |
| URL handling           | `openUrl(with:url:)`              | `application(_:open:options:)`         |

> ⚠️ **Important:** The examples above cover the APIs specifically demonstrated in this migration guide. Other SDK APIs may have direct equivalents, renamed equivalents, or new APIs. Refer to the current NVECTA iOS SDK documentation for the complete API surface.

---

## Recommended API Migration Sequence

For a large application, migration can be performed incrementally:

```text
1. Replace the SDK dependency
        ↓
2. Add NVECTASDK through SPM
        ↓
3. Replace SDK initialization
        ↓
4. Update AppDelegate / lifecycle integration
        ↓
5. Update push notification integration
        ↓
6. Update direct SDK API calls
        ↓
7. Build and resolve compiler errors
        ↓
8. Run functional testing
```

Because many APIs have direct equivalents, the migration should generally be incremental rather than requiring a complete rewrite of the application's SDK integration.

---

## Option 2 — CocoaPods to SPM + notifyvisitors

Use this migration path if you want to move from `CocoaPods` to `Swift Package Manager` without changing your existing SDK integration immediately.

The resulting configuration is:

```text
Before:

CocoaPods
    ↓
notifyvisitors
    ↓
Existing Application Code


After:

Swift Package Manager
    ↓
notifyvisitors
    ↓
Existing Application Code
```

### Step 1 — Remove notifyvisitors from CocoaPods

Remove the `notifyvisitors` SDK dependency from your `Podfile`.

Keep unrelated CocoaPods dependencies.

### Step 2 — Update CocoaPods

If the application still uses other CocoaPods dependencies, run:

```bash
pod install
```

Verify that `notifyvisitors` is no longer provided by CocoaPods.

### Step 3 — Add the NVECTA SPM Package

In Xcode select:

**File → Add Package Dependencies...**

Add the NVECTA iOS SDK GitHub repository.

Select the required package version.

### Step 4 — Add notifyvisitors

When Xcode displays the available package products, select:

```text
notifyvisitors
```

and add it to the **main application target**.

The expected configuration is:

```text
Main Application Target
        │
        └── notifyvisitors
```

### Step 5 — Keep Existing Application Code

Your existing `notifyvisitors` integration can continue to use:

```objc
#import <notifyvisitors/notifyvisitors.h>
```

Existing SDK API calls do not need to be changed solely because the SDK has moved from `CocoaPods` to `Swift Package Manager (SPM)`.

This migration path is specifically intended to minimize application code changes.

### Step 7 — Clean and Build

Select:

**Product → Clean Build Folder**

Then:

**Product → Build**

Run the application and verify that the existing SDK functionality continues to work.

---

## Already Using SPM + notifyvisitors?

If you have already migrated your application to `Swift Package Manager` but are still using:

```text
notifyvisitors
```

you do not need to migrate the dependency management system again.

Your recommended next step is:

```text
SPM
 │
 └── notifyvisitors
          ↓
      NVECTASDK
```

Simply replace the `notifyvisitors` package product with `NVECTASDK` and migrate the SDK APIs that have changed.

This is an **SDK API upgrade**, not an SPM migration.

---

## Remove Duplicate Dependencies

After migrating to SPM, make sure the same SDK component is not being provided through multiple mechanisms.

Avoid configurations such as:

```text
CocoaPods
    +
Swift Package Manager
    +
Manual XCFramework
```

for the same SDK component.

Remove old CocoaPods and manual SDK references after confirming the SPM integration.

Duplicate SDK binaries can result in:

- Duplicate symbols
- Linker errors
- Runtime framework-loading failures
- Conflicting SDK versions
- Unexpected runtime behavior

---

## Verification Checklist

### Recommended: SPM + NVECTASDK

#### Dependency

- [ ] `notifyvisitors` SDK removed from `CocoaPods`.
- [ ] `NVECTA` SPM package added.
- [ ] `NVECTASDK` added to the main application target.
- [ ] Old `notifyvisitors` CocoaPods/framework reference removed.
- [ ] No duplicate SDK binaries remain.

#### API

- [ ] Old SDK import removed where applicable.
- [ ] `NVECTASDK` imported.
- [ ] SDK initialization migrated.
- [ ] Renamed APIs updated.
- [ ] Lifecycle integration updated.

#### Testing

- [ ] Application builds successfully.
- [ ] Application launches successfully.
- [ ] SDK initializes successfully.
- [ ] Push notifications work.
- [ ] Rich Push and Push Delivery count in NVECTA dashboard to verify Notification Service Extension works.
- [ ] Event tracking works.
- [ ] User/profile functionality works.
- [ ] Other SDK features used by the application work.

---

### Alternative: SPM + notifyvisitors

- [ ] `notifyvisitors` SDK removed from CocoaPods.
- [ ] NVECTA SPM package added.
- [ ] `notifyvisitors` added to the main application target.
- [ ] Existing `notifyvisitors` imports retained.
- [ ] Existing SDK API calls retained.
- [ ] Notification Service Extension dependency migrated if applicable.
- [ ] Application builds successfully.
- [ ] Existing SDK functionality works.
- [ ] No duplicate SDK binaries remain.

---

## Migration Complete

Once the application has been successfully tested, the `NVECTA` iOS SDK is migrated from `CocoaPods` to `Swift Package Manager`.

For new integrations and future SDK development, we recommend using:

```text
NVECTASDK
```

For complete `Swift Package Manager` installation instructions, see the [Swift Package Manager Installation](../../README.md#recommended-swift-package-manager) guide.
