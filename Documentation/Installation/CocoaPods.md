# CocoaPods Installation

| :bulb: We strongly recommend integrate the NVECTASDK via [Swift Package Manager](../Installation/SwiftPackageManager.md). However, if you are unable to do so you can integrate our `notifyvisitors` SDK via cocoapod using the instruction given below. |
| -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |

NVECTA iOS SDK can not be integrated via CocoaPods you can use our `notifyvisitors` SDK into your iOS application using CocoaPods.

---

## Integrate the `notifyvisitors` iOS SDK Through CocoaPods

1.  Open terminal and install cocoapods in your Mac if not installed yet. Type the following command in your terminal app to install the cocoapods in your system.

    ```ruby
        $ sudo gem install cocoapods
    ```

2.  Now if you don’t have a `Podfile` then create it first. To do so inside the `terminal` app go to your `Xcode` project root folder using cd command. For example, if your Project is saved on `Desktop` and its root folder name is `MyAPP` then go to your project root folder by using the following command.

    ```ruby
       $ cd ~/Desktop/MyApp
    ```

    And now inside the root folder of your project in the terminal, run the following command to generate a Podfile into your project’s root folder.

    ```ruby
       $ pod init
    ```

3.  Now Open your `Podfile` or the newly created `Podfile` with your favorite text Editor like: textEdit, Vim, Sublime etc.

4.  Now open your application's `Podfile` and add the notifyVisitors dependency under your project name target like below.

    ```ruby
    target 'Your_ProjectName' do
        pod 'notifyvisitors'
    end
    ```

5.  Make sure your current `Xcode` project is closed and in the project root, run the following command from the terminal.

    ```ruby
       $ pod repo update
       $ pod install
    ```

6.  Now open the newly created `<Your_Project_Name>.xcworkspace` file.

    > 📋 **Note**
    >
    > Make sure to always open the workspace from now on.

<br>

## 📊 What's Next?

Now you can refer to our official website documentation to proceed the remaining integration steps.

Official Documentation: <br>
https://www.nvecta.com/docs/ios-integration
