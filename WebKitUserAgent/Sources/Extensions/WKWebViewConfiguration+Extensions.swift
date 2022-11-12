//
//  WKWebViewConfiguration+Extensions.swift
//  WebKitUserAgent
//
//  Created by Dmytrii Golovanov on 03.12.2021.
//  Copyright © 2022 Dmytrii Golovanov. All rights reserved.
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
