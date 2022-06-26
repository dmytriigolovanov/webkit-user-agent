# WebKit User Agent

## Requirements

* **Swift 5.3**
* **iOS 9.0+**
* **macOS 10.11+**

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

Import library to needed swift file.

```swift
    import WebKitUserAgent
```

Library provides 3 variants of usage.
1. With prepared `WKWebView`.

**example:**

```swift
    var webView: WKWebView
    
    ... 
    
    WKUserAgent.fetch(fromWebView: webView) { result in 
        switch result {
        case .success(let userAgent):
            // Get the User Agent
        case .failure(let error):
            // Handle error
        }
    }
    
    // or
    
    webView.fetchUserAgent { result in
        switch result {
        case .success(let userAgent):
            // Get the User Agent
        case .failure(let error):
            // Handle error
        }
    }
```

2. With default `WKWebView`.

**example:**

```swift
    WKUserAgent.fetch { result in 
        switch result {
        case .success(let userAgent):
            // Get the User Agent
        case .failure(let error):
            // Handle error
        }
    }
```

3. With `applicationName`.
Application name is additional part for User Agent, which will be added at the end of original WebView's User Agent.
Provided `rewriteDefaultApplicationName` parameter for using/rewriting default `applicationName` from `WKWebViewConfiguration`.

**example:**
```swift
    let applicationName = "EXAMPLE/1.0.0"
    
    WKUserAgent.fetch(
        withApplicationName: applicationName, 
        rewriteDefaultApplicationName: true
    ) { result in 
        switch result {
        case .success(let userAgent):
            // Get the User Agent
        case .failure(let error):
            // Handle error
        }
    }
```


## License

The contents of this repository are licensed under the
[MIT License](https://github.com/dmytriigolovanov/webkit-user-agent/blob/main/LICENSE).
