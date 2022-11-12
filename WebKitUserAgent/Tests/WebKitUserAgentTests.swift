//
//  WebKitUserAgentTests.swift
//  WebKitUserAgent
//
//  Created by Dmytrii Golovanov on 03.12.2021.
//  Copyright © 2022 Dmytrii Golovanov. All rights reserved.
//

import XCTest
import WebKit
@testable import WebKitUserAgent

final class Tests: XCTestCase {
    
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
