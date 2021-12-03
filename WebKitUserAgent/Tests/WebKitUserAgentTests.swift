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
//  WebKitUserAgentTests.swift
//  Created by Dmytrii Golovanov on 03.12.2021.
//

import XCTest
import WebKit
@testable import WebKitUserAgent

final class WebKitUserAgentTests: XCTestCase {
    
    func testGetUserAgentWithWebView() throws {
        DispatchQueue.main.async {
            let webView = WKWebView(frame: .zero)
            WKUserAgent.getUserAgent(webView: webView) { result in
                if case .failure(let error) = result {
                    XCTFail("Error: \(error.localizedDescription)")
                }
            }
        }
    }
    
    func testGetUserAgentWithApplicationName() throws {
        let applicationName = "get_user_agent_with_application_name_test"
        WKUserAgent.getUserAgent(applicationName: applicationName) { result in
            switch result {
            case .success(let userAgent):
                XCTAssertTrue(userAgent.contains(applicationName), "User Agent doesn't contains provided application name.")
            case .failure(let error):
                XCTFail("Error: \(error.localizedDescription)")
            }
        }
    }
}
