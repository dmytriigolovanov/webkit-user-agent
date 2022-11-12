//
//  WKUserAgentJavaScriptDisabledError.swift
//  WebKitUserAgent
//
//  Created by Dmytrii Golovanov on 12.11.2022.
//  Copyright © 2022 Dmytrii Golovanov. All rights reserved.
//

import Foundation

public struct WKUserAgentJavaScriptDisabledError: WKUserAgentError {
    public var errorCode: Int {
        WKUserAgentErrorCodes.javaScriptDisabled.rawValue
    }
    
    public var errorDescription: String? {
        "JavaScript is disabled in webView. User-Agent fetch is unavailable."
    }
    
    public var failureReason: String? {
        "JavaScript is disabled in webView, which is provided for User-Agent fetch."
    }
    
    public var recoverySuggestion: String? {
        "Enable (allow) JavaScript usage in WKWebView, which is provided for User-Agent fetch."
    }
}
