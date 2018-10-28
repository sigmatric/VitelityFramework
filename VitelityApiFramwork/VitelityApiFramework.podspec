Pod::Spec.new do |s|
  s.name         = "VitelityApiFramework"
  s.version      = "1.0.0"
  s.summary      = "this is the VitelityApiFramework."
  s.description  = "This framework is under development please be patient!!!"
  s.homepage     = "https://github.com/sigmatric/VitelityFramework"
  # s.screenshots  = "www.example.com/screenshots_1.gif", "www.example.com/screenshots_2.gif"
  s.license      = "MIT"
  s.author       = { "Jorge Dominguez" => "jorge@sigmatric.com" }
  s.platform     = :ios, "11.0"
  s.source       = { :git => "https://github.com/sigmatric/VitelityFramework.git", :tag => "#{s.version}" }
  s.source_files  = "VitelityApiFramework","**/*.{h,m,swift}"
end
