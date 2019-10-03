//
//  EDVNewController.m
//  LeFiles
//
//  Created by EvenDev on 03/10/2019.
//  Copyright © 2019 EvenDev. All rights reserved.
//

#import "EDVRenameController.h"

@interface EDVRenameController ()

@end

@implementation EDVRenameController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.oldName = self.textField.text;
    if (@available(iOS 13.0, *)) {
        self.textField.textColor = [UIColor labelColor];
    }
    [self.view addSubview:self.backgroundView];
    self.textField.inputAccessoryView = self.backgroundView;
    [self.textField becomeFirstResponder];
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.textField resignFirstResponder];
}

- (IBAction)dismisss:(id)sender {
    [self.textField resignFirstResponder];
    self.save = NO;
    EDVMainController *vc = (EDVMainController *)self.presentingViewController;
    [vc.topViewController dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)done:(id)sender {
    [self.textField resignFirstResponder];
    self.save = YES;
    EDVMainController *vc = (EDVMainController *)self.presentingViewController;
    [vc.topViewController dismissViewControllerAnimated:YES completion:nil];
}

@end
