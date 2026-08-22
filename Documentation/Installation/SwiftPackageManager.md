# Swift Package Manager (Recommended)

NVECTA iOS SDK is distributed as a binary Swift Package through `Swift Package Manager (SPM)`.

This guide explains how to add the SDK to an iOS application and configure the individual package products for the appropriate application targets.

## 📋 Requirements

- iOS 13.0 or later
- Xcode 26.0 or later
- Use a version of Xcode that supports the Swift Package Manager tools version declared by the package.

  The current package uses:

  ```text
    Swift Package Manager tools version: 6.2
  ```

---

## 1. Add NVECTA iOS SDK

Open your iOS application in Xcode.

From the Xcode menu, select:

- **File → Add Package Dependencies...**

<p align="center">
  <img
    src="../Images/spm/spm-add-dependency-page.png"
    alt="Add Package Dependencies"
     height="400"
  />
</p>

- Enter the NVECTA iOS SDK GitHub repository URL:

  ```text
      https://github.com/tagnpin/nvecta-ios-sdk
  ```

    <p align="center">
      <img
          src="../Images/spm/spm-select-nvecta-dependency.png"
          alt="Select NVECTA Dependency"
          height="400"
      />
    </p>

- Click `Add Package` and ensure that the NVECTA iOS SDK has been added to the appropriate target.

    <p align="center">
      <img
          src="../Images/spm/spm-nvecta-sdks-default-target.png"
          alt="Add NVECTA Dependency to Main Target"
          height="200"
      />
    </p>

<br>

## 📊 What's Next?

Now go back to the home page of the documentation and cntinue the from the [Integrate NVECTA into Your iOS App](../../README.md) heading.
