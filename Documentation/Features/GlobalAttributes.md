# Global Attributes

`Global Attributes` are `key–value` pairs you set once and NVECTA automatically attaches to the events that follow — so you don't have to repeat them in every `trackEvent()` call. They're ideal for context that applies broadly across a session, such as a campaign_id, an experiment variant, or a membership_plan you want carried onto many events at once.

Common values passed as Global Attributes include:

- Campaign_id
- Experiment
- Membership_plan
- Referral_code

> #### 🛠️ Prerequisite
>
> - Global Attributes are available from notifyvisitors(v8.0.2) / NVECTA iOS SDK onwards. Upgrade to latest SDK before using the methods on this page.
> - This guide also assumes you're familiar with System Events and Custom Events. If not, start with the [Tracking Events](./EventTracking.md) guide.

## Which events they apply to

Once set, global attributes are automatically included on:

- All Custom Events you track with the `trackEvents()` method
- Automatically captured system events, such as `install`, `update`, `app_launch`, and `session_start`

## Setting Global Attributes

Use this method to define the Global Attributes that should be included with your events.

### Syntax

#### Swift

```swift
notifyvisitors.setGlobalAttributes(_ attributes: [String: Any])
```

<details>
<summary>Objective-C</summary>

```objective-c
[notifyvisitors setGlobalAttributes:(NSDictionary<NSString *, id> *)attributes];
```

</details>

#### Example:

#### Swift

```swift
notifyvisitors.setGlobalAttributes(["campaign_id": "SUMMER_2026",
                                    "membership_plan": "Premium"])
```

<details>
<summary>Objective-C</summary>

```objective-c
[notifyvisitors setGlobalAttributes: @{@"campaign_id": @"SUMMER_2026",
                                      @"membership_plan": @"Premium"}];
```

</details>

<br>

After setting the above `Global Attributes`, both auto-captured and custom events will automatically include:

```json
{
  "campaign_id": "SUMMER_2026",
  "membership_plan": "Premium"
}
```

- If you define `Global Attributes` in the `AppDelegate` before calling `initialize()`, they are automatically attached to system events such as `install`, `update`, `app_launch`, and `session_start`. Defining them during application startup ensures these events include the required attributes and prevents them from being missed.

- You can also call this method from anywhere in your application to add, update, or overwrite `Global Attributes` for subsequent events.

## Updating global attributes

Use `setGlobalAttributes()` to add new `Global Attributes` or update the values of existing ones.

#### Swift

```swift
notifyvisitors.setGlobalAttributes(["membership_plan": "Gold"])
```

<details>
<summary>Objective-C</summary>

```objective-c
[notifyvisitors setGlobalAttributes: @{@"membership_plan": @"Gold"}];
```

</details>

<br>

Only the specified attributes are added or updated. Any existing Global Attributes that are not included in the request remain unchanged.

## Removing global attributes

Remove a single attribute by key with `removeGlobalAttribute()`:

#### Swift

```swift
notifyvisitors.removeGlobalAttribute(forKey: "campaign_id")
```

<details>
<summary>Objective-C</summary>

```objective-c
[notifyvisitors removeGlobalAttributeForKey: @"campaign_id"];
```

</details>

<br>

The removed attribute will no longer be included in future events.

Clear all Global Attributes with `clearGlobalAttributes()`:

#### Swift

```swift
notifyvisitors.clearGlobalAttributes()
```

<details>
<summary>Objective-C</summary>

```objective-c
[notifyvisitors clearGlobalAttributes];
```

</details>

<br>

After clearing, none of the previously defined `Global Attributes` will be attached to future events.

## Persistence: how long they last

How long `Global Attributes` stay available is controlled by a `persistence` mode. This is an optional configuration — if you don't set it explicitly, NVECTA uses `Session`. Configure a mode only when you need behaviour other than the default.

NVECTA supports three persistence modes:

| Mode                | Survives app restart | Cleared when                                                                                    | expiryInDays      |
| ------------------- | -------------------- | ----------------------------------------------------------------------------------------------- | ----------------- |
| `memory`            | `No`                 | The app is restarted or the process is terminated (lives only while the app process is running) | Not used — pass 0 |
| `session (default)` | `Yes`                | The current app session ends                                                                    | Not used — pass 0 |
| `persistent`        | `Yes`                | The configured expiryInDays value elapses                                                       | Required          |

---

<br>

- `Memory` stores attributes only while the app process is alive.
- `Session (default)` keeps attributes for the current app session and clears them automatically when the session ends. This mode applies automatically if you never call globalAttributesPersistenceOptions().
- `Persistent` is the only mode that stores attributes on the device, so they remain available after the app is closed or restarted.

> #### Set the mode before initialize()
>
> If you want a mode other than the default, configure it in your app's AppDelegate before calling NVECTA's `initialize()` method, so the SDK can initialize and manage `Global Attributes` correctly.

### Syntax

#### Swift

```swift
notifyvisitors.globalAttributesPersistenceOptions(persistenceType: nvGlobalAttributePersistenceType, expiryInDays: Int)
```

<details>
<summary>Objective-C</summary>

```objective-c
[notifyvisitors globalAttributesPersistenceOptions: (nvGlobalAttributePersistenceType)persistenceType expiryInDays: (NSInteger)expiryInDays];
```

</details>

<br>

> expiryInDays applies only to Persistent mode
>
> Use 0 for Memory and Session modes.

#### Example:

#### Swift

```swift
// Memory
notifyvisitors.globalAttributesPersistenceOptions(persistenceType: .memory, expiryInDays: 0)
notifyvisitors.initialize(nvMode)

// Session
notifyvisitors.globalAttributesPersistenceOptions(persistenceType: .session, expiryInDays: 0)
notifyvisitors.initialize(nvMode)

// Persistent
notifyvisitors.globalAttributesPersistenceOptions(persistenceType: .persistent, expiryInDays: 10)
notifyvisitors.initialize(nvMode)
```

<details>
<summary>Objective-C</summary>

```objective-c
// Memory
[notifyvisitors globalAttributesPersistenceOptions:nvGlobalAttributePersistenceTypeMemory expiryInDays:0];
[notifyvisitors initialize:nvMode];

// Session
[notifyvisitors globalAttributesPersistenceOptions:nvGlobalAttributePersistenceTypeSession expiryInDays:0];
[notifyvisitors initialize:nvMode];

// Persistent
[notifyvisitors globalAttributesPersistenceOptions:nvGlobalAttributePersistenceTypePersistent expiryInDays:10];
[notifyvisitors initialize:nvMode];
```

</details>

### Good to know

- `Global Attributes` are best suited for values that should be sent with multiple events, such as attribution data, experiment IDs, user context, or checkout information.
- If an attribute is relevant to only a single event, pass it directly in the attributes parameter of the `trackEvent()` method instead.
- Use distinct names for `Global Attributes` and event attributes to keep your data clean and unambiguous.
- Persistence is optional. If you never configure it, `Global Attributes` use the `session` mode by default.
