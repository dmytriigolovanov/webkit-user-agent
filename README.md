# WebKit User Agent

## Requirements

* **Swift 5.9**
* **iOS 15.0+**
* **macOS 12.0+**
* **visionOS 1.0+**

## Installation

See the subsections below for details about the different installation methods.
1. [CocoaPods](#cocoapods)
2. [Swift Package Manager](#swift-package-manager)

### CocoaPods

1. Prepare project for CocoaPods usage by [CocoaPods - Install / Get Started](https://cocoapods.org)
2. Add pod to project's profile
```ruby
    pod 'WebKitUserAgent'
```
3. Install pod
```console
    cd {PATH_TO_PROJECT}
    pod install
```


### Swift Package Manager

1. Go to project
2. `File` → `Add Packages...`
3. Search for library, using URL: 
```
    https://github.com/dmytriigolovanov/webkit-user-agent
```
4. Set the `Dependency Rule` to `Up to Next Major Version`
5. `Add Package`

## Using

```swift
import WebKitUserAgent
```

From an existing `WKWebView`:

```swift
let userAgent = await webView.userAgent
```

From a default `WKWebView`:

```swift
let userAgent = await WKUserAgent.default
```

With an application name, appended to (or replacing) the default:

```swift
let userAgent = await WKUserAgent.withApplicationName("EXAMPLE/1.0.0", appendingToDefault: true)
```

Completion-handler equivalents are available for Objective-C or non-async callers:

```swift
webView.fetchUserAgent { userAgent in }
WKUserAgent.fetchDefault { userAgent in }
WKUserAgent.withApplicationName("EXAMPLE/1.0.0", appendingToDefault: true) { userAgent in }
```


## License

The contents of this repository are licensed under the
[MIT License](https://github.com/dmytriigolovanov/webkit-user-agent/blob/main/LICENSE).
