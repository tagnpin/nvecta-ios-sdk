# NVECTAAdTrackingSDK — Optional IDFA & App Tracking Transparency

`NVECTAAdTrackingSDK` is an optional binary XCFramework that provides **App Tracking Transparency (ATT)** authorization handling and **IDFA (Identifier for Advertisers)** retrieval for applications using `notifyvisitors or NVECTASDK`.

It is designed as an optional dependency so that applications that do not require IDFA can continue using `NVECTASDK` without integrating `NVECTAAdTrackingSDK`.

When `NVECTAAdTrackingSDK` is integrated and IDFA is available, the identifier is automatically communicated internally to `NVECTASDK` and can be included in SDK network requests where applicable.

## Overview

The integration supports the following scenarios:

- Automatic ATT permission request managed by `NVECTAAdTrackingSDK`.
- Manual ATT permission request managed by the host application.
- Existing ATT authorization from previous application versions.
- Automatic IDFA retrieval when tracking authorization is granted.
- Automatic propagation of IDFA to `NVECTASDK`.
- No additional IDFA API calls required by the host application.
- `NVECTASDK` continues to operate normally when `NVECTAAdTrackingSDK` is not integrated.

---

## Requirements

| Requirement  | Version                                                   |
| ------------ | --------------------------------------------------------- |
| iOS          | iOS 14+                                                   |
| Xcode        | Xcode version compatible with the distributed XCFramework |
| Swift        | Supported by the distributed binary                       |
| Distribution | Swift Package Manager                                     |

> ATT authorization is available on iOS 14 and later. On earlier iOS versions, the tracking authorization flow is treated as unsupported and the SDK continues without IDFA.

---

# Installation

`NVECTAAdTrackingSDK` is distributed as a separate binary XCFramework and is intended to be added as an **optional dependency** alongside `NVECTASDK`.

For example:

```text
Your Application
│
├── NVECTASDK (or notifyvisitors SDK)
│
└── NVECTAAdTrackingSDK       ← Optional
```

Applications that do not require IDFA can integrate only `NVECTASDK`.

Applications that require IDFA can integrate both frameworks.

## Swift Package Manager

Add the package containing `NVECTAAdTrackingSDK` to your application using Swift Package Manager.

After adding the package, ensure that `NVECTAAdTrackingSDK` is linked to the application target.

The final dependency configuration should contain:

```text
NVECTASDK (or notifyvisitors iOS SDK)
│
NVECTAAdTrackingSDK
```

`NVECTAAdTrackingSDK` should only be added when the application requires ATT/IDFA functionality.

---

# App Tracking Transparency Configuration

Applications using `NVECTAAdTrackingSDK` must provide an appropriate tracking usage description in the application's `Info.plist`.

Add:

```xml
<key>NSUserTrackingUsageDescription</key>
<string>This identifier will be used to improve analytics and personalized experiences.</string>
```

The description should accurately explain to users why the application requests tracking authorization.

If this key is not present, `NVECTAAdTrackingSDK` will not request ATT authorization and will continue without an IDFA.

> The `NSUserTrackingUsageDescription` value is controlled by the host application and must be included in the application's final `Info.plist`. It should not be added only to the framework's `Info.plist`.

---

# Initialization

`NVECTAAdTrackingSDK` should be initialized just after the `notifyvisitors or NVECTASDK` initialization.

The recommended initialization order is:

### While using `NVECTASDK`

#### Swift

```swift
import UIKit
import NVECTASDK
import NVECTAAdTrackingSDK

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

        NVECTAAdTrackingManager.shared.configuration.enableAutomaticATTRequest = true;
        NVECTAAdTrackingManager.shared.start();

        return true
    }
}
```

<details>
<summary>Objective-C</summary>

```objective-c
#import "AppDelegate.h"
#import <NVECTASDK/NVECTASDK-Swift.h>
#import <NVECTAAdTrackingSDK/NVECTAAdTrackingSDK-Swift.h>

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
    [[NVECTAAdTrackingManager shared] configuration].enableAutomaticATTRequest = YES;
    [[NVECTAAdTrackingManager shared] start];

    return YES;
}

@end

```

</details>

<br>

> **Important Note**
>
> This initialization order ensures that `NVECTASDK` is ready to receive tracking state updates from `NVECTAAdTrackingSDK`.

### While using `notifyvisitors` iOS SDK

#### Swift

