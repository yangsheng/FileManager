//
//  EDVWebEditorController.m
//  LeFiles
//
//  Created by EvenDev on 03/10/2019.
//  Copyright © 2019 EvenDev. All rights reserved.
//

#import "EDVWebEditorController.h"

@interface EDVWebEditorController ()

@end

@implementation EDVWebEditorController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.textView becomeFirstResponder];
}

-(void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self.textView resignFirstResponder];
}

@end
