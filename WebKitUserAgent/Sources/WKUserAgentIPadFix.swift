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
//  WKUserAgentIPadFix.swift
//  Created by Dmytrii Golovanov on 18.02.2022.
//

import Foundation
import WebKit

final class WKUserAgentIPadFix: NSObject {
    
    static var isNeeded: Bool {
        #if os(iOS) || canImport(UIKit)
        if #available(iOS 13, *) {
            return UIKit.UIDevice.current.userInterfaceIdiom == .pad
        } else {
            return false
        }
        #else
        return false
        #endif
    }
    
    private let webView: WKWebView
    private let completion: (WKUserAgentIPadFix, Bool) -> Void
    private var isCompleted: Bool = false
    
    private var url: URL? {
        return URL(string: "https://github.com/dmytriigolovanov/webkit-user-agent")
    }
    
    // MARK: Init
    
    init(
        webView: WKWebView,
        completion: @escaping (WKUserAgentIPadFix, Bool) -> Void
    ) {
        self.webView = webView
        self.completion = completion
    }
    
    // MARK: Complete
    
    private func complete(_ result: Bool) {
        guard isCompleted == false else {
            return
        }
        isCompleted = true
        webView.navigationDelegate = nil
        completion(self, result)
    }
    
    // MARK: Resume
    
    func resume() {
        if webView.url != nil,
            webView.url?.absoluteString != "about:blank" {
            complete(true)
            return
        }
        guard let url = self.url else {
            complete(false)
            return
        }
        webView.navigationDelegate = self
        let request = URLRequest(
            url: url,
            cachePolicy: .reloadIgnoringCacheData)
        webView.load(request)
    }
}

// MARK: - WKNavigationDelegate

extension WKUserAgentIPadFix: WKNavigationDelegate {
    // MARK: Success
    
    func webView(
        _ webView: WKWebView,
        didCommit navigation: WKNavigation!
    ) {
        guard webView == self.webView else {
            return
        }
        complete(true)
    }
    
    func webView(
        _ webView: WKWebView,
        didFinish navigation: WKNavigation!
    ) {
        guard webView == self.webView else {
            return
        }
        complete(true)
    }
    
    // MARK: Failure
    
    func webView(
        _ webView: WKWebView,
        didFailProvisionalNavigation navigation: WKNavigation!,
        withError error: Error
    ) {
        guard webView == self.webView else {
            return
        }
        complete(false)
    }
    
    func webView(
        _ webView: WKWebView,
        didFail navigation: WKNavigation!,
        withError error: Error
    ) {
        guard webView == self.webView else {
            return
        }
        complete(false)
    }
}
