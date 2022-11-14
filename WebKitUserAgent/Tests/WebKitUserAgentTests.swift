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
        DispatchQueue.main.async {
            
        }
        let webView = WKWebView(frame: .zero)
        guard let userAgent = webView.userAgent else {
            return XCTFail("Nil User-Agent.")
        }
        XCTAssertFalse(userAgent.isEmpty, "User Agent is empty.")
    }
    
    func testDefault() throws {
        let expectation = XCTestExpectation(description: "Fetch User Agent")
        
        WKUserAgent.fetchDefault { userAgent in
            guard let userAgent = userAgent else {
                return XCTFail("Nil User-Agent.")
            }
            XCTAssertFalse(userAgent.isEmpty, "User Agent is empty.")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testWithApplicationName() throws {
        let expectation = XCTestExpectation(description: "Fetch User Agent")
        
        WKUserAgent.fetch(withApplicationName: applicationName) { userAgent in
            guard let userAgent = userAgent else {
                return XCTFail("Nil User-Agent.")
            }
            XCTAssertTrue(userAgent.contains(self.applicationName), "User Agent doesn't contains provided application name.")
            XCTAssertFalse(userAgent.isEmpty, "User Agent is empty.")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testWithApplicationNameOverridingDefault() throws {
        let expectation = XCTestExpectation(description: "Fetch User Agent")
        
        WKUserAgent.fetch(
            withApplicationName: applicationName,
            overrideDefaultApplicationName: true
        ) { userAgent in
            guard let userAgent = userAgent else {
                return XCTFail("Nil User-Agent.")
            }
            XCTAssertTrue(userAgent.contains(self.applicationName), "User Agent doesn't contains provided application name.")
            XCTAssertFalse(userAgent.isEmpty, "User Agent is empty.")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10.0)
    }
}