```swift
import UIKit
import notifyvisitors
import NVECTAAdTrackingSDK

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        var nvMode:String? = nil

         #if DEBUG
             nvMode = "debug"
         #else
             nvMode = "live"
        #endif

        notifyvisitors.initialize(nvMode)

        NVECTAAdTrackingManager.shared.configuration.enableAutomaticATTRequest = true;
        NVECTAAdTrackingManager.shared.start();

        return true
    }
}
```

<details>
<summary>Objective-C</summary>

```objective-c
#import "AppDelegate.h"
#import <notifyvisitors/notifyvisitors.h>
#import <NVECTAAdTrackingSDK/NVECTAAdTrackingSDK-Swift.h>

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application
didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    NSString *nvMode = nil;

    #if DEBUG
       nvMode = @"debug";
    #else
       nvMode = @"live";
    #endif

    [notifyvisitors Initialize: nvMode];

    [[NVECTAAdTrackingManager shared] configuration].enableAutomaticATTRequest = YES;
    [[NVECTAAdTrackingManager shared] start];

    return YES;
}

@end

```

</details>

<br>

> **Important Note**
>
> This initialization order ensures that `notifyvisitors` is ready to receive tracking state updates from `NVECTAAdTrackingSDK`.

---

# ATT Authorization Modes

`NVECTAAdTrackingSDK` supports two authorization modes.

## 1. Automatic ATT Authorization

Use automatic authorization when you want `NVECTAAdTrackingSDK` to request tracking permission on behalf of the application.

Set:

### Swift

```swift
NVECTAAdTrackingManager.shared.configuration.enableAutomaticATTRequest = true;
NVECTAAdTrackingManager.shared.start();
```

<details>
<summary>Objective-C</summary>

```objective-c
[[NVECTAAdTrackingManager shared] configuration].enableAutomaticATTRequest = YES;
[[NVECTAAdTrackingManager shared] start];
```

</details>

<br>

On iOS 14 and later:

- If ATT status is `.notDetermined`, `NVECTAAdTrackingSDK` requests authorization.
- If the user allows tracking, the SDK retrieves the IDFA.
- If the user denies tracking, no IDFA is provided.
- If authorization was already decided in a previous application version, the SDK does not display the permission prompt again.
- If tracking is already authorized, the SDK retrieves the current IDFA during initialization.

### Recommended AppDelegate Example

```swift
import UIKit
import NVECTASDK
import NVECTAAdTrackingSDK

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

        NVECTAAdTrackingManager.shared.configuration.enableAutomaticATTRequest = true;
        NVECTAAdTrackingManager.shared.start();

        return true
    }
}
```

<details>
<summary>Objective-C</summary>

```objective-c
#import "AppDelegate.h"
#import <NVECTASDK/NVECTASDK-Swift.h>
#import <NVECTAAdTrackingSDK/NVECTAAdTrackingSDK-Swift.h>

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
    [[NVECTAAdTrackingManager shared] configuration].enableAutomaticATTRequest = YES;
    [[NVECTAAdTrackingManager shared] start];

    return YES;
}

@end

```

</details>

<br>

---

# 2. Application-Managed ATT Authorization

If the application already has its own ATT permission flow, disable automatic authorization:

### Swift

```swift
NVECTAAdTrackingManager.shared.configuration.enableAutomaticATTRequest = false;
NVECTAAdTrackingManager.shared.start();
```

<details>
<summary>Objective-C</summary>

```objective-c
[[NVECTAAdTrackingManager shared] configuration].enableAutomaticATTRequest = NO;
[[NVECTAAdTrackingManager shared] start];
```

</details>

<br>

The application can request ATT authorization when appropriate.

For example:

### Swift

```swift
NVECTAAdTrackingManager.shared.requestTrackingAuthorization { status in
    print("ATT authorization status: \(status)")
}
```

<details>
<summary>Objective-C</summary>

```objective-c

[[NVECTAAdTrackingManager shared] requestTrackingAuthorization:^(NVECTATrackingAuthorizationStatus *status) {
    NSLog(@"ATT authorization status: %ld", (long)status);
}];
```

</details>

<br>

The application remains responsible for deciding **when** the permission prompt should be displayed.

Once authorization is granted, `NVECTAAdTrackingSDK` retrieves the IDFA and automatically communicates the value to `NVECTASDK`.

No additional IDFA synchronization code is required in the application.

---

# Existing ATT Authorization

`NVECTAAdTrackingSDK` is designed to support applications that already have an ATT authorization history.

For example, an application may have been available on the App Store for several versions before integrating `NVECTAAdTrackingSDK`.

A user may already have:

