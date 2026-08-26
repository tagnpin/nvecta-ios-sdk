# In-App Notifications Guide

Display targeted In-App Notifications to engage users while they are actively using your application.

Use this guide to display notifications, configure targeting, and handle user interaction callbacks.

Official Documentation:  
https://www.nvecta.com/docs/ios-in-app-notifications

---

<br>

## What are In-App Notifications?

In-App Notifications are messages displayed directly inside the application while the user is actively using it.

Unlike push notifications, these messages only appear when the application is open.

They can be used for:

- Promotional offers
- Discounts
- Product recommendations
- User onboarding
- Feature announcements
- Surveys
- Subscription reminders
- Engagement campaigns

---

<br>

## Basic In-App Flow

```text
Application Starts
       ↓
SDK Syncs Campaigns
       ↓
show() Called
       ↓
Campaign Rules Evaluated
       ↓
Matching Notification Displayed
       ↓
User Interaction Callback
```

---

## Display In-App Notifications

The SDK provides the `show()` method to evaluate and display In-App Notifications based on configured targeting rules.

### Syntax

#### Swift

```swift
NVECTA.shared.show(userToken: [String : Any]?, customRule: [String : Any]?)
```

<details>
<summary>Objective-C</summary>

```objective-c
[[NVECTA shared] show: userTokenDictionary customRule: customRuleDictionary];

```

</details>

## Parameters

| Parameter  | Type            | Description                                                         |
| ---------- | --------------- | ------------------------------------------------------------------- |
| userToken  | [String : Any]? | Used for personalized content in Notification messages in real time |
| customRule | [String : Any]? | Custom values used for campaign targeting                           |

---

<br>

## Recommended Usage

Call `show()` once per `UIViewController` inside `viewDidLoad()` or whenever a screen becomes visible (for example, in `viewDidAppear()` or after navigating to a new `UIViewController`).

### Example:

#### Swift

```swift
let tokens = [:]
tokens["customer_name"] = "John"
tokens["deal_name"] = "Deal of the day"
tokens["discount_percent"] = "20"

let customRule = [:]
customRule["page_id"] = "dashboard"
customRule["category"] = "fashion"
customRule["price"] = "2000"

NVECTA.shared.show(userToken: tokens, customRule: customRule)
```

<details>
<summary>Objective-C</summary>

```objective-c

NSDictionary *tokensDict = @{@"customer_name": @"John", @"deal_name": @"Deal of the day", @"discount_percent": @"20"}

NSDictionary *customRuleDict = @{@"page_id": @"dashboard", @"category": @"fashion", @"price": @"2000"}

[[NVECTA shared] show: tokensDict customRule: customRuleDict];

```

</details>

<br>
This allows the SDK to evaluate whether any In-App campaign should be displayed on that screen.

<br>

## In-app Notification on UIScrollView Scroll Percentage

If you are using `UIScrollView` and wants to show a `banner/survey` after a given scroll percentage then in NVECTA dashboard set the percentage value under targeting rule of you in-app notification setting and call the `show()` method inside your `viewdidLoad()` method and call the below given method inside your UIScrollView’s delegate `scrollViewDidScroll` method.

#### Swift

```swift
func scrollViewDidScroll(_ scrollView: UIScrollView) {
    NVECTA.shared.scrollViewDidScroll(scrollView)
}
```

<details>
<summary>Objective-C</summary>

```objective-c
-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
[[NVECTA shared] scrollViewDidScroll: scrollView];
}
```

</details>

<br>

## In-app Notifications Response Callback

Register a callback to receive user interaction events from In-App Notifications, such as banner impressions, banner clicks, and survey responses

You can use this callback to:

- Handle banner clicks or CTA actions.
- Receive survey submission events.
- Perform custom actions based on user interactions.
- Debug or monitor in-app notification behaviour.

---

### Register the Callback

If you are already using event tracking and its callback on the same page you'll revceive this callback response in the same function. However, if you don't use the event callback on the same page, then you can get the event callback in the app using `NVECTADelegate`. As shown below, add `NVECTADelegate` to the `ViewController` you are triggering the `show()` method in.

