Pod::Spec.new do |s|
  s.name             = 'WebKitUserAgent'
  s.version          = '0.1.0'
  s.summary          = 'Conveniently getting the User Agent through WKWebView'

  s.description      = <<-DESC
The library provides the ability to conveniently getting the User Agent through WKWebView.
                       DESC

  s.homepage         = 'https://github.com/dmytriigolovanov/webkit-user-agent'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Dmytrii Golovanov' => 'dmyrii.golovanov@google.com' }

  s.source           = {
    :git => 'https://github.com/dmytriigolovanov/webkit-user-agent.git',
    :tag => 'v' + s.version.to_s
  }

  s.preserve_paths = [
    "README.md",
    "WebKitUserAgent/CHANGELOG.md"
  ]

  s.ios.deployment_target = "9.0"
  s.osx.deployment_target = '10.11'

  s.swift_version = "5.0"

  s.source_files  = "WebKitUserAgent/Sources/**/*"
end
