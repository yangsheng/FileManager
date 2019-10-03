//
//  EDVMainController.m
//  FileManager
//
//  Created by EvenDev on 02/10/2019.
//  Copyright © 2019 EvenDev. All rights reserved.
//

#import "EDVMainController.h"

@interface EDVMainController ()

@end

@implementation EDVMainController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[EDVManager sharedInstance] startWithPath:[EDVManager startDirectory]];
}

@end