### Swift

```swift
class ViewController: UIViewController, NVECTADelegate {
```

<details>
<summary>Objective-C</summary>

```objective-c

#import <NVECTASDK/NVECTASDK-Swift.h>

@interface ViewController : UIViewController <NVECTADelegate>
```

</details>
<br>

Now set the delegate in the `viewdidLoad()` method of your `ViewController` file.

### Swift

```swift
override func viewDidLoad() {
super.viewDidLoad()

NVECTA.shared.delegate = self

}
```

<details>
<summary>Objective-C</summary>

```objective-c

- (void)viewDidLoad {
    [super viewDidLoad];

    [NVECTA shared].delegate = self;
}
```

</details>
<br>
Receive a callback response by adding the following delegate method into the `ViewController`.

### Swift

```swift
func nvectaDidTrackEventResponse(_ response: [String : Any]?) {
    print("[NVECTA]: event callback response = \(response ?? [:])")
}
```

<details>
<summary>Objective-C</summary>

```objective-c
-(void)nvectaDidTrackEventResponse:(NSDictionary *)response {
    NSLog(@"[NVECTA]: event callback response = %@", response);
}
```

</details>

### Example response:

```json
{
  "status": "success",
  "message": "Survey submitted successfully",
  "callbackType": "survey",
  "eventName": "Survey Submit",
  "attributes": {
    "notificationID": "2628",
    "rating": "9"
  },
  "type": 14.1
}
```

## Response Fields

| Field          | Description                                                                                                                         |
| -------------- | ----------------------------------------------------------------------------------------------------------------------------------- |
| `status`       | Indicates whether the SDK processed the interaction successfully.                                                                   |
| `message`      | Additional information about the callback result.                                                                                   |
| `callbackType` | Type of callback, such as `banner`, `survey`, or another in-app interaction.                                                        |
| `eventName`    | Name of the interaction performed by the user.                                                                                      |
| `attributes`   | Additional data associated with the interaction, such as notification ID, survey response, or custom values.                        |
| `type`         | Internal SDK callback identifier used for debugging and to distinguish similar callbacks originating from different SDK components. |

<br>

## Possible Callback Events

In the above output, the parameters have different values depending on the scenario that occurs when displaying banners or surveys. Below are the different values you can get in the callback:

| Status  | Event Name        | Message                        | Type                                        | Callback Type |
| ------- | ----------------- | ------------------------------ | ------------------------------------------- | ------------- |
| Success | Banner Impression | InApp banner shown.            | `15.12`, `15.13`, `15.14`, `15.17`, `15.18` | banner        |
| Success | Banner Clicked    | InApp Banner clicked.          | `15.0` to `15.11`, `15.15`, `15.16`         | banner        |
| Success | Survey Attempt    | Survey attempted successfully. | `14.0`, `14.2`                              | survey        |
| Success | Survey Submit     | Survey submitted successfully. | `14.1`, `14.3`                              | survey        |

The values shown below are generated by the SDK and are intended primarily for debugging and troubleshooting. Applications should rely on `status`, `callbackType`, and `eventName` rather than specific `type` values.

> **Note**
>
> This callback reports **SDK interaction events** only. It is triggered when users interact with an In-App Notification (such as clicking a banner or submitting a survey) and can be used to update your application's UI, perform navigation, or collect diagnostic information.

---

<br>

# Best Practices

- Initialize the SDK before calling `show()`.
- Call `show()` once when a screen becomes visible.
- Track users for personalized campaigns.
- Track custom events for event-based targeting.
- Use meaningful fragment names when working with multiple fragments.
- Handle callbacks to monitor notification display and user interactions.
- Test campaigns using a test device before publishing.

<br>

# Related Documentation

- [📊 Track Events](./EventTracking.md)
- [👤 Track Users](./UserTracking.md)
- [🔔 Push Notifications](../PushNotifications/PushAppConfiguration.md)
