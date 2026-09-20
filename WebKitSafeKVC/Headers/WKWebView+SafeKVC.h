//
//  WebKit User-Agent
//
//  https://github.com/dmytriigolovanov/webkit-user-agent/blob/main/LICENSE
//

#import <Foundation/Foundation.h>
#import <WebKit/WebKit.h>

NS_ASSUME_NONNULL_BEGIN

/// Reads `[object valueForKey:key]`, catching any Objective-C exception KVC raises for an
/// unrecognized key (e.g. `NSUnknownKeyException`) instead of letting it crash the process.
///
/// Swift cannot catch `NSException`, so this exists purely to bridge that `@try`/`@catch`
/// into Swift as a `nil` result.
FOUNDATION_EXPORT id _Nullable WKWebViewSafeValueForKey(WKWebView *webView, NSString *key);

NS_ASSUME_NONNULL_END
