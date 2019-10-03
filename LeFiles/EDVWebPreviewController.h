//
//  EDVWebPreviewController.h
//  LeFiles
//
//  Created by EvenDev on 03/10/2019.
//  Copyright © 2019 EvenDev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface EDVWebPreviewController : UIViewController

@property (strong, nonatomic) IBOutlet WKWebView *webView;
@property (strong, nonatomic) NSString *htmlString;

@end

NS_ASSUME_NONNULL_END
