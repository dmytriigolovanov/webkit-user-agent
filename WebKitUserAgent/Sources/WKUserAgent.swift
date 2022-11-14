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
    public static func fetchDefault(completionHandler: @escaping (String?) -> Void) {
        DispatchQueue.main.async {
            let userAgent = WKWebView().userAgent
            completionHandler(userAgent)
        }
    }
    
    /// Fetching `User Agent` through default `WKWebView` with application name.
    /// Overriding default `applicationName` value (default for `WKWebViewConfiguration`) ability provided.
    public static func fetch(
        withApplicationName applicationName: String,
        overrideDefaultApplicationName: Bool = false,
        completionHandler: @escaping (String?) -> Void
    ) {
        DispatchQueue.main.async {
            let configuration = WKWebViewConfiguration()
            configuration.setApplicationNameForUserAgent(
                applicationName,
                overrideDefault: overrideDefaultApplicationName)
            
            let webView = WKWebView(
                frame: .zero,
                configuration: configuration)
            let userAgent = webView.userAgent
            completionHandler(userAgent)
        }
    }
}
