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
    
    func testGetUserAgentWithWebViewConfiguration() throws {
        DispatchQueue.main.async {
            let webViewConfiguration = WKWebViewConfiguration()
            WKUserAgent.getUserAgent(webViewConfiguration: webViewConfiguration) { result in
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
