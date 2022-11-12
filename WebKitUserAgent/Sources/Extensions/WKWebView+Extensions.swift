//
//  WKWebView+Extensions.swift
//  WebKitUserAgent
//
//  Created by Dmytrii Golovanov on 03.12.2021.
//  Copyright © 2022 Dmytrii Golovanov. All rights reserved.
//

import Foundation
import WebKit

extension WKWebView {
    func fetchUserAgentThroughJavaScript(completion: @escaping (Result<Any?, Error>) -> Void) {
        evaluateJavaScript("navigator.userAgent") { (result, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            completion(.success(result))
        }
    }
}

public extension WKWebView {
    /// Fetching `User Agent` through `WKWebView`.
    func fetchUserAgent(completion: @escaping (Result<String, Error>) -> Void) {
        WKUserAgent.fetch(fromWebView: self, completion: completion)
    }
}
