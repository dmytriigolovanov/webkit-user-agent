//
//  WebKit User-Agent
//
//  https://github.com/dmytriigolovanov/webkit-user-agent/blob/main/LICENSE
//

import Foundation
import WebKit
#if canImport(WebKitSafeKVC)
import WebKitSafeKVC
#endif

extension WKWebView {
    @MainActor
    public var userAgent: String? {
        get async {
            if let userAgent = keyValueUserAgent {
                return userAgent
            }
            if let userAgent = await fetchUserAgentViaJavaScript(timeout: 2) {
                return userAgent
            }
            await loadBlankPageIfNeeded(timeout: 3)
            return await fetchUserAgentViaJavaScript(timeout: 5)
        }
    }

    private var keyValueUserAgent: String? {
        #if canImport(WebKitSafeKVC)
        return WKWebViewSafeValueForKey(self, "userAgent") as? String
        #else
        return nil
        #endif
    }

    @MainActor
    func fetchUserAgentViaJavaScript(timeout: TimeInterval) async -> String? {
        await withTaskGroup(of: String?.self) { group in
            group.addTask { @MainActor in
                try? await self.evaluateJavaScript("navigator.userAgent") as? String
            }
            group.addTask {
                try? await Task.sleep(nanoseconds: UInt64(timeout * 1_000_000_000))
                return nil
            }
            let result = await group.next() ?? nil
            group.cancelAll()
            return result
        }
    }

    @MainActor
    func loadBlankPageIfNeeded(timeout: TimeInterval) async {
        guard isLoading == false, url == nil else {
            return
        }

        loadHTMLString("<html></html>", baseURL: nil)

        let deadline = Date().addingTimeInterval(timeout)
        while isLoading, Date() < deadline {
            try? await Task.sleep(nanoseconds: 50_000_000)
        }
    }
}