- Allowed tracking.
- Denied tracking.
- A restricted tracking state.

When the application is updated and starts using `NVECTAAdTrackingSDK`, the SDK reads the current ATT authorization status.

### Previously Authorized User

```text
Existing App Version
        │
        └── User allowed ATT
                │
                ▼
          App is updated
                │
                ▼
       NVECTAAdTrackingSDK.start()
                │
                ▼
          ATT = authorized
                │
                ▼
          Retrieve IDFA
                │
                ▼
          NVECTASDK (or notifyvisitors SDK) receives IDFA
```

No permission prompt is displayed again.

### Previously Denied User

```text
Existing App Version
        │
        └── User denied ATT
                │
                ▼
          App is updated
                │
                ▼
       NVECTAAdTrackingSDK.start()
                │
                ▼
           ATT = denied
                │
                ▼
             IDFA = nil
```

The SDK continues to operate normally without an IDFA.

---

# IDFA Integration with NVECTASDK

The application does **not** need to retrieve or pass the IDFA manually to `NVECTASDK`.

When `NVECTAAdTrackingSDK` obtains a valid IDFA, it internally communicates the tracking state to `NVECTASDK`.

The internal flow is:

```text
NVECTAAdTrackingSDK
      │
      ├── ATT Authorization
      │
      ├── IDFA Retrieval
      │
      ▼
Tracking State Update
      │
      ▼
NVECTASDK (or notifyvisitors SDK)
      │
      ▼
SDK Network Requests
```

This keeps the IDFA implementation isolated from the core SDK and avoids exposing additional IDFA-related APIs to application developers.

---

# When NVECTAAdTrackingSDK Is Not Integrated

`NVECTAAdTrackingSDK` is completely optional.

Applications that do not require IDFA can continue using:

```text
NVECTASDK (or notifyvisitors SDK)
```

without adding:

```text
NVECTAAdTrackingSDK
```

In this configuration:

```text
NVECTASDK (or notifyvisitors SDK)
    │
    ├── Normal SDK initialization
    ├── Normal SDK functionality
    ├── Normal network requests
    └── No IDFA
```

The absence of `NVECTAAdTrackingSDK` must not prevent `NVECTASDK` from initializing or performing its normal functionality.

---

<!-- # Logging

`NVECTAAdTrackingSDK` uses the same `nvLogsLevel` configuration key used by `NVECTASDK`.

This allows both SDKs to use a consistent logging configuration.

Add the following to the application's `Info.plist`:

```xml
<key>nvLogsLevel</key>
<string>info</string>
``` -->

<!-- ## Supported Log Levels

| Level     | Error | Warning | Info | Debug | Verbose |
| --------- | ----: | ------: | ---: | ----: | ------: |
| `none`    |    No |      No |   No |    No |      No |
| `error`   |   Yes |      No |   No |    No |      No |
| `warning` |   Yes |     Yes |   No |    No |      No |
| `info`    |   Yes |     Yes |  Yes |    No |      No |
| `debug`   |   Yes |     Yes |  Yes |   Yes |      No |
| `verbose` |   Yes |     Yes |  Yes |   Yes |     Yes |

If `nvLogsLevel` is not specified, `info` is used as the default level. -->

<!-- ### Production

For normal production applications:

```xml
<key>nvLogsLevel</key>
<string>info</string>
```

or simply omit the key and use the default.

### Debugging

For detailed SDK diagnostics:

```xml
<key>nvLogsLevel</key>
<string>debug</string>
```

For maximum diagnostic information:

```xml
<key>nvLogsLevel</key>
<string>verbose</string>
```

Avoid enabling `verbose` logging in production unless required for troubleshooting.

---
-->

# Privacy and IDFA Considerations

IDFA is a privacy-sensitive identifier and should only be accessed and used in accordance with Apple's applicable privacy requirements and the application's declared data practices.

Applications using IDFA should:

1. Provide a meaningful `NSUserTrackingUsageDescription`.
2. Request ATT authorization at an appropriate point in the user experience.
3. Only use IDFA when the required authorization has been granted.
4. Avoid relying on IDFA when authorization is denied or unavailable.
5. Ensure the application's App Store privacy disclosures accurately reflect the application's use of tracking and collected data.

`NVECTAAdTrackingSDK` does not block `NVECTASDK` while waiting for ATT authorization.

The SDK continues its normal operation while the authorization request is in progress. Once authorization is available, the IDFA is propagated to `NVECTASDK` for subsequent SDK processing.

---

# Recommended Integration

