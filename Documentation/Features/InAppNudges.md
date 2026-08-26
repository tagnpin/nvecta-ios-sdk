# In-App Native Display Integration

This guide explains how to display **NVECTA Native Displays** (also known as **In-App Native Displays**, **Nudges**, or **Cards**) inside your iOS application.

<!-- Official Documentation: <br>
https://www.nvecta.com/docs/in-app-native-display-integration -->

No prior knowledge is required. Follow each step in order.

<br>

# What is a Native Display?

A Native Display is an in-app message that appears as part of your application's user interface instead of a popup.

For example, you can display:

- Promotional banners
- Discount cards
- Product recommendations
- Welcome messages
- Offers
- Informational cards

Because the Native Display becomes part of your layout, it provides a seamless user experience.

<br>

# Prerequisites

Before integrating Native Displays, ensure that:

- The **NVECTA iOS SDK v8.0.2 and later** on should be already integrated.
- The SDK is initialized (typically inside `Appdelegagte.swift` file into `didFinishLaunchingWithOptions()` funcition).
- A Native Display campaign has been created in the NVECTA Dashboard.
- You know the **Property ID** configured for the campaign.

<br>

> ⚠️ **Important**
>
> Always initialize the NVECTA SDK before trying to load a Native Display.

<br>

## Step 1: Install the SDK Dependencies

First you need to install a seprate `notifyvisitorsNudges` SDK into your Main App Target to enable natve display in your app. You can use any one of the following methods:

