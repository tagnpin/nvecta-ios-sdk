# 👤 User Tracking Guide

User tracking helps you identify users and associate their profile information with events, campaigns, and analytics.

Once a user is identified, all future events and interactions are linked to that user profile.

**Official Documentation:** <br>
https://www.nvecta.com/docs/track-ios-users

---

## What is User Tracking?

User tracking allows you to associate app activity, events, purchases, and engagement data with a specific user profile.

By identifying users, you can:

- Build unified customer profiles
- Personalize campaigns and notifications
- Track user journeys across sessions
- Segment users based on behavior
- Measure retention and engagement

In NVECTA, user profiles are created automatically and can later be linked to known user information such as email, mobile number, customer ID, or other identifiers.

---

## Basic User Tracking Flow

```text
User Registers / Logs In
          ↓
iOS Application
          ↓
Identify User
          ↓
NVECTA User Profile Updated
          ↓
Events & Campaigns Linked To User
```

Example:

```text
User signs up
      ↓
Set Email & Mobile Number
      ↓
NVECTA creates/updates user profile
      ↓
Future events are mapped to the same user
```

<br>

## Create User Profile

Assign a unique identifier to a user after they sign in or register.

> **Note**
>
> Use a unique and stable identifier (such as your application's User ID or Customer ID). Avoid using temporary values that may change over time.

### Swift

```swift
var userParams: [String : Any] = [:]

userParams["userID"] = "78-ASD"
userParams["name"] = "John"
userParams["email"] = "john123@example.com"
userParams["mobile"] = "9999999999"

NVECTA.shared.userIdentifier(WithUserParams: userParams) { (result: Result<UserTrackResponse, any Error>) in
    print("user tracking resut response = \(result)")
}
```

<details>
<summary>Objective-C</summary>

```objective-c
NSDictionary *userParamsDict = @{@"name": @"John", @"email" : @"john123@gmail.com", @"mobile": @"9999999999" , @"userID": @"78-ASD"};

[[NVECTA shared] userIdentifierWithUserParams: userParamsDict onUserTrackListener:^(NSDictionary * onTrackUserResponse) {
         NSLog(@"user tracking resut response = %@", onTrackUserResponse);
}];
```

 </details>

<br>

## Common User Attributes

The following attributes are commonly used while identifying users.

| Attribute         | Description                |
| ----------------- | -------------------------- |
| email             | User email address         |
| mobile            | Mobile number              |
| name              | Full name                  |
| userID            | Unique customer identifier |
| gender            | User gender                |
| city              | User city                  |
| country           | User country               |
| subscription_type | Current plan               |
| customer_type     | Premium, Free, etc.        |

<br>

## Track Additional User Attributes

You can enrich user profiles with custom attributes.

Typical attributes include:

- Gender
- City
- Country
- Subscription Plan
- Membership Level

### Swift

```swift
var userProfile: [String : Any] = [:]

userProfile["name"] = "John Doe"
userProfile["email"] = "john@example.com"
userProfile["mobile"] = "+91XXXXXXXXXX"
userProfile["city"] = "New Delhi"
userProfile["plan"] = "Premium"

NVECTA.shared.userIdentifier(WithUserParams: userProfile) { (result: Result<UserTrackResponse, any Error>) in
    print("user tracking resut response = \(result)")
}
```

<details>
<summary>Objective-C</summary>

```objective-c
NSDictionary *userProfileDict = @{@"name": @"John Doe", @"email" : @"john@example.com", @"mobile": @"+91XXXXXXXXXX", @"city": @"New Delhi", @"plan": @"Premium"};

[[NVECTA shared] userIdentifierWithUserParams: userProfileDict onUserTrackListener:^(NSDictionary * onTrackUserResponse) {
         NSLog(@"user tracking resut response = %@", onTrackUserResponse);
}];
```

 </details>

## User Tracking Callback Response

| STATUS  | MESSAGE                           | TYPE |
| ------- | --------------------------------- | ---- |
| Success | User profile updated successfully | `0`  |
| Fail    | Invalid user data found           | `1`  |
| Fail    | Authentication failed             | `3`  |
| Fail    | No internet connection found      | `4`  |
| Fail    | User tracking disabled from panel | `5`  |
| Fail    | Internal processing error         | `6`  |

## User Profile Best Practices

### Identify Users After Login

Always call user tracking after successful login or signup.

```text
Login Success
      ↓
Track User
      ↓
Track Events
```

### Use Consistent Identifiers

Use the same email, mobile number, or customer ID across sessions.

```text
Good:
john@example.com

Bad:
john@gmail.com
john.doe@gmail.com
```

### Update User Properties When Changed

Whenever user details change, update the profile again.

Examples:

- Email updated
- Mobile number changed
- Subscription upgraded
- User moved to another city

---

## Common Use Cases

### Example: User Registration

#### Swift

```swift
var userProfile: [String : Any] = [:]

userProfile["name"] = "John Doe"
userProfile["email"] = "john@example.com"
userProfile["userID"] = "USER_1001"

NVECTA.shared.userIdentifier(WithUserParams: userProfile) { (result: Result<UserTrackResponse, any Error>) in
    print("user tracking resut response = \(result)")
}
```

<details>
<summary>Objective-C</summary>

```objective-c
NSDictionary *userProfileDict = @{@"name": @"John Doe", @"email" : @"john@example.com", @"userID": @"USER_1001"};

[[NVECTA shared] userIdentifierWithUserParams: userProfileDict onUserTrackListener:^(NSDictionary * onTrackUserResponse) {
         NSLog(@"user tracking resut response = %@", onTrackUserResponse);
}];
```

 </details>

 <br>

After this, any event tracked by the SDK becomes associated with the identified user profile.

### Example: Subscription Upgrade

#### Swift

```swift
var userProfile: [String : Any] = ["plan"] = "Gold"

NVECTA.shared.userIdentifier(WithUserParams: userProfile) { (result: Result<UserTrackResponse, any Error>) in
    print("user tracking resut response = \(result)")
}
```

<details>
<summary>Objective-C</summary>

```objective-c

[[NVECTA shared] userIdentifierWithUserParams: @{@"plan": @"Gold"}; onUserTrackListener:^(NSDictionary * onTrackUserResponse) {
         NSLog(@"user tracking resut response = %@", onTrackUserResponse);
}];
```

 </details>

<br>

## Event Tracking After User Identification

### Overview

To ensure events are properly mapped to user profiles on the NVECTA panel, you must wait for the user identification callback response before triggering any events.

**Important:** If you call event tracking and user identification in parallel, the SDK may not be able to merge the data correctly on the panel because the user profile hasn't been fully synchronized yet.

---

### Correct Implementation Flow

```text
User Login Triggered
       ↓
Call userIdentifierWithUserParams()
       ↓
Wait for Callback Response
       ↓
Check Response Status
       ↓
If Success: Track Events
       ↓
Events Get Mapped to User Profile
```

---

### Wait for User Identification Before Tracking Events

If you're identifying a user and immediately tracking an event (such as **Login**, **Sign Up**, or **Purchase**), always wait for the user identification callback before sending the event.

#### ❌ Incorrect

Tracking an event immediately after calling `userIdentifier()` may cause it to be associated with an anonymous or incorrect user profile.

#### Swift

```swift
var userProfile: [String : Any] = [:]

userProfile["name"] = "John Doe"
userProfile["email"] = "john@example.com"
userProfile["mobile"] = "+91XXXXXXXXXX"
userProfile["city"] = "New Delhi"
userProfile["plan"] = "Premium"

NVECTA.shared.userIdentifier(WithUserParams: userProfile) { (result: Result<UserTrackResponse, any Error>) in
    print("user tracking resut response = \(result)")
}
NVECTA.shared.trackEvent(forEventName: "login_successful", attributes: nil, ltv: "0", scope: 1)
```

<details>
<summary>Objective-C</summary>

```objective-c
NSDictionary *userProfileDict = @{@"name": @"John Doe", @"email" : @"john@example.com", @"mobile": @"+91XXXXXXXXXX", @"city": @"New Delhi", @"plan": @"Premium"};

[[NVECTA shared] userIdentifierWithUserParams: userProfileDict onUserTrackListener:^(NSDictionary * onTrackUserResponse) {
         NSLog(@"user tracking resut response = %@", onTrackUserResponse);
}];

[[NVECTA shared] trackEventForEventName: @"login_successful" attributes: nil, ltv: @"0", scope: 1];
```

 </details>

---

#### ✅ Correct

Wait until the user identification operation completes successfully before tracking any user-specific events.

#### Swift

```swift
var userProfile: [String : Any] = [:]

userProfile["name"] = "John Doe"
userProfile["email"] = "john@example.com"
userProfile["mobile"] = "+91XXXXXXXXXX"
userProfile["city"] = "New Delhi"
userProfile["plan"] = "Premium"

NVECTA.shared.userIdentifier(WithUserParams: userProfile) { (result: Result<UserTrackResponse, any Error>) in
    print("user tracking resut response = \(result)")
    NVECTA.shared.trackEvent(forEventName: "login_successful", attributes: nil, ltv: "0", scope: 1)
}
```

<details>
<summary>Objective-C</summary>

```objective-c
NSDictionary *userProfileDict = @{@"name": @"John Doe", @"email" : @"john@example.com", @"mobile": @"+91XXXXXXXXXX", @"city": @"New Delhi", @"plan": @"Premium"};

[[NVECTA shared] userIdentifierWithUserParams: userProfileDict onUserTrackListener:^(NSDictionary * onTrackUserResponse) {
         NSLog(@"user tracking resut response = %@", onTrackUserResponse);
         [[NVECTA shared] trackEventForEventName: @"login_successful" attributes: nil, ltv: @"0", scope: 1];
}];
```

 </details>

 <br>

> **Why is this important?**
>
> User identification and event tracking are asynchronous operations. Waiting for the user identification callback ensures that subsequent events are associated with the correct user profile.

> **Tip**
>
> When performing multiple SDK operations sequentially, always chain them using callbacks (or coroutines where supported) instead of executing them in parallel.

---

### Key Takeaways

1. **Always wait for `userIdentifier()` callback** before tracking events
2. **Check the response status** to ensure user identification was successful
3. **Verify response is not null** before accessing its properties
4. **Handle errors gracefully** with try-catch blocks
5. **Track events only after user sync completes** to ensure proper mapping on NVECTA panel

---

## Recommended Flow

```text
App Launch
    ↓
User Login
    ↓
Track User Profile
    ↓
Wait for Response
    ↓
Track Custom Events
    ↓
Send Push Notifications
    ↓
Create User Segments
```

## Best Practices

- Track users immediately after a successful login or sign-up.
- Always use a unique and permanent User ID from your application.
- Keep user attributes up to date whenever profile information changes.
- Use consistent attribute names throughout your application (for example, always use `email` instead of mixing `email`, `email_id`, or `userEmail`).
- Use custom attributes to improve user segmentation and personalized campaigns.
- Avoid sending sensitive or confidential information, such as passwords, OTPs, payment details, or authentication tokens.
- Wait for the user identification callback to confirm the operation before tracking dependent events or performing subsequent user-related actions.
- Always check the callback response status before proceeding with the next operation.
- When performing multiple SDK operations sequentially, use asynchronous callbacks (or `async/await` where supported) to ensure the correct execution order.

---

## 🆔 NVECTA UID

The **NVECTA UID (NV UID)** is a unique identifier automatically generated by the NVECTA platform for every app user, whether they are **identified** or **anonymous**.

This identifier is used internally by NVECTA to recognize users across sessions and can also be used within your application whenever a unique NVECTA user identifier is required.

You can view the NV UID for each user in the **NVECTA Dashboard → Mobile Push → Subscribers**.

### Get the NV UID

Use the following function to retrieve the current user's NV UID.

#### Swift

```swift
let nvUIDStr = NVECTA.shared.getNvUid()
if (!nvUIDStr?.isEmpty) {
  print("NVECTA nv uid = \(nvUIDStr)")
}
```

<details>
<summary>Objective-C</summary>

```objective-c

NSString *nvUIDStr = [[NVECTA shared] getNvUid];
if([nvUIDStr length] > 0) {
  NSLog(@"NVECTA nv uid = %@", nvUIDStr);
}
```

 </details>

---

#### Example output:

```text
NVECTA nv uid = cb506278-d427-458a-976b-00748de49bdc
```

---

### Important Notes

- The NV UID is generated and managed automatically by the NVECTA platform.
- It is available for both anonymous and identified users.
- The returned value may be `null` or an empty string if the SDK has not yet generated or synchronized the NV UID.
- Check that the returned value is valid before using it in your application.

<br>

## Summary

User tracking enables NVECTA to create a unified customer profile by linking user attributes, events, purchases, and engagement activities to a single user.

With proper user identification, you can:

- Build customer profiles
- Segment audiences
- Personalize campaigns
- Improve retention
- Analyze customer behavior

**Remember:** Always wait for the user identification callback response before tracking events to ensure proper data synchronization and event mapping on the NVECTA panel.

## Related Documentation

Continue exploring other SDK features:

- [📊 Track Events](./EventTracking.md)s
- [🔔 Push Notifications](../PushNotifications/PushAppConfiguration.md)
- [💬 In-App Notifications & Nudges](./InAppNotifications.md)
- [📥 Inbox / Notificatin Center](./NotificationCenter.md)