For applications that want `NVECTAAdTrackingSDK` to manage ATT authorization:

#### Swift

```swift
import UIKit
import notifyvisitors
import NVECTAAdTrackingSDK

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        var nvMode:String? = nil

         #if DEBUG
             nvMode = "debug"
         #else
             nvMode = "live"
        #endif

        notifyvisitors.initialize(nvMode)

        NVECTAAdTrackingManager.shared.configuration.enableAutomaticATTRequest = true;
        NVECTAAdTrackingManager.shared.start();

        return true
    }
}
```

<details>
<summary>Objective-C</summary>

```objective-c
#import "AppDelegate.h"
#import <notifyvisitors/notifyvisitors.h>
#import <NVECTAAdTrackingSDK/NVECTAAdTrackingSDK-Swift.h>

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application
didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    NSString *nvMode = nil;

    #if DEBUG
       nvMode = @"debug";
    #else
       nvMode = @"live";
    #endif

    [notifyvisitors Initialize: nvMode];

    [[NVECTAAdTrackingManager shared] configuration].enableAutomaticATTRequest = YES;
    [[NVECTAAdTrackingManager shared] start];

    return YES;
}

@end

```

</details>

<br>

For applications that manage ATT themselves:

#### Swift

```swift
import UIKit
import notifyvisitors
import NVECTAAdTrackingSDK

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        var nvMode:String? = nil

         #if DEBUG
             nvMode = "debug"
         #else
             nvMode = "live"
        #endif

        notifyvisitors.initialize(nvMode)

        NVECTAAdTrackingManager.shared.configuration.enableAutomaticATTRequest = false
        NVECTAAdTrackingManager.shared.start()

        return true
    }
}
```

<details>
<summary>Objective-C</summary>

```objective-c
#import "AppDelegate.h"
#import <notifyvisitors/notifyvisitors.h>
#import <NVECTAAdTrackingSDK/NVECTAAdTrackingSDK-Swift.h>

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application
didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    NSString *nvMode = nil;

    #if DEBUG
       nvMode = @"debug";
    #else
       nvMode = @"live";
    #endif

    [notifyvisitors Initialize: nvMode];

    [[NVECTAAdTrackingManager shared] configuration].enableAutomaticATTRequest = NO;
    [[NVECTAAdTrackingManager shared] start];

    return YES;
}

@end

```

</details>

<br>

The application can later request authorization:

### Swift

```swift
NVECTAAdTrackingManager.shared.requestTrackingAuthorization { status in
    print("ATT authorization status: \(status)")
}
```

<details>
<summary>Objective-C</summary>

```objective-c

[[NVECTAAdTrackingManager shared] requestTrackingAuthorization:^(NVECTATrackingAuthorizationStatus *status) {
    NSLog(@"ATT authorization status: %ld", (long)status);
}];
```

</details>

---

# Troubleshooting

## ATT permission prompt does not appear

Verify:

1. The application is running on iOS 14 or later.
2. `NSUserTrackingUsageDescription` exists in the application's `Info.plist`.
3. `enableAutomaticATTRequest` is set to `true` when using automatic authorization.
4. ATT authorization has not already been determined for the application.
5. The request is triggered from an appropriate application lifecycle/user interaction point.

The ATT system does not display the authorization prompt repeatedly after the user has already made a decision.

## IDFA is not available

Check the current ATT status.

An IDFA is not expected when:

- Authorization is denied.
- Authorization is restricted.
- Authorization has not yet been granted.
- `NSUserTrackingUsageDescription` is missing.
- The system does not provide a valid advertising identifier.

## NVECTASDK works but IDFA is missing

Verify that:

```text
NVECTAAdTrackingSDK
```

is integrated into the application and that:

```swift
NVECTAAdTrackingManager.shared.start()
```

is called.

Also verify that ATT authorization has been granted.

---

# Summary

`NVECTAAdTrackingSDK` provides an optional, isolated implementation for ATT authorization and IDFA retrieval.

The recommended architecture is:

```text
                    Host Application
                           │
              ┌────────────┴────────────┐
              │                         │
              ▼                         ▼
        NVECTASDK                 NVECTAAdTrackingSDK
              │                         │
              │                  ATT Authorization
              │                         │
              │                    IDFA Retrieval
              │                         │
              │◄──── Tracking State ────┘
              │
              ▼
       SDK Network Requests
```

Applications that require IDFA integrate both frameworks.

Applications that do not require IDFA can continue using `NVECTASDK` alone.

No manual IDFA transfer between the application and `NVECTASDK` is required.
