Pod::Spec.new do |s|
  s.name         = "ExtGenerator"
  s.version      = "0.0.1"
  s.summary      = "Generator for objC"
  s.homepage     = "https://github.com/Pn-X/ExtGenerator"
  s.license      = "MIT" 
  s.author       = { "pn-x" => "pannetez@163.com" }
  s.source       = { :git => "https://github.com/Pn-X/ExtGenerator.git", :tag => "#{s.version}" }
  s.source_files  = "Classes", "Classes/**/*"
  s.exclude_files = "Classes/Exclude"
  s.ios.deployment_target = '9.0'
end