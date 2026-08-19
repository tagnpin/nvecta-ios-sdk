# Event Tracking Guide

This document explains how to track custom events in your iOS application using the NVECTA iOS SDK.

Official Documentation: <br>
https://www.nvecta.com/docs/track-ios-events

---

# What is Event Tracking?

Event tracking helps you record user actions performed inside your application.

Examples:

- App Open
- Login
- Signup
- Add To Cart
- Purchase
- Subscription
- Button Click
- Screen Visit

These events help in:

- Analytics
- User segmentation
- Personalized campaigns
- Push automation
- Conversion tracking

NVECTA automatically tracks some system events after SDK integration, while custom events can be tracked manually based on your business requirements.

---

<br>

# Basic Event Tracking Flow

```text
User Action
    ↓
iOS App
    ↓
NVECTA SDK
    ↓
NVECTA Dashboard Analytics
```

Example:

```text
User clicks "Purchase"
    ↓
Track "purchase_completed" event
    ↓
Event visible in NVECTA dashboard
```

---

<br>

## Event Types

### System Events

These events are tracked automatically after the SDK is initialized.

Examples:

- App Installed (install)
- App Launched (app_launch)
- App Update (update)
- Session Started (session_start)
- Screen View (screen_view)

No additional code is required.

---

### Custom Events

Custom events allow you to track actions that are specific to your application.

Examples:

- Product Viewed
- Add to Cart
- Order Placed
- Payment Successful
- Subscription Started
- Quiz Completed

---

<br>

# Syntax

Use the `trackEvent()` method to track user actions.

### Swift

```swift
NVECTA.shared.trackEvent(forEventName: "EVENT_NAME_STRING", attributes: [String: Any]?, ltv: "LTV_VALUE_STRING", scope: Int)
```

<details>
<summary>Objective-C</summary>

```objective-c
[[NVECTA shared] trackEventForEventName: @"EVENT_NAME_STRING" attributes: @{"key": "value"}, ltv: @"LTV_VALUE_STRING", scope: int];

```

</details>

<br>

## Event Method Parameters

| Parameter       | Type              | Description                       |
| --------------- | ----------------- | --------------------------------- |
| `event_name`    | `String`          | Name of the event                 |
| `attributes`    | `[String : Any]?` | Additional event data             |
| `lifeTimeValue` | `String`          | Score/value associated with event |
| `scope`         | `Int`             | Defines tracking frequency        |

---

<br>

# Example for Tracking Event

## Track a Simple Event

### Swift

```swift
NVECTA.shared.trackEvent(forEventName: "Product Viewed", attributes: nil, ltv: nil, scope: 1)
```

<details>
<summary>Objective-C</summary>

```objective-c
[[NVECTA shared] trackEventForEventName: @"Product Viewed" attributes: nil, ltv: nil, scope: 1];

```

</details>

## Track Event with Attributes

Attributes help store additional information related to the event.

Example:

- Product Name
- Price
- Quantity
- Category
- Payment Method

### Swift

```swift
var eventAttributes: [String : Any] = [:]

eventAttributes["product_name"] = "Running Shoes"
eventAttributes["category"] = "Footwear"
eventAttributes["price"] = 2499
eventAttributes["quantity"] = 1

NVECTA.shared.trackEvent(forEventName: "Add To Cart", attributes: eventAttributes, ltv: nil, scope: 1)
```

<details>
<summary>Objective-C</summary>

```objective-c
NSDictionary * eventAttributes = @{@"product_name": @"Running Shoes", @"category": "Footwear", @"price": @(2499), @"quantity": @(1)};
[[NVECTA shared] trackEventForEventName: @"Add To Cart" attributes: eventAttributes, ltv: nil, scope: 1];

```

</details>

---

<br>

# Lifetime Value (LTV)

Use **LTV** to assign a score or monetary value to an event.

Example:

- Purchase Amount
- Reward Points
- Revenue Generated

### Swift

