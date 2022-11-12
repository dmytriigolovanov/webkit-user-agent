//
//  WKUserAgentInvalidFetchResultError.swift
//  WebKitUserAgent
//
//  Created by Dmytrii Golovanov on 12.11.2022.
//  Copyright © 2022 Dmytrii Golovanov. All rights reserved.
//

import Foundation

public struct WKUserAgentInvalidFetchResultError: WKUserAgentError {
    let result: Any?
    
    // MARK: Init
    
    init(_ result: Any?) {
        self.result = result
    }
    
    // MARK: Error
    
    public var errorCode: Int {
        WKUserAgentErrorCodes.invalidFetchResult.rawValue
    }
    
    public var errorDescription: String? {
        if let result = result {
            let type = type(of: result)
            return "User-Agent fetch completed with non-String (\(type)) result."
        } else {
            return "User-Agent fetch completed with nil result."
        }
    }
    
    public var failureReason: String? {
        if let result = result {
            let type = type(of: result)
            return "Evaluating JavaScript in WKWebView completed with non-String (\(type)) result."
        } else {
            return "Evaluating JavaScript in WKWebView completed with nil result."
        }
    }
}
