//
//  WebKit User-Agent
//
//  https://github.com/dmytriigolovanov/webkit-user-agent/blob/main/LICENSE
//

#import "WKWebView+SafeKVC.h"

id WKWebViewSafeValueForKey(WKWebView *webView, NSString *key) {
    @try {
        return [webView valueForKey:key];
    } @catch (NSException *exception) {
        return nil;
    }
}
