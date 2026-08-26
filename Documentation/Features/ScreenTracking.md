# Screen Tracking Guide

## 📱 What is Screen Tracking?

Screen tracking monitors which screens (pages) your users visit in your iOS app. Think of it like a visitor counter for each page - it records when users open a screen and how long they stay there.

**Simple Example:**

- User opens your app → Home screen is tracked
- User navigates to Profile → Profile screen is tracked
- User goes back to Home → Home is tracked again

<!-- Official Documentation: <br>
https://www.nvecta.com/docs/native-android -->

## ❓ Why Should You Use Screen Tracking?

### 1. **Understand Your Users**

- See which screens users visit most
- Find out where users spend the most time
- Understand how users navigate through your app

### 2. **Improve Your App**

- Identify slow or buggy screens
- Find screens that users leave quickly (and fix them)
- Make data-driven decisions about new features

### 3. **Track User Goals**

- See how many users complete important actions
- Find where users get stuck or stop using the app
- Measure if your changes actually helped

### 4. **Debug Problems**

- When a user reports a bug, see exactly which screens they visited before it happened
- Understand the sequence of screens leading to a crash

---

## 🚀 How to Implement Screen Tracking

### Automatic Tracking (Recommended)

Once the NVECTA IOS SDK is integrated and initialized, the SDK automatically logs screen views whenever a user transitions between Activities or Fragments.

- No additional code changes are required.
- Each screen transition automatically generates a screen_view event that captures:
  - Screen name
  - App version
  - Other contextual information (device, session, user identifiers, etc.)

This ensures you get a complete picture of user journeys across your app without extra development effort.

### Manual Tracking

In some cases, you may want more control over screen tracking, especially when:

- Your app uses custom navigation frameworks.
- You want to track specific sub-views within a single Activity or Fragment.
- You want to override the automatically logged screen name with a custom identifier.

<br>

> [!NOTE]
> **Automatic screen tracking is enabled by default.**
>
> If you want to manually control all screen tracking events, disable automatic screen tracking by adding the following `boolean` key and set it's value to fasle inside your application's `info.plist` file:
>
> ```xml
> <key>nvAutoScreenTracking</key>
>    <false/>
> ```
>
> Once disabled, the SDK will no longer automatically log screen views. You must explicitly call `trackScreen()` whenever you want to record a screen view.

Notice that the value should be false, not true, because you're describing how to stop automatic tracking. If the value is true, automatic tracking remains enabled.

#### The Basic Function

#### Swift

```swift
NVECTA.shared.trackScreen(forScreenName: "YOUR_SCREEN_NAME")
```

<details>
<summary>Objective-C</summary>

```objective-c
[[NVECTA shared] trackScreenForScreenName: @"screen_name"];
```

</details>

<br>

This one line of code tells the SDK: _"User is now on 'ScreenName'"_

---

#### Parameters

- "screen_name" → A unique identifier (String) for the screen.
  - Use clear, consistent names for screens (e.g., "HomeScreen", "ProductDetails", "CartScreen", "PaymentConfirmation").
  - This naming consistency ensures reports are meaningful.

## ✅ Best Practices

### 1. **Use Meaningful Screen Names**

```swift
// ❌ Bad
NVECTA.shared.trackScreen(forScreenName: "Screen1")

// ✅ Good
NVECTA.shared.trackScreen(forScreenName: "HomePage")
NVECTA.shared.trackScreen(forScreenName: "UserProfile")
NVECTA.shared.trackScreen(forScreenName: "ProductDetail_12345")
```

### 2. **Be Consistent**

- Use the same screen name every time you visit that screen
- Use camelCase or PascalCase consistently

### 3. **Track Important Flows**

Focus on tracking screens that matter:

- Login/Signup flows
- Purchase/Checkout flows
- Onboarding screens
- Error/Help screens

### 4. **Include Context When Needed**

```swift
// Good: Includes item ID for detailed analytics
NVECTA.shared.trackScreen(forScreenName: "ProductDetail_\(productId)")
```

---
