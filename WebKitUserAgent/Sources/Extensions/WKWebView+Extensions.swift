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
    /// Fetching `User Agent` through `WKWebView`.
    public var userAgent: String! {
        self.value(forKey: "userAgent") as? String
    }
    
    // MARK: <3.0.0 versions support
    
    /// Fetching `User Agent` through `WKWebView`.
    @available(*, deprecated, renamed: "userAgent")
    public func fetchUserAgent(completion: @escaping (Result<String, Error>) -> Void) {
        WKUserAgent.fetch(fromWebView: self, completion: completion)
    }
}