```swift
var eventAttributes: [String : Any] = [:]

eventAttributes["product_name"] = "Running Shoes"
eventAttributes["category"] = "Footwear"
eventAttributes["price"] = 2499
eventAttributes["quantity"] = 1

NVECTA.shared.trackEvent(forEventName: "Order Placed", attributes: eventAttributes, ltv: "2499", scope: 1)
```

<details>
<summary>Objective-C</summary>

```objective-c
NSDictionary * eventAttributes = @{@"product_name": @"Running Shoes", @"category": "Footwear", @"price": @(2499), @"quantity": @(1)};
[[NVECTA shared] trackEventForEventName: @"Order Placed" attributes: eventAttributes, ltv: @"2499", scope: 1];

```

</details>

<br>

# Understanding Scope Values

The `scope` parameter controls how frequently an event should be tracked.

| Scope Value | Description            |
| ----------- | ---------------------- |
| `1`         | Track every time       |
| `2`         | Track once per session |

### Example:

#### Swift

```swift
NVECTA.shared.trackEvent(forEventName: "login", attributes: nil, ltv: nil, scope: 2)
```

<details>
<summary>Objective-C</summary>

```objective-c
[[NVECTA shared] trackEventForEventName: @"login" attributes: nil, ltv: nil, scope: 2];

```

</details>

<br>

# Tracking Complex Attributes

You can also pass complex nested objects in the attributes.

### Swift

```swift

var address = ["city": "London", "country" : "United Kingdom"]

var eventAttributes: [String : Any] = [:]

eventAttributes["customer_name"] = "John"
eventAttributes["address"] = address

NVECTA.shared.trackEvent(forEventName: "Profile Updated", attributes: eventAttributes, ltv: nil, scope: 1)
```

<details>
<summary>Objective-C</summary>

```objective-c
NSDictionary *address = @{@"city": @"London", @"country" : @"United Kingdom"};

NSDictionary *eventAttributes = @{@"customer_name": @"John", @"address": address};

[[NVECTA shared] trackEventForEventName: @"Profile Updated" attributes: eventAttributes, ltv: nil, scope: 1];

```

</details>

<br>

# Event Response Callback

