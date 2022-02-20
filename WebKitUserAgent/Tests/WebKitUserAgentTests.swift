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
//  WebKitUserAgentTests.swift
//  Created by Dmytrii Golovanov on 03.12.2021.
//

import XCTest
import WebKit
@testable import WebKitUserAgent

final class WebKitUserAgentTests: XCTestCase {
    
    func testFetchUserAgentWithWebView() throws {
        let expectation = XCTestExpectation(description: "Fetch User Agent")
        
        DispatchQueue.main.async {
            let webView = WKWebView(frame: .zero)
            WKUserAgent.fetch(fromWebView: webView) { result in
                switch result {
                case .success(let userAgent):
                    XCTAssertFalse(userAgent.isEmpty, "User Agent is empty.")
                case .failure(let error):
                    XCTFail("Error: \(error.localizedDescription)")
                }
                
                expectation.fulfill()
            }
        }
        
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testFetchUserAgentWithWebViewPublicExtension() throws {
        let expectation = XCTestExpectation(description: "Fetch User Agent")
        
        DispatchQueue.main.async {
            let webView = WKWebView(frame: .zero)
            webView.fetchUserAgent { result in
                switch result {
                case .success(let userAgent):
                    XCTAssertFalse(userAgent.isEmpty, "User Agent is empty.")
                case .failure(let error):
                    XCTFail("Error: \(error.localizedDescription)")
                }
                
                expectation.fulfill()
            }
        }
        
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testFetchUserAgentWithDefaultWebView() throws {
        let expectation = XCTestExpectation(description: "Fetch User Agent")
        
        WKUserAgent.fetch { result in
            switch result {
            case .success(let userAgent):
                XCTAssertFalse(userAgent.isEmpty, "User Agent is empty.")
            case .failure(let error):
                XCTFail("Error: \(error.localizedDescription)")
            }
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testFetchUserAgentWithApplicationName() throws {
        let expectation = XCTestExpectation(description: "Fetch User Agent")
        
        let applicationName = "test_fetch_user_agent_with_application_name"
        WKUserAgent.fetch(
            withApplicationName: applicationName,
            rewriteDefaultApplicationName: true
        ) { result in
            switch result {
            case .success(let userAgent):
                XCTAssertFalse(userAgent.isEmpty, "User Agent is empty.")
                XCTAssertTrue(userAgent.contains(applicationName), "User Agent doesn't contains provided application name.")
            case .failure(let error):
                XCTFail("Error: \(error.localizedDescription)")
            }
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testFetchUserAgentWithAdditionalApplicationName() throws {
        let expectation = XCTestExpectation(description: "Fetch User Agent")
        
        let applicationName = "test_fetch_user_agent_with_additional_application_name"
        WKUserAgent.fetch(
            withApplicationName: applicationName,
            rewriteDefaultApplicationName: false
        ) { result in
            switch result {
            case .success(let userAgent):
                XCTAssertFalse(userAgent.isEmpty, "User Agent is empty.")
                XCTAssertTrue(userAgent.contains(applicationName), "User Agent doesn't contains provided application name.")
            case .failure(let error):
                XCTFail("Error: \(error.localizedDescription)")
            }
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10.0)
    }
}
