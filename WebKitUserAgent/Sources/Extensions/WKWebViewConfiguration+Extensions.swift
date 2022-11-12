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
    var isJavaScriptEnabled: Bool {
        if #available(iOS 14.0, macOS 11.0, *) {
            return defaultWebpagePreferences.allowsContentJavaScript
        } else {
            return preferences.javaScriptEnabled
        }
    }
    
    convenience init(
        applicationName: String,
        rewriteDefaultApplicationName: Bool
    ) {
        self.init()
        var targetApplicationName: String = ""
        if rewriteDefaultApplicationName == false,
           let defaultApplicationName = self.applicationNameForUserAgent {
            targetApplicationName += defaultApplicationName
        }
        if targetApplicationName.isEmpty == false {
            targetApplicationName += " "
        }
        targetApplicationName += applicationName
        self.applicationNameForUserAgent = targetApplicationName
    }
}
}
