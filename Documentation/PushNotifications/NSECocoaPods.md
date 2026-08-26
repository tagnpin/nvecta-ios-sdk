# CocoaPods Installation (for Notification Service Extension)

| :bulb: We strongly recommend integrate the `notifyvisitorsNotificationService` via [Swift Package Manager](./NotificationServiceExtension.md). However, if you are unable to do so you can integrate our `notifyvisitorsNotificationService` to your `Notification Service Extension` target via cocoapod using the instruction given below. |
| -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |

<br>

`notifyvisitorsNotificationService` iOS SDK can not be integrated via CocoaPods into your `Notification Service Extension` target.

## Integrate the `notifyvisitorsNotificationService` iOS SDK Through CocoaPods

If you are using cocoapods to integrate `notifyVisitors` SDK in the main target of your project, then it is recommended to install our `notifyvisitorsNotificationService` cocoapod in your `Notification Service Extension` target via cocoapods dependency. To do so, follow the below steps.

1. Close your project opened in Xcode, then open your `Podfile` with your favorite text editor like: `textEdit`, `Vim`, `Sublime`, etc. This is the same `Podfile` that is already created in your project’s root folder while integrating `notifyvisitors` SDK in your main project target.

2. Add the `notifyvisitorsNotificationService` dependency at the end within the `Podfile` for your `Notification Service Extension` name target like below.

   ```ruby
       target 'YourNotificationServiceExtension' do
           pod 'notifyvisitorsNotificationService'
       end
   ```

3. Make sure your current `Xcode` project is closed and run the following command in the terminal from the project root directory.

   ```ruby
      $ pod install
   ```

4. Now, re-open your project into Xcode by double clicking on `<Your_Project_Name>.xcworkspace` file and follow the steps mentioned below to complete the remaining `Notification Service Extension` integration process.

## 📊 What's Next?

Now go back to the `Notification Service Extension` documentation and cntinue the from the [Import Notification Service SDK](./NotificationServiceExtension.md) heading.
