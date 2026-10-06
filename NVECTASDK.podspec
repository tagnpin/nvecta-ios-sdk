Pod::Spec.new do |spec|
  spec.name         = "NVECTASDK"
  spec.version      = "1.0.1"
  spec.summary      = "NVECTASDK for iOS. Turn customer data into autonomous growth| Powered by Agentic AI."
  spec.description  = <<-DESC
  NVECTA is an AI-powered platform that transforms data into instant answers,
  predictive segments, and self-optimizing campaigns,
  so your team can focus on strategy while growth runs on autopilot.
                   DESC

  spec.homepage     = "https://github.com/tagnpin/nvecta-ios-sdk"
  spec.license      = { :type => 'MIT', :file => 'LICENSE' }
  spec.author       = { "MOHAMMAD ASHRAF ALI" => "ashraf@nvecta.com" }
  spec.platform     = :ios
  spec.platform     = :ios, "13.0"
  spec.source       = { :git => "https://github.com/tagnpin/nvecta-ios-sdk.git", :tag => "1.0.2" }
  spec.vendored_frameworks = 'Frameworks/NVECTASDK.xcframework'


end
