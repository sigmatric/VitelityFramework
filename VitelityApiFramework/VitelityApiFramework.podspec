Pod::Spec.new do |s|
  s.name         = "VitelityApiFramework"
  s.version      = "1.0.0"
  s.summary      = "this is my first VitelityApiFramework."
  s.description  = "This project is under developemnt!! this is comming soon please be patient!!!"
  s.homepage     = "https://github.com/sigmatric/VitelityFramework"
  s.license      = "MIT"
  s.author       = { "Jorge Dominguez" => "jorge@sigmatric.com" }
  s.platform     = :ios, "11.0"
  s.source       = { :git => "https://github.com/sigmatric/VitelityFramework.git", :tag => "#{s.version}" }
  s.source_files  = "VitelityApiFramework","**/*.{h,m,swift}"
end