1. [Swift Package Manager (Recommended)](../../README.md#recommended-swift-package-manager)
2. [CocoaPods](./Documentation/Installation/CocoaPods.md)

<br>

## Step 2: Import SDK

Import the recently installed `notifyvisitorsNudges` in your `UIViewController` in which you want to use native display.

##### Swift

```swift
import UIKit
import notifyvisitorsNudges
```

<details>
<summary>Objective-C</summary>

```objective-c
#import "AppDelegate.h"
#import <notifyvisitorsNudges/notifyvisitorsNudges-Swift.h>
```

</details>

<br>

## Step 3: Create a Native Display View

To load `Native Display` in your iOS app you need to create an `UIView` in your screen in which you can load the `Native Display` as subview by using the `notifyvisitorsNativeDisplay` class from the SDK.

#### Swift

```swift
import UIKit
import notifyvisitorsNudges

 override func viewDidLoad() {
    super.viewDidLoad()

    // 1. Create a parent view of type UIView. The code for creating parent view is just an example you can use your own view as per apple standard.

    let parentView = UIView()
        parentView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(parentView)
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-(25)-[parentView]-(25)-|", metrics: [:], views: ["parentView": parentView]))
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-(120)-[parentView(160)]", metrics: [:], views: ["parentView": parentView]))

        // 2. Load Native Display in your parent view as subview.

        let nativeDisplay = notifyvisitorsNativeDisplay()
        let cardView = nativeDisplay.loadContent(forPropertyName: "propertyID")
        cardView.translatesAutoresizingMaskIntoConstraints = false
        parentView.addSubview(cardView)

        NSLayoutConstraint.activate([
            cardView.topAnchor.constraint(equalTo: parentView.topAnchor, constant: 8),
            cardView.leadingAnchor.constraint(equalTo: parentView.leadingAnchor),
            cardView.trailingAnchor.constraint(equalTo: parentView.trailingAnchor)
        ])

 }
```

<details>
<summary>Objective-C</summary>

```objective-c
#import "AppDelegate.h"
#import <notifyvisitorsNudges/notifyvisitorsNudges-Swift.h>

@implementation ViewController
    - (void)viewDidLoad {
        [super viewDidLoad];

        // 1. Create a parent view of type UIView. The code for creating parent view is just an example you can use your own view as per apple standard.

        UIView *parentView = [[UIView alloc] init];
        parentView.translatesAutoresizingMaskIntoConstraints = NO;
        [self.view addSubview: parentView];

        [self.view addConstraints: [NSLayoutConstraint constraintsWithVisualFormat: @"H:|-(25)-[parentView]-(25)-|" options: 0 metrics: nil views: @{@"parentView": parentView}]];

        [self.view addConstraints: [NSLayoutConstraint constraintsWithVisualFormat: @"V:|-(120)-[parentView(160)]" options: 0 metrics: nil views: @{@"parentView": parentView}]];

        // 2. Load Native Display in your parent view as subview.

        notifyvisitorsNativeDisplay *nativeDisplay = [[notifyvisitorsNativeDisplay alloc] init];
        UIView *cardView = [nativeDisplay loadContentForPropertyName: @"propertyID"];
        cardView.translatesAutoresizingMaskIntoConstraints = NO;
        [parentView addSubview: cardView];
        [NSLayoutConstraint activateConstraints: @[
            [cardView.topAnchor constraintEqualToAnchor:parentView.topAnchor constant:8.0],
            [cardView.leadingAnchor constraintEqualToAnchor:parentView.leadingAnchor],
            [cardView.trailingAnchor constraintEqualToAnchor:parentView.trailingAnchor]
        ]];

    }
@end
```

</details>

### Parameter

| Parameter    | Type   | Required | Description                                    |
| ------------ | ------ | -------- | ---------------------------------------------- |
| `propertyID` | String | ✅ Yes   | Property ID configured in the NVECTA Dashboard |

---

### Example:

##### Swift

```swift
nativeDisplay.loadContent(forPropertyName: "home")
```

<details>
<summary>Objective-C</summary>

```objective-c
UIView *cardView = [nativeDisplay loadContentForPropertyName: @"home"];
```

</details>

### Other examples:

##### Swift

```swift
nativeDisplay.loadContent(forPropertyName: "offer_banner")
nativeDisplay.loadContent(forPropertyName: "checkout_offer")
nativeDisplay.loadContent(forPropertyName: "profile_card")
```

<details>
<summary>Objective-C</summary>

```objective-c
UIView *cardView = [nativeDisplay loadContentForPropertyName: @"offer_banner"];
UIView *cardView = [nativeDisplay loadContentForPropertyName: @"checkout_offer"];
UIView *cardView = [nativeDisplay loadContentForPropertyName: @"profile_card"];
```

</details>

<br>

> The Property ID must exactly match the one configured in the NVECTA Dashboard.

<br>

## Step 5: Receive Completion Callback

Once the Native Display has finished rendering, you can get callback in the app using `notifyvisitorsDelegate` Goto the `ViewController` in which you are showing `Native Display` register the `notifyvisitorsDelegate` as shown below.

### Swift

```swift
class ViewController: UIViewController, notifyvisitorsDelegate {
```

<details>
<summary>Objective-C</summary>

```objective-c

#import <notifyvisitorsDelegate/notifyvisitors.h>

@interface ViewController : UIViewController <notifyvisitorsDelegate>
```

</details>
<br>

Now set the delegate in the `viewdidLoad()` method of your `ViewController` file.

### Swift

```swift
override func viewDidLoad() {
super.viewDidLoad()

notifyvisitors.sharedInstance().delegate = self

}
```

<details>
<summary>Objective-C</summary>

```objective-c

- (void)viewDidLoad {
    [super viewDidLoad];

    [notifyvisitors sharedInstance].delegate = self;
}
```

</details>

<br>

After the `Native Display` finishes processing, the SDK invokes the `onFinish()` callback containing the result. Add the following delegate method into the same ViewController file to receive this callback.

### Swift

```swift
func notifyvisitorsNudgeUiFinalized(_ callback: [AnyHashable : Any]?) {
    print("Native Display UI Finalized result = \(callback ?? [:])")
}
```

<details>
<summary>Objective-C</summary>

```objective-c
- (void)notifyvisitorsNudgeUiFinalized:(NSDictionary *)callback {
    NSLog(@"Native Display UI Finalized result = %@", callback);
}
```

</details>

### Example response:

```json
{
  "status": "fail",
  "message": "no data found",
  "size": {
    "height": "0",
    "width": "0"
  }
}
```

### Response Fields

| Field         | Description                                                                                                                                 |
| ------------- | ------------------------------------------------------------------------------------------------------------------------------------------- |
| `status`      | Indicates the result of the request. Returns `success` when a Native Display is rendered, or `fail` when no matching campaign is available. |
| `message`     | A descriptive message returned by the SDK. For example, `"Native display loaded successfully"` or `"no data found"`.                        |
| `size.height` | The final rendered height of the Native Display. Returns `0` if no content is available.                                                    |
| `size.width`  | The final rendered width of the Native Display. Returns `0` if no content is available.                                                     |

<br>

> ℹ️ **Note:** A response with `"status": "fail"` and `"message": "no data found"` is **not an SDK error**. It simply means there is no eligible Native Display campaign available for the specified `propertyId` or the current user.

<br>

### Why is the Callback Important?

The Native Display size is determined only after the content has finished loading.

Using the callback allows your application to:

- Set the correct height
- Prevent empty space
- Avoid content being cropped
- Display dynamic campaigns correctly

<br>

# Step 7: Complete Example

The following examples demonstrate the complete integration process.

The examples:

1. Create a Native Display view.
2. Add it to a parent layout.
3. Load the `"home"` Property ID.
4. Listen for the rendering callback.
5. Update the parent container height using the size returned by the SDK.

---

#### Swift

```swift
import UIKit
import notifyvisitors
import notifyvisitorsNudges

class ViewController: UIViewController {

 override func viewDidLoad() {
    super.viewDidLoad()

    notifyvisitors.sharedInstance().delegate = self

    // 1. Create a parent view of type UIView. The code for creating parent view is just an example you can use your own view as per apple standard.

    let parentView = UIView()
        parentView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(parentView)
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-(25)-[parentView]-(25)-|", metrics: [:], views: ["parentView": parentView]))
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-(120)-[parentView(160)]", metrics: [:], views: ["parentView": parentView]))

        // 2. Load Native Display in your parent view as subview.

        let nativeDisplay = notifyvisitorsNativeDisplay()
        let cardView = nativeDisplay.loadContent(forPropertyName: "propertyID")
        cardView.translatesAutoresizingMaskIntoConstraints = false
        parentView.addSubview(cardView)

        NSLayoutConstraint.activate([
            cardView.topAnchor.constraint(equalTo: parentView.topAnchor, constant: 8),
            cardView.leadingAnchor.constraint(equalTo: parentView.leadingAnchor),
            cardView.trailingAnchor.constraint(equalTo: parentView.trailingAnchor)
        ])

 }

 }

 extension ViewController: notifyvisitorsDelegate {

    func notifyvisitorsNudgeUiFinalized(_ callback: [AnyHashable : Any]?) {
        print("Native Display UI Finalized result = \(callback ?? [:])")
    }
 }
```

<details>
<summary>Objective-C</summary>

```objective-c
#import "AppDelegate.h"
#import <notifyvisitors/notifyvisitors.h>
#import <notifyvisitorsNudges/notifyvisitorsNudges-Swift.h>

@interface ViewController : UIViewController <notifyvisitorsDelegate>

@end

@implementation ViewController
    - (void)viewDidLoad {
        [super viewDidLoad];

        [notifyvisitors sharedInstance].delegate = self;

        // 1. Create a parent view of type UIView. The code for creating parent view is just an example you can use your own view as per apple standard.

        UIView *parentView = [[UIView alloc] init];
        parentView.translatesAutoresizingMaskIntoConstraints = NO;
        [self.view addSubview: parentView];

        [self.view addConstraints: [NSLayoutConstraint constraintsWithVisualFormat: @"H:|-(25)-[parentView]-(25)-|" options: 0 metrics: nil views: @{@"parentView": parentView}]];

        [self.view addConstraints: [NSLayoutConstraint constraintsWithVisualFormat: @"V:|-(120)-[parentView(160)]" options: 0 metrics: nil views: @{@"parentView": parentView}]];

        // 2. Load Native Display in your parent view as subview.

        notifyvisitorsNativeDisplay *nativeDisplay = [[notifyvisitorsNativeDisplay alloc] init];
        UIView *cardView = [nativeDisplay loadContentForPropertyName: @"propertyID"];
        cardView.translatesAutoresizingMaskIntoConstraints = NO;
        [parentView addSubview: cardView];
        [NSLayoutConstraint activateConstraints: @[
            [cardView.topAnchor constraintEqualToAnchor:parentView.topAnchor constant:8.0],
            [cardView.leadingAnchor constraintEqualToAnchor:parentView.leadingAnchor],
            [cardView.trailingAnchor constraintEqualToAnchor:parentView.trailingAnchor]
        ]];

    }

    - (void)notifyvisitorsNudgeUiFinalized:(NSDictionary *)callback {
        NSLog(@"Native Display UI Finalized result = %@", callback);
    }

@end
```

</details>

<br>

## Best Practices

### ✅ Initialize the SDK first

Always initialize the NVECTA SDK before creating a Native Display.

### ✅ Add the View before loading content

Correct order:

1. Create the view.
2. Add it as subview into the parent view.
3. Call `loadContent()`.
4. update the layout constraint using callback response.

<br>

### ✅ Use the callback to update the layout

The final height is known only after rendering completes.

Always use the callback before resizing your container.

---

### ✅ Use the exact Property ID

The Property ID in your code must match the one configured in the NVECTA Dashboard.

<br>

# Common Issues

## Nothing is displayed

Check the following:

- NVECTA SDK is initialized.
- Property ID is correct.
- Campaign is active.
- Campaign matches the current user.
- Device has an internet connection.

---

## Callback is not received

Verify that:

- `loadContent()` is being called.
- The SDK has completed initialization.
- The `UIViewController` is still visible.

---

## Incorrect size

Ensure that:

- You wait for the callback before updating the layout.
- You can update the height as returned by the SDK.

<br>

# Integration Flow

```
Initialize NVECTA SDK
            │
            ▼
Create notifyvisitorsNativeDisplay
            │
            ▼
Add View to Parent view
            │
            ▼
Call loadContent(propertyId)
            │
            ▼
SDK Downloads Campaign
            │
            ▼
Rendering Completed
            │
            ▼
onFinish() Callback
            │
            ▼
Read Height & Width
            │
            ▼
Update Parent View height
            │
            ▼
Native Display Visible
```

---
