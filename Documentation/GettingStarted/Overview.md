# iOS SDK Overview

## Introduction

NVNewSwiftSDK is the iOS SDK distribution package for integrating NotifyVisitors functionality into native iOS applications.

The SDK is distributed through Swift Package Manager (SPM) using prebuilt XCFramework binaries. No SDK source code is required to be added to the client application.

The package provides the main Swift SDK along with optional SDK components that can be installed only when the corresponding functionality is required.

---

## SDK Components

The package currently provides the following products:

| Product                    | Purpose                            | Usage                                                                                             |
| -------------------------- | ---------------------------------- | ------------------------------------------------------------------------------------------------- |
| `NVNewSwiftSDK`            | Main Swift SDK                     | Recommended for new integrations                                                                  |
| `myObjcCoreSDK`            | Existing Objective-C core SDK      | Recommended for existing integrations migrating from CocoaPods or manual XCFramework installation |
| `mySwiftOptionalSDK`       | Optional SDK component             | Install only when the corresponding functionality is required                                     |
| `myNotificationServiceExt` | Notification Service Extension SDK | Install only in the Notification Service Extension target                                         |

---

## Main SDK

### NVNewSwiftSDK

`NVNewSwiftSDK` is the primary SDK for new iOS integrations.

It provides the Swift-facing API used by new applications and internally works with the existing core SDK components where required.

The internal implementation can evolve independently while maintaining the public integration experience for applications using `NVNewSwiftSDK`.

For new applications, `NVNewSwiftSDK` should be the primary package product added to the main application target.

---

## Existing Objective-C SDK

### myObjcCoreSDK

`myObjcCoreSDK` is the existing Objective-C SDK that is already used by applications through CocoaPods or manually distributed XCFrameworks.

It remains available as an independent Swift Package Manager product to support existing applications migrating to SPM.

The migration is designed so that applications using the existing Objective-C SDK APIs do not need to rewrite their existing SDK integration code.

The primary change during migration is the dependency distribution mechanism:

```text
Before

CocoaPods / Manual XCFramework
        ↓
myObjcCoreSDK
        ↓
Existing application integration


After

Swift Package Manager
        ↓
myObjcCoreSDK
        ↓
Existing application integration
```
