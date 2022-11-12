//
//  WKUserAgent.swift
//  WebKitUserAgent
//
//  Created by Dmytrii Golovanov on 03.12.2021.
//  Copyright © 2022 Dmytrii Golovanov. All rights reserved.
//

import Foundation
import WebKit

public final class WKUserAgent {
    /// Fetching `User Agent` through default `WKWebView`.
    public static var `default`: String! {
        WKWebView().userAgent
    }
    
    /// Fetching `User Agent` through default `WKWebView` with application name.
    /// Overriding default `applicationName` value (default for `WKWebViewConfiguration`) ability provided.
    public static func withApplicationName(
        _ applicationName: String,
        overrideDefaultApplicationName: Bool = false
    ) -> String! {
        let configuration = WKWebViewConfiguration()
        configuration.setApplicationNameForUserAgent(
            applicationName,
            overrideDefault: overrideDefaultApplicationName)
        
        let webView = WKWebView(
            frame: .zero,
            configuration: configuration)
        return webView.userAgent
    }
    
    // MARK: <3.0.0 versions support
    
    /// Fetching `User Agent` through `WKWebView`.
    @available(*, deprecated, message: "Use WKWebView's userAgent property instead.")
    public static func fetch(
        fromWebView webView: WKWebView,
        completion: @escaping (Result<String, Error>) -> Void
    ) {
        let userAgent = webView.userAgent
        completion(.success(userAgent ?? ""))
    }
    
    /// Fetching `User Agent` through default `WKWebView`.
    @available(*, deprecated, renamed: "default")
    public static func fetch(completion: @escaping (Result<String, Error>) -> Void) {
        let userAgent = self.default
        completion(.success(userAgent ?? ""))
    }
    
    /// Fetching `User Agent` through default `WKWebView` with application name.
    /// Rewriting default `applicationName` value (default for `WKWebViewConfiguration`) ability provided.
    @available(*, deprecated, renamed: "withApplicationName")
    public static func fetch(
        withApplicationName applicationName: String,
        rewriteDefaultApplicationName: Bool = false,
        completion: @escaping (Result<String, Error>) -> Void
    ) {
        let userAgent = self.withApplicationName(
            applicationName,
            overrideDefaultApplicationName: rewriteDefaultApplicationName)
        completion(.success(userAgent ?? ""))
    }
}
