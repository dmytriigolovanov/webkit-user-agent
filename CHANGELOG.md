# v5.0.0

- [changed] Bumped minimum platforms to iOS 15.0+ and macOS 12.0+
- [added] Added visionOS 1.0+ support
- [added] Added async/await API (`WKUserAgent.default`, `WKUserAgent.withApplicationName(_:appendingToDefault:)`)
- [added] Added Objective-C support (`WKUserAgent.fetchDefault(completionHandler:)`, `WKUserAgent.withApplicationName(_:appendingToDefault:completionHandler:)`, `WKWebView.fetchUserAgent(completionHandler:)`)
- [deprecated] Deprecated `WKUserAgent.fetch(withApplicationName:overrideDefaultApplicationName:completionHandler:)`
- [changed] Changed `WKWebView.userAgent` to an async property returning `String?`
- [fixed] Fixed potential crash in User-Agent lookup
- [added] Added JavaScript fallback with bounded timeouts for User-Agent lookup
- [changed] Bumped Swift version to 5.9

# v4.0.0

- [changed] Reogranized fetching logic & interface

# v3.0.0

- [changed] Updated fetching logic
- [changed] Updated fetching interface

# v2.0.2

- [fixed] Fixed podspec swift version
- [fixed] Fixed Swift Package swift version

# v2.0.1

- [fixed] Fixed WKUserAgentIPadFix weak link

# v2.0.0

- [changed] Reorganised WKUserAgent
- [changed] Reorganised WKUserAgentFetcher (WKUserAgentWorker)
- [changed] Reorganised WKUserAgentError
- [changed] Reorganised WKWebView prepare logic
- [added] Added iPad iOS 13+ issue fix
- [added] Added WKWebView public extension func

# v1.1.0

- [added] Added default WebView logic

# v1.0.1

- [changed] Changed LICENSE
- [changed] Changed .podspec

# v1.0.0

Initial release.
