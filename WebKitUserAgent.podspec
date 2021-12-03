Pod::Spec.new do |s|
  s.name             = 'WebKitUserAgent'
  s.version          = '0.1.0'
  s.summary          = 'WebKit UserAgent'

  s.description      = <<-DESC
Get the UserAgent from WKWebView.
                       DESC

  s.homepage         = 'https://github.com/dmytriigolovanov/webkit-user-agent'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.authors          = 'Dmytrii Golovanov'

  s.source           = {
    :git => 'https://github.com/dmytriigolovanov/webkit-user-agent.git',
    :tag => 'v' + s.version.to_s
  }

  s.preserve_paths = [
    "README.md"
  ]

  s.ios.deployment_target = "9.0"
  s.osx.deployment_target = '10.10'

  s.swift_version = "5.0"

  s.source_files  = "WebKitUserAgent/Sources/**/*"
end
