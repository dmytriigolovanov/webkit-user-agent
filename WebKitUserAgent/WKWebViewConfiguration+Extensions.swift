//
//  WebKit User-Agent
//
//  https://github.com/dmytriigolovanov/webkit-user-agent/blob/main/LICENSE
//

import Foundation
import WebKit

extension WKWebViewConfiguration {
    func appendApplicationNameForUserAgent(_ newApplicationName: String) {
        if let existingApplicationName = applicationNameForUserAgent,
            !existingApplicationName.isEmpty {
            applicationNameForUserAgent  = (existingApplicationName + " " + newApplicationName)
        }
        else {
            applicationNameForUserAgent = newApplicationName
        }
    }
}
