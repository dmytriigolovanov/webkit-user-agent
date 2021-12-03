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
//  WKUserAgentError.swift
//  Created by Dmytrii Golovanov on 03.12.2021.
//

import Foundation

public let WKUserAgenErrorDomain = "WKUserAgentError"

enum WKUserAgentError: Error {
    case javaScriptDisabled
    case javaScriptCompletedWithNil
    case javaScriptCompletedWithNonString(result: Any)
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
        case .javaScriptCompletedWithNil:
            return 1
        case .javaScriptCompletedWithNonString:
            return 2
        }
    }
    
    var errorUserInfo: [String : Any] {
        var userInfo: [String: Any] = [:]
        
        switch self {
        case .javaScriptCompletedWithNonString(let result):
            userInfo["result"] = result
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
        case .javaScriptCompletedWithNil:
            return "Getting UserAgent completed with nil result."
        case .javaScriptCompletedWithNonString(let result):
            let type = type(of: result)
            return "Getting UserAgent completed with non-String (\(type)) result."
        }
    }

    var failureReason: String? {
        switch self {
        case .javaScriptDisabled:
            return "JavaScript is disabled in WKWebView."
        case .javaScriptCompletedWithNil:
            return "Evaluating JavaScript in WKWebView completed with nil result."
        case .javaScriptCompletedWithNonString(let result):
            let type = type(of: result)
            return "Evaluating JavaScript in WKWebView completed with non-String (\(type)) result."
        }
    }
}
