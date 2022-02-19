//
//  Copyright (c) 2022 Dmytrii Golovanov
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//
//  WKUserAgent.swift
//  Created by Dmytrii Golovanov on 03.12.2021.
//

import Foundation
import WebKit

public final class WKUserAgent {
    
    private static var activeFetchers: Set<WKUserAgentFetcher> = []
    
    // MARK: - Prepare WebView
    
    private static func prepareWebView() -> WKWebView {
        return WKWebView(frame: .zero)
    }
    
    private static func prepareWebView(
        applicationName: String,
        rewriteDefaultApplicationName: Bool = false
    ) -> WKWebView {
        let webConfiguration = WKWebViewConfiguration()
        webConfiguration.applicationNameForUserAgent = applicationName
        return WKWebView(
            frame: .zero,
            configuration: webConfiguration)
    }
    
    // MARK: Active Fetching
    
    private static func addActiveFetcher(_ fetcher: WKUserAgentFetcher) {
        activeFetchers.insert(fetcher)
    }
    
    @discardableResult
    private static func removeActiveFetcher(_ fetcher: WKUserAgentFetcher) -> WKUserAgentFetcher? {
        return activeFetchers.remove(fetcher)
    }
    
    // MARK: Fetch
    
    /// Fetching `User Agent` through `WKWebView`.
    public static func fetch(
        fromWebView webView: WKWebView,
        completion: @escaping (Result<String, Error>) -> Void
    ) {
        let fetcher = WKUserAgentFetcher(webView: webView)
        addActiveFetcher(fetcher)
        fetcher.fetch { result in
            completion(result)
            self.removeActiveFetcher(fetcher)
        }
    }
    
    /// Fetching `User Agent` through default `WKWebView`.
    public static func fetch(
        completion: @escaping (Result<String, Error>) -> Void
    ) {
        let webView = prepareWebView()
        self.fetch(
            fromWebView: webView,
            completion: completion)
    }
    
    /// Fetching `User Agent` through default `WKWebView` with application name.
    /// Rewriting default `applicationName` value (default for `WKWebViewConfiguration`) ability provided.
    public static func fetch(
        withApplicationName applicationName: String,
        rewriteDefaultApplicationName: Bool = false,
        completion: @escaping (Result<String, Error>) -> Void
    ) {
        let webView = prepareWebView(
            applicationName: applicationName,
            rewriteDefaultApplicationName: rewriteDefaultApplicationName)
        fetch(
            fromWebView: webView,
            completion: completion)
    }
}
