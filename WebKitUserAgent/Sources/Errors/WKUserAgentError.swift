//
//  WKUserAgentError.swift
//  WebKitUserAgent
//
//  Created by Dmytrii Golovanov on 03.12.2021.
//  Copyright © 2022 Dmytrii Golovanov. All rights reserved.
//

import Foundation

public let kWKUserAgenErrorDomain = "WKUserAgentError"

public protocol WKUserAgentError: Error, LocalizedError, CustomNSError {}

extension WKUserAgent {
    public static var errorDomain: String {
        kWKUserAgenErrorDomain
    }
}
