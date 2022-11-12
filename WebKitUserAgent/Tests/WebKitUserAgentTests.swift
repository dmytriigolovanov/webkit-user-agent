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
    let applicationName: String = "TEST/0.0.0"
    
    func testFromWebView() throws {
        let webView = WKWebView(frame: .zero)
        guard let userAgent = webView.userAgent else {
            return XCTFail("Nil User-Agent.")
        }
        XCTAssertFalse(userAgent.isEmpty, "User Agent is empty.")
    }
    
    func testDefault() throws {
        guard let userAgent = WKUserAgent.default else {
            return XCTFail("Nil User-Agent.")
        }
        XCTAssertFalse(userAgent.isEmpty, "User Agent is empty.")
    }
    
    func testWithApplicationName() throws {
        guard let userAgent = WKUserAgent.withApplicationName(applicationName) else {
            return XCTFail("Nil User-Agent.")
        }
        XCTAssertTrue(userAgent.contains(applicationName), "User Agent doesn't contains provided application name.")
        XCTAssertFalse(userAgent.isEmpty, "User Agent is empty.")
    }
    
    func testWithApplicationNameOverridingDefault() throws {
        guard
            let userAgent = WKUserAgent.withApplicationName(
                applicationName,
                overrideDefaultApplicationName: true)
        else {
            return XCTFail("Nil User-Agent.")
        }
        XCTAssertTrue(userAgent.contains(applicationName), "User Agent doesn't contains provided application name.")
        XCTAssertFalse(userAgent.isEmpty, "User Agent is empty.")
    }
    
    // MARK: <3.0.0 versions
    
    func testDeprecatedFromWebView() throws {
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
    
    func testDeprecatedDefault() throws {
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
    
    func testDeprecatedWithApplicationName() throws {
        let expectation = XCTestExpectation(description: "Fetch User Agent")
        
        WKUserAgent.fetch(
            withApplicationName: applicationName,
            rewriteDefaultApplicationName: true
        ) { result in
            switch result {
            case .success(let userAgent):
                XCTAssertFalse(userAgent.isEmpty, "User Agent is empty.")
                XCTAssertTrue(userAgent.contains(self.applicationName), "User Agent doesn't contains provided application name.")
            case .failure(let error):
                XCTFail("Error: \(error.localizedDescription)")
            }
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testDeprecatedWithApplicationNameOverridingDefault() throws {
        let expectation = XCTestExpectation(description: "Fetch User Agent")
        
        WKUserAgent.fetch(
            withApplicationName: applicationName,
            rewriteDefaultApplicationName: false
        ) { result in
            switch result {
            case .success(let userAgent):
                XCTAssertFalse(userAgent.isEmpty, "User Agent is empty.")
                XCTAssertTrue(userAgent.contains(self.applicationName), "User Agent doesn't contains provided application name.")
            case .failure(let error):
                XCTFail("Error: \(error.localizedDescription)")
            }
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10.0)
    }
}
