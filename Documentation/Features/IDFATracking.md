# NVECTAAdTrackingSDK — IDFA & App Tracking Transparency

`NVECTAAdTrackingSDK` is an optional dependency that handles **App Tracking Transparency (ATT)** authorization and **IDFA (Identifier for Advertisers)** retrieval for applications using `NVECTASDK` or the `notifyvisitors` SDK.

When integrated, the tracking SDK communicates the available tracking state and IDFA internally to the core SDK. Applications that do not require IDFA can use the core SDK without this dependency.

## Requirements

| Requirement  | Version                        |
| ------------ | ------------------------------ |
| iOS          | iOS 14+                        |
| Distribution | Swift Package Manager          |
| SDK          | `NVECTASDK` / `notifyvisitors` |

> ATT authorization is available on iOS 14 and later. On unsupported iOS versions, the tracking flow continues without IDFA.

## Installation

Add `NVECTAAdTrackingSDK` to the application using Swift Package Manager and link it to the application target.

The dependency configuration is:

```text
Application
├── NVECTASDK / notifyvisitors
└── NVECTAAdTrackingSDK
```

`NVECTAAdTrackingSDK` is required only when the application needs ATT/IDFA functionality.

## Configure ATT

Add `NSUserTrackingUsageDescription` to the **application's** `Info.plist`:

```xml
<key>NSUserTrackingUsageDescription</key>
<string>This identifier will be used to improve analytics and personalized experiences.</string>
```

Use a description that accurately explains why the application requests tracking authorization.

> The key must be present in the host application's final `Info.plist`, adding it only to the framework's `Info.plist` is not sufficient.

---

## Initialization

`NVECTAAdTrackingSDK` should be initialized just after the `notifyvisitors or NVECTASDK` initialization.

### Syntax

#### Swift

```swift
NVECTAAdTrackingManager.shared.start();
```

<details>
<summary>Objective-C</summary>

```objective-c
[[NVECTAAdTrackingManager shared] start];
```

</details>

<br>

`start()` initializes the tracking manager and observes the application lifecycle. It does **not** display the ATT permission prompt.

### Example:

The recommended initialization order is:

### Swift

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

---

## Requesting ATT Authorization

Request authorization when the application is ready to present the ATT prompt:

#### Swift

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

The application controls **when** the permission request is made.

### Recommended initialization

```swift
// Step-1. Initialise the Core SDK
NVECTA.shared.register(mode: "live")

// Step-2. Initialise the tracking SDK
NVECTAAdTrackingManager.shared.start()

//  Step-3. If the application wants to request authorization during startup:
NVECTAAdTrackingManager.shared.requestTrackingAuthorization { status in
    print("ATT authorization status: \(status)")
}

```

<details>
<summary>Objective-C</summary>

```objective-c
// Step-1. Initialise the Core SDK
[[NVECTA shared] register: nvMode];

// Step-2. Initialise the tracking SDK
[[NVECTAAdTrackingManager shared] start];

//  Step-3. If the application wants to request authorization during startup:
[[NVECTAAdTrackingManager shared] requestTrackingAuthorization:^(NVECTATrackingAuthorizationStatus *status) {
    NSLog(@"ATT authorization status: %ld", (long)status);
}];
```

</details>

<br>

> However, applications should consider their user experience carefully before displaying the ATT prompt immediately during application launch.
>
> Alternatively, call `requestTrackingAuthorization()` later from an appropriate application screen or user flow.

---

## ATT and IDFA Behavior

The SDK handles the current ATT authorization state automatically.

| ATT Status              | SDK Behavior                           |
| ----------------------- | -------------------------------------- |
| `.notDetermined`        | Waits until authorization is requested |
| `.authorized`           | Retrieves the IDFA                     |
| `.denied`               | No IDFA is provided                    |
| `.restricted`           | No IDFA is provided                    |
| Unsupported iOS version | Continues without IDFA                 |

> **Important Note:**
> If the application already has an ATT authorization history, `start()` reads the current state. For example, a previously authorized user does not receive the authorization prompt again.

---

## Privacy and IDFA Considerations

IDFA is a privacy-sensitive identifier and should only be accessed and used in accordance with Apple's applicable privacy requirements and the application's declared data practices.

Applications using IDFA should:

1. Provide a meaningful `NSUserTrackingUsageDescription`.
2. Request ATT authorization at an appropriate point in the user experience.
3. Ensure the application's App Store privacy disclosures accurately reflect the application's use of tracking and collected data.

`NVECTAAdTrackingSDK` does not block `NVECTASDK` while waiting for ATT authorization.

The SDK continues its normal operation while the authorization request is in progress. Once authorization is available, the IDFA is propagated to `NVECTASDK` for subsequent SDK processing.

---

## Troubleshooting

#### ATT permission prompt does not appear

Verify:

1. The application is running on iOS 14 or later.
2. `NSUserTrackingUsageDescription` exists in the application's `Info.plist`.
3. `NVECTAAdTrackingManager.shared.start()` has been called.
4. `requestTrackingAuthorization()` has been called when the application expects the prompt.
5. ATT authorization has not already been determined for the application.
6. The request is triggered from an appropriate application lifecycle/user interaction point.

The ATT system does not display the authorization prompt repeatedly after the user has already made a decision.

#### IDFA is not available

An IDFA is not expected when:

- ATT authorization is denied or restricted.
- Authorization has not yet been granted.
- `NSUserTrackingUsageDescription` is missing.
- The system does not provide a valid advertising identifier.

---
