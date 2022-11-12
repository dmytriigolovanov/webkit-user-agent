//
//  WKUserAgentFetcher.swift
//  WebKitUserAgent
//
//  Created by Dmytrii Golovanov on 03.12.2021.
//  Copyright © 2022 Dmytrii Golovanov. All rights reserved.
//

import Foundation
import WebKit

final class WKUserAgentFetcher: NSObject {
    private let webView: WKWebView
    
    // MARK: Init
    
    init(webView: WKWebView) {
        self.webView = webView
    }
    
    // MARK: Fetch
    
    func fetch(completion: @escaping (Result<String, Error>) -> Void) {
        DispatchQueue.main.async {
            guard self.webView.configuration.isJavaScriptEnabled else {
                let error = WKUserAgentJavaScriptDisabledError()
                completion(.failure(error))
                return
            }
            
            self.webView.fetchUserAgentThroughJavaScript { result in
                switch result {
                case .success(let anyResult):
                    guard let userAgent = anyResult as? String else {
                        let error = WKUserAgentInvalidFetchResultError(anyResult)
                        completion(.failure(error))
                        return
                    }
                    completion(.success(userAgent))
                    
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
}
