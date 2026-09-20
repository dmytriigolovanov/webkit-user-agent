//
//  WebKit User-Agent
//
//  https://github.com/dmytriigolovanov/webkit-user-agent/blob/main/LICENSE
//

import XCTest
import WebKit
@testable import WebKitUserAgent
import WebKitSafeKVC
#if os(iOS)
import UIKit
#endif

final class Tests: XCTestCase {
    let applicationName: String = "TEST/0.0.0"

    @MainActor
    func testFromWebView() async throws {
        let webView = WKWebView(frame: .zero)
        guard let userAgent = await webView.userAgent else {
            return XCTFail("Nil User-Agent.")
        }
        XCTAssertFalse(userAgent.isEmpty, "User Agent is empty.")
    }

    func testDefault() async throws {
        guard let userAgent = await WKUserAgent.default else {
            return XCTFail("Nil User-Agent.")
        }
        XCTAssertFalse(userAgent.isEmpty, "User Agent is empty.")
    }

    func testWithApplicationName() async throws {
        guard let userAgent = await WKUserAgent.withApplicationName(applicationName, appendingToDefault: true) else {
            return XCTFail("Nil User-Agent.")
        }
        XCTAssertTrue(userAgent.contains(applicationName), "User Agent doesn't contains provided application name.")
        XCTAssertFalse(userAgent.isEmpty, "User Agent is empty.")
    }

    func testWithApplicationNameOverridingDefault() async throws {
        guard let userAgent = await WKUserAgent.withApplicationName(applicationName, appendingToDefault: false) else {
            return XCTFail("Nil User-Agent.")
        }
        XCTAssertTrue(userAgent.contains(applicationName), "User Agent doesn't contains provided application name.")
        XCTAssertFalse(userAgent.isEmpty, "User Agent is empty.")
    }

    // MARK: Objective-C bridges

