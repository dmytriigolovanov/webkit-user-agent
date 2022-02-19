//
//  File.swift
//  
//
//  Created by Dmytrii Golovanov on 19.02.2022.
//

import Foundation
import WebKit

extension WKWebViewConfiguration {
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
