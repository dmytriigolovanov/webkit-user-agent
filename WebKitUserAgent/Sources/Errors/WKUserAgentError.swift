//
//  WKUserAgentError.swift
//  WebKitUserAgent
//
//  Created by Dmytrii Golovanov on 03.12.2021.
//  Copyright © 2022 Dmytrii Golovanov. All rights reserved.
//

import Foundation

public let WKUserAgenErrorDomain = "WKUserAgentError"

enum WKUserAgentError: Error {
    case javaScriptDisabled
    case javaScriptCompletedWithInvalidResult(Any?)
}

// MARK: - CustomNSError

extension WKUserAgentError: CustomNSError {
    static var errorDomain: String {
        return WKUserAgenErrorDomain
    }
    
    var errorCode: Int {
        switch self {
        case .javaScriptDisabled:
            return 0
        case .javaScriptCompletedWithInvalidResult:
            return 1
        }
    }
    
    var errorUserInfo: [String : Any] {
        var userInfo: [String: Any] = [:]
        
        switch self {
        case .javaScriptCompletedWithInvalidResult(let result):
            userInfo["result"] = result ?? "nil"
        default:
            break
        }
        
        return userInfo
    }
}


// MARK: - LocalizedError

extension WKUserAgentError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .javaScriptDisabled:
            return "Can't complete UserAgent getting, because JavaScript is disabled."
        case .javaScriptCompletedWithInvalidResult(let result):
            if let result = result {
                let type = type(of: result)
                return "Getting UserAgent completed with non-String (\(type)) result."
            } else {
                return "Getting UserAgent completed with nil result."
            }
        }
    }

    var failureReason: String? {
        switch self {
        case .javaScriptDisabled:
            return "JavaScript is disabled in WKWebView."
        case .javaScriptCompletedWithInvalidResult(let result):
            if let result = result {
                let type = type(of: result)
                return "Evaluating JavaScript in WKWebView completed with non-String (\(type)) result."
            } else {
                return "Evaluating JavaScript in WKWebView completed with nil result."
            }
        }
    }
}
