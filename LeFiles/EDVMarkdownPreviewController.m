//
//  EDVMarkdownPreviewController.m
//  LeFiles
//
//  Created by EvenDev on 03/10/2019.
//  Copyright © 2019 EvenDev. All rights reserved.
//

#import "EDVMarkdownPreviewController.h"

@interface EDVMarkdownPreviewController ()

@end

@implementation EDVMarkdownPreviewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.webView loadHTMLString:self.htmlString baseURL:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
