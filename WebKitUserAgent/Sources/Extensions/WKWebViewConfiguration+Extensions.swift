//
//  WebKit User-Agent
//
//  https://github.com/dmytriigolovanov/webkit-user-agent/blob/main/LICENSE
//

import Foundation
import WebKit

extension WKWebViewConfiguration {
    func setApplicationNameForUserAgent(
        _ applicationName: String,
        overrideDefault: Bool = false
    ) {
        var components: [String] = []

        if
            overrideDefault == false,
            let defaultApplicationName = self.applicationNameForUserAgent,
            defaultApplicationName.isEmpty == false
        {
            components.append(defaultApplicationName)
        }
        
        if applicationName.isEmpty == false {
            components.append(applicationName)
        }
        
        self.applicationNameForUserAgent = components.joined(separator: " ")
    }
}
