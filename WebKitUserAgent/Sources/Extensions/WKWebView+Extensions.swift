//
//  WebKit User-Agent
//
//  https://github.com/dmytriigolovanov/webkit-user-agent/blob/main/LICENSE
//

import Foundation
import WebKit

extension WKWebView {
    /// Fetching `User Agent` through `WKWebView`.
    public var userAgent: String! {
        self.value(forKey: "userAgent") as? String
    }
}
