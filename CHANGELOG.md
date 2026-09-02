# CHANGE LOG

## Version 1.0.1 _(September 02, 2026)_

This is the release of updated `NVECTASDK (v~1.0.1)` through `Swift Package Manager (SPM)`.

### Added

- Introducing `NVECTAAdTrackingSDK` to track IDFA as an optional dependency. If you app is using idfa or you want to track idfa you need to use this optional dependency along with your core dependency.

### Updated

- Updated `notifyvisitors (v~8.0.3)` framework to support `NVECTAAdTrackingSDK` and track IDFA via this new dependency only.
- Updated `NVECTASDK (v~1.0.1)` with remaining `notifyvisitors` functions to access via `NVECTASDK` 
- bug fixes
- code optimisation and performance enhancement


## Version 1.0.0 _(August 26, 2026)_

This is the first release of `NVECTASDK` through `Swift Package Manager (SPM)`.

### Added

- Added Swift Package Manager support.
- Introduced `NVECTASDK` as the recommended Swift API.
- Added support for using the SDK through Swift Package Manager.

### Updated

- Internal event tracking optimisations
- Updated binary framework packaging for Swift Package Manager.
- bug fixes
- code optimisation and performance enhancement

### Migration

- Existing `notifyvisitors` integrations can continue using the existing APIs.
- New integrations are recommended to use `NVECTASDK`.
- Existing `CocoaPods` and `Manual XCFramework` users are recommended to migrate to `Swift Package Manager`.

For migration instructions:

- [CocoaPods → Swift Package Manager](./Documentation/Migration/CocoaPodsToSPM.md)
- [Manual XCFramework → Swift Package Manager](./Documentation/Migration/ManualToSPM.md)