You can get event result’s callback in the app using NVECTA SDK Goto the ViewController in which you are triggering events add NVECTADelegate as shown below.

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
Receive a callback indicating whether the `event` performed is tracked successfully or encountered an SDK-level error by adding the following delegate method into the `ViewController`.

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
  "callbackType": "event",
  "eventName": "Add To Cart",
  "attributes": {
    "product_name": "Running Shoes",
    "category": "Footwear",
    "price": 2499,
    "quantity": 1
  },
  "type": 0,
  "message": "Tracking Conversion successful for subscribed event or this Event Already Performed"
}
```

## Event Callback Response Types

The SDK returns different response messages and type codes based on event tracking status.

| STATUS  | MESSAGE                                                                                                        | TYPE                | CALLBACK TYPE |
| ------- | -------------------------------------------------------------------------------------------------------------- | ------------------- | ------------- |
| success | Tracking Conversion successful for <event_name>                                                                | `0`                 | Event         |
| Fail    | Please check for Event Name, it shouldn't be NULL or EMPTY.                                                    | `1`                 | Event         |
| Fail    | Context not found.                                                                                             | `2.0`, `2.1`, `2.2` | Event         |
| Fail    | Invalid SCOPE value found.                                                                                     | `3.0`, `3.1`, `3.2` | Event         |
| Fail    | `<event_name>` event can be tracked once in `<scope>` days. It will get tracked after `<remaining_days>` days. | `4.0`, `4.1`        | Event         |
| Fail    | `<event_name>` event can be tracked once in `<scope>` days. It will get tracked from tomorrow or later.        | `5`                 | Event         |
| Fail    | Analytics / Event Status is inactive in the NV Panel.                                                          | `6.0`, `6.1`, `6.2` | Event         |
| Fail    | Wrong credentials found. Recheck the NotifyVisitors BrandID and Encryption Key in your app's manifest file.    | `7`                 | Event         |
| Fail    | Something went wrong while processing via the API.                                                             | `8`                 | Event         |
| Fail    | No response available corresponding to this event.                                                             | `9.0`, `9.1`        | Event         |
| Fail    | LIFE-CYCLE Events INACTIVE or account not upgraded.                                                            | `10`                | Event         |
| Fail    | Conversion failed.                                                                                             | `11.0`, `11.1`      | Event         |
| Fail    | Authentication error.                                                                                          | `12.0`, `12.1`      | Event         |
| Fail    | Something went wrong while processing the response.                                                            | `13`                | Event         |
| Fail    | No internet found.                                                                                             | `16.0`, `16.1`      | Event         |
| Fail    | Attribution tracking is disabled in the NV Panel.                                                              | `17.0`              | Event         |

<br>

> **Type:** Identifies the internal SDK component or processing stage where the callback originated. Primarily intended for debugging and troubleshooting SDK-level errors.

<br>

# Best Practices

- Use meaningful and descriptive event names, such as `order_placed`, `add_to_cart`, or `product_viewed`.
- Follow a consistent naming convention throughout your application (for example, use lowercase with underscores for all event and attribute names).
- Keep attribute names consistent across events (for example, always use `product_id` instead of mixing `productId`, `id`, or `item_id`).
- Maintain consistent data types for attributes (for example, always send `price` as a number and `quantity` as an integer).
- Include only relevant attributes that improve analytics, segmentation, and campaign targeting.
- Avoid sending sensitive or personally identifiable information (PII), such as passwords, payment details, or confidential user data.
- Use **Scope = 2** only for events that should be tracked once per session, such as `login` or `app_opened`.

<br>

# Recommended Event Naming Examples

| Action       | Recommended Event      |
| ------------ | ---------------------- |
| App Open     | `app_launch`           |
| Login        | `user_login`           |
| Signup       | `user_signup`          |
| Add To Cart  | `add_to_cart`          |
| Purchase     | `purchase_completed`   |
| Subscription | `subscription_started` |

---

<br>

# Common Use Cases

## 🛍️ E-commerce

Track when a user adds a product to their cart.

### Swift

```swift
var eventAttributes: [String : Any] = [:]

eventAttributes["product_name"] = "Sneakers"
eventAttributes["category"] = "Footwear"
eventAttributes["price"] = 4999
eventAttributes["quantity"] = 1

NVECTA.shared.trackEvent(forEventName: "Add To Cart", attributes: eventAttributes, ltv: "4999", scope: 1)
```

<details>
<summary>Objective-C</summary>

```objective-c
NSDictionary * eventAttributes = @{@"product_name": @"Sneakers", @"category": "Footwear", @"price": @(4999), @"quantity": @(1)};
[[NVECTA shared] trackEventForEventName: @"Add To Cart" attributes: eventAttributes, ltv: @"4999", scope: 1];

```

</details>

## 👤 User Registration

Track when a new user signs up.

### Swift

```swift
var eventAttributes: [String : Any] = [:]

eventAttributes["method"] = "gmail"

NVECTA.shared.trackEvent(forEventName: "user_signup", attributes: eventAttributes, ltv: nil, scope: 2)
```

<details>
<summary>Objective-C</summary>

```objective-c
NSDictionary * eventAttributes = @{@"method": @"gmail"};
[[NVECTA shared] trackEventForEventName: @"user_signup" attributes: eventAttributes, ltv: nil, scope: 2];

```

</details>

---

<br>

# Summary

With NVECTA iOS SDK event tracking, you can:

- Monitor user activity
- Analyze customer behavior
- Create personalized campaigns
- Trigger automations
- Improve user engagement

# Next Steps

Continue exploring the SDK:

- [👤 Track Users](./UserTracking.md)
- [💬 In-App Notifications & Nudges](./InAppNudges.md)
- [Notification Center](./NotificationCenter.md)
<!-- - [🌍 Global Attributes](./GlobalAttributes.md) -->
