Pod::Spec.new do |s|
  s.name             = 'WebKitUserAgent'
  s.version          = '2.0.2'
  s.summary          = 'Conveniently getting the User Agent through WKWebView'

  s.description      = <<-DESC
The library provides the ability to conveniently getting the User Agent through WKWebView.
                       DESC

  s.homepage         = 'https://github.com/dmytriigolovanov/webkit-user-agent'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Dmytrii Golovanov' => 'dmyrii.golovanov@gmail.com' }

  s.source           = {
    :git => 'https://github.com/dmytriigolovanov/webkit-user-agent.git',
    :tag => 'v' + s.version.to_s
  }

  s.preserve_paths = [
    "README.md",
    "CHANGELOG.md"
  ]

  s.ios.deployment_target = "11.0"
  s.osx.deployment_target = '10.13'
  
  s.ios.frameworks = [
      "WebKit",
      "UIKit"
  ]
  s.osx.framework = 'WebKit'

  s.swift_version = "5.3"

  s.source_files  = "WebKitUserAgent/Sources/**/*"
end
