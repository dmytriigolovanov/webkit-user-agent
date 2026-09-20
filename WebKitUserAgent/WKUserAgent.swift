//
//  WebKit User-Agent
//
//  https://github.com/dmytriigolovanov/webkit-user-agent/blob/main/LICENSE
//

import Foundation
import WebKit

/// Fetching the `User Agent` reported by `WKWebView`.
public final class WKUserAgent: NSObject {
    /// Fetching `User Agent` through default `WKWebView`.
    @MainActor
    public static var `default`: String? {
        get async {
            await WKWebView().userAgent
        }
    }
    
    /// Fetching `User Agent` through default `WKWebView` with application name.
    /// `appendingToDefault` controls whether `applicationName` is appended to (`true`) or
    /// replaces (`false`) the `WKWebViewConfiguration`'s existing `applicationNameForUserAgent`.
    @MainActor
    public static func withApplicationName(_ applicationName: String, appendingToDefault: Bool) async -> String? {
        let configuration = WKWebViewConfiguration()
        
        if appendingToDefault {
            configuration.appendApplicationNameForUserAgent(applicationName)
        }
        else {
            configuration.applicationNameForUserAgent = applicationName
        }
        
        let webView = WKWebView(frame: .zero, configuration: configuration)
        return await webView.userAgent
    }
    
    // MARK: Objective-C

    @objc
    public static func fetchDefault(completionHandler: @escaping (String?) -> Void) {
        Task { @MainActor in
            let userAgent = await `default`
            completionHandler(userAgent)
        }
    }

    @objc
    public static func withApplicationName(
        _ applicationName: String,
        appendingToDefault: Bool,
        completionHandler: @escaping (String?) -> Void
    ) {
        Task { @MainActor in
            let userAgent = await withApplicationName(applicationName, appendingToDefault: appendingToDefault)
            completionHandler(userAgent)
        }
    }

    // MARK: Deprecated

    @available(*, deprecated, message: "Use the async `withApplicationName(_:appendingToDefault:)` function instead.")
    @objc
    public static func fetch(withApplicationName applicationName: String,
                             overrideDefaultApplicationName: Bool = false,
                             completionHandler: @escaping (String?) -> Void) {
        Task { @MainActor in
            let userAgent = await withApplicationName(
                applicationName,
                appendingToDefault: !overrideDefaultApplicationName
            )
            completionHandler(userAgent)
        }
    }
}