    func testFetchDefaultCompletionHandler() throws {
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

    func testWithApplicationNameCompletionHandler() throws {
        let expectation = XCTestExpectation(description: "Fetch User Agent")

        WKUserAgent.withApplicationName(applicationName, appendingToDefault: true) { userAgent in
            guard let userAgent = userAgent else {
                return XCTFail("Nil User-Agent.")
            }
            XCTAssertTrue(userAgent.contains(self.applicationName), "User Agent doesn't contains provided application name.")
            XCTAssertFalse(userAgent.isEmpty, "User Agent is empty.")
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 10.0)
    }

    @MainActor
    func testWebViewFetchUserAgentCompletionHandler() throws {
        let expectation = XCTestExpectation(description: "Fetch User Agent")
        let webView = WKWebView(frame: .zero)

        webView.fetchUserAgent { userAgent in
            guard let userAgent = userAgent else {
                return XCTFail("Nil User-Agent.")
            }
            XCTAssertFalse(userAgent.isEmpty, "User Agent is empty.")
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 10.0)
    }

    // MARK: Deprecated completion handler bridges

    func testDeprecatedFetchWithApplicationName() throws {
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

    // MARK: JavaScript fallback

    @MainActor
    func testJavaScriptEvaluationMatchesKVC() async throws {
        let webView = WKWebView(frame: .zero)
        guard let kvcUserAgent = WKWebViewSafeValueForKey(webView, "userAgent") as? String else {
            return XCTFail("Nil User-Agent from KVC.")
        }
        guard let jsUserAgent = await webView.fetchUserAgentViaJavaScript(timeout: 5) else {
            return XCTFail("Nil User-Agent from JavaScript.")
        }
        XCTAssertEqual(kvcUserAgent, jsUserAgent, "KVC and JavaScript should report the same default User-Agent.")
    }

    @MainActor
    func testJavaScriptEvaluationAfterLoadingBlankPage() async throws {
        let webView = WKWebView(frame: .zero)
        await webView.loadBlankPageIfNeeded(timeout: 5)
        guard let userAgent = await webView.fetchUserAgentViaJavaScript(timeout: 5) else {
            return XCTFail("Nil User-Agent after loading a blank page.")
        }
        XCTAssertFalse(userAgent.isEmpty, "User Agent is empty.")

        // Already-loaded view: should be a no-op (guard branch).
        await webView.loadBlankPageIfNeeded(timeout: 5)
    }

    @MainActor
    func testLoadBlankPageDoesNotTouchNavigationDelegate() async throws {
        let webView = WKWebView(frame: .zero)
        let originalDelegate = RecordingNavigationDelegate()
        webView.navigationDelegate = originalDelegate

        await webView.loadBlankPageIfNeeded(timeout: 5)

        XCTAssertTrue(webView.navigationDelegate === originalDelegate, "navigationDelegate should be left untouched.")
    }

    @MainActor
    func testFetchUserAgentFullPipeline() async throws {
        let webView = WKWebView(frame: .zero)
        guard let userAgent = await webView.userAgent else {
            return XCTFail("Nil User-Agent.")
        }
        XCTAssertFalse(userAgent.isEmpty, "User Agent is empty.")
    }

    @MainActor
    func testUserAgentAfterLoadingRealPage() async throws {
        let webView = WKWebView(frame: .zero)
        webView.load(URLRequest(url: URL(string: "https://github.com")!))

        let deadline = Date().addingTimeInterval(15)
        while webView.isLoading, Date() < deadline {
            try? await Task.sleep(nanoseconds: 100_000_000)
        }

        guard let userAgent = await webView.userAgent else {
            return XCTFail("Nil User-Agent after loading a real page.")
        }
        XCTAssertFalse(userAgent.isEmpty, "User Agent is empty.")
    }

    // MARK: WKWebViewConfiguration

    func testAppendApplicationNameForUserAgentAppendsToExistingDefault() throws {
        let configuration = WKWebViewConfiguration()
        configuration.applicationNameForUserAgent = "Existing/1.0.0"

        configuration.appendApplicationNameForUserAgent(applicationName)

        XCTAssertEqual(configuration.applicationNameForUserAgent, "Existing/1.0.0 \(applicationName)")
    }

    // MARK: KVC safety

    func testSafeValueForKeyReturnsRealValue() throws {
        let webView = WKWebView(frame: .zero)
        let userAgent = WKWebViewSafeValueForKey(webView, "userAgent") as? String
        XCTAssertNotNil(userAgent, "Expected a real User-Agent value for a recognized KVC key.")
    }

    func testSafeValueForKeyCatchesUnrecognizedKey() throws {
        let webView = WKWebView(frame: .zero)
        let result = WKWebViewSafeValueForKey(webView, "thisKeyDefinitelyDoesNotExist12345")
        XCTAssertNil(result, "Expected nil for an unrecognized KVC key instead of a crash.")
    }

    // MARK: iPad Desktop-class Browsing

    #if os(iOS) && !targetEnvironment(macCatalyst)
    @MainActor
    func testDesktopClassBrowsingOnIPad() async throws {
        try XCTSkipUnless(
            UIDevice.current.userInterfaceIdiom == .pad,
            "Desktop-class Browsing only applies on iPad.")

        let window = UIWindow(frame: CGRect(x: 0, y: 0, width: 800, height: 600))
        let webView = WKWebView(frame: window.bounds)
        window.addSubview(webView)
        window.makeKeyAndVisible()

        await webView.loadBlankPageIfNeeded(timeout: 5)
        guard let userAgent = await webView.fetchUserAgentViaJavaScript(timeout: 5) else {
            return XCTFail("Nil User-Agent.")
        }

        XCTAssertTrue(
            userAgent.contains("Macintosh"),
            "Expected a desktop-class User-Agent for a wide, laid-out iPad WKWebView, got: \(userAgent)")
    }
    #endif
}

private final class RecordingNavigationDelegate: NSObject, WKNavigationDelegate {}
