Pod::Spec.new do |s|

  s.name         = "MHAppKit"
  s.version      = "1.13.0"
  s.source       = { :git => "https://github.com/KoCMoHaBTa/#{s.name}.git", :tag => "#{s.version}" }
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author       = "Milen Halachev"
  s.summary      = "A collection of useful tools that makes developer's life easier."
  s.homepage     = "https://github.com/KoCMoHaBTa/#{s.name}"

  s.swift_version = "5.7"
  s.ios.deployment_target = "11.0"

  s.source_files  = "#{s.name}/**/*.swift", "#{s.name}/**/*.{h,m}"
  s.public_header_files = "#{s.name}/**/*.h"
  s.resources = "#{s.name}/**/*.xib"

end
