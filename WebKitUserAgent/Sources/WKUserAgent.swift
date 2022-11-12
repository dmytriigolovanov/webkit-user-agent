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
    
    private static var activeFetchers: Set<WKUserAgentFetcher> = []
    private static var isPadFixNeeded: Bool {
        return WKUserAgentIPadFix.isNeeded
    }
    private static var activeIPadFixes: Set<WKUserAgentIPadFix> = []
    
    // MARK: Active Fetching
    
    private static func addActiveFetcher(_ fetcher: WKUserAgentFetcher) {
        activeFetchers.insert(fetcher)
    }
    
    @discardableResult
    private static func removeActiveFetcher(_ fetcher: WKUserAgentFetcher) -> WKUserAgentFetcher? {
        return activeFetchers.remove(fetcher)
    }
    
    // MARK: iPad Fix
    
    @discardableResult
    private static func doIPadFix(
        webView: WKWebView,
        completion: @escaping (Bool) -> Void
    ) -> WKUserAgentIPadFix {
        let fix = WKUserAgentIPadFix(webView: webView) { completedFix, result in
            completion(result)
            self.activeIPadFixes.remove(completedFix)
        }
        self.activeIPadFixes.insert(fix)
        fix.resume()
        return fix
    }
    
    // MARK: Prepare WebView
    
    private static func prepareWebView(
        configuration: WKWebViewConfiguration = WKWebViewConfiguration(),
        completion: @escaping (WKWebView) -> Void
    ) {
        DispatchQueue.main.async {
            let webView = WKWebView(
                frame: .zero,
                configuration: configuration)
            
            // iPad fix
            if self.isPadFixNeeded {
                self.doIPadFix(webView: webView) { _ in
                    completion(webView)
                }
                return
            }
            
            completion(webView)
        }
    }
    
    private static func prepareWebView(
        applicationName: String,
        rewriteDefaultApplicationName: Bool = false,
        completion: @escaping (WKWebView) -> Void
    ) {
        let configuration = WKWebViewConfiguration(
            applicationName: applicationName,
            rewriteDefaultApplicationName: rewriteDefaultApplicationName)
        prepareWebView(
            configuration: configuration,
            completion: completion)
    }
    
    // MARK: Fetch
    
    /// Fetching `User Agent` through `WKWebView`.
    /// WebView must be stored not in temprorary variable.
    /// 
    /// iPad iOS 13+ fix: For correct result any `URL` should be loaded in WebView.
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
        prepareWebView { webView in
            self.fetch(
                fromWebView: webView,
                completion: completion)
        }
    }
    
    /// Fetching `User Agent` through default `WKWebView` with application name.
    /// Rewriting default `applicationName` value (default for `WKWebViewConfiguration`) ability provided.
    public static func fetch(
        withApplicationName applicationName: String,
        rewriteDefaultApplicationName: Bool = false,
        completion: @escaping (Result<String, Error>) -> Void
    ) {
        prepareWebView(
            applicationName: applicationName,
            rewriteDefaultApplicationName: rewriteDefaultApplicationName
        ) { webView in
            self.fetch(
                fromWebView: webView,
                completion: completion)
        }
    }
}
