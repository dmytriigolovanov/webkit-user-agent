//
//  Copyright (c) 2021 Dmytrii Golovanov
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
    private static var defaultWebView: WKWebView = {
        let webConfiguration = WKWebViewConfiguration()
        webConfiguration.applicationNameForUserAgent = ""
        return WKWebView(
            frame: .zero,
            configuration: webConfiguration)
    }()
    
    /// Getting User Agent through WKWebView.
    public static func getUserAgent(
        webView: WKWebView,
        completion: @escaping (Result<String, Error>) -> Void
    ) {
        let worker = WKUserAgentWorker(webView: webView)
        worker.getUserAgent(completion: completion)
    }
    
    /// Getting User Agent through default WKWebView.
    public static func getUserAgent(completion: @escaping (Result<String, Error>) -> Void) {
        let webView = self.defaultWebView
        self.getUserAgent(webView: webView, completion: completion)
    }
    
    /// Getting User Agent through default WKWebView with application name for user agent.
    public static func getUserAgent(applicationName: String,
                                    completion: @escaping (Result<String, Error>) -> Void) {
        getUserAgent { result in
            switch result {
            case .success(var userAgent):
                userAgent += " " + applicationName
                completion(.success(userAgent))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
