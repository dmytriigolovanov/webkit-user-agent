//
//  Copyright (c) 2022 Dmytrii Golovanov
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//
//  WKUserAgentWorker.swift
//  Created by Dmytrii Golovanov on 03.12.2021.
//

import Foundation
import WebKit

final class WKUserAgentWorker: NSObject {
    private let webView: WKWebView
    
    // MARK: Init
    
    init(webView: WKWebView) {
        self.webView = webView
    }
    
    convenience init(applicationName: String) {
        let webViewConfiguration = WKWebViewConfiguration()
        webViewConfiguration.applicationNameForUserAgent = applicationName
        
        let webView = WKWebView(frame: .zero, configuration: webViewConfiguration)
        self.init(webView: webView)
    }
    
    // MARK: Get User Agent
    
    func getUserAgent(completion: @escaping (Result<String, Error>) -> Void) {
        DispatchQueue.main.async {
            guard self.webView.configuration.isJavaScriptEnabled else {
                let error = WKUserAgentError.javaScriptDisabled
                completion(.failure(error))
                return
            }
            
            self.webView.getUserAgent { result in
                switch result {
                case .success(let anyResult):
                    guard let anyResult = anyResult else {
                        let error = WKUserAgentError.javaScriptCompletedWithNil
                        completion(.failure(error))
                        return
                    }
                    
                    guard let userAgent = anyResult as? String else {
                        let error = WKUserAgentError.javaScriptCompletedWithNonString(result: anyResult)
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
