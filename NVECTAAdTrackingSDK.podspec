Pod::Spec.new do |spec|

  spec.name         = "NVECTAAdTrackingSDK"
  spec.version      = "1.0.0"
  spec.summary      = "NVECTAAdTrackingSDK dependency for optional IDFA retrieval for iOS apps using NVECTASDK or the notifyvisitors SDK."
  spec.description  = <<-DESC
  NVECTAAdTrackingSDK is an optional dependency that handles App Tracking Transparency (ATT) authorization and IDFA (Identifier for Advertisers) retrieval for applications using NVECTASDK or the notifyvisitors SDK.
  When integrated, the tracking SDK communicates the available tracking state and IDFA internally to the core SDK. Applications that do not require IDFA can use the core SDK without this dependency.
                   DESC

  spec.homepage     = "https://github.com/tagnpin/nvecta-ios-sdk"
  spec.license      = { :type => 'MIT', :file => 'LICENSE' }
  spec.author       = { "MOHAMMAD ASHRAF ALI" => "ashraf@nvecta.com" }

  spec.platform     = :ios
  spec.platform     = :ios, "15.0"

  spec.source       = { :git => "https://github.com/tagnpin/nvecta-ios-sdk.git", :tag => "1.0.2" }
  spec.vendored_frameworks = 'Frameworks/NVECTAAdTrackingSDK.xcframework'

end
