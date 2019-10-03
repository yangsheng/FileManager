//
//  EDVNewController.m
//  LeFiles
//
//  Created by EvenDev on 03/10/2019.
//  Copyright © 2019 EvenDev. All rights reserved.
//

#import "EDVNewController.h"

@interface EDVNewController ()

@end

@implementation EDVNewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (@available(iOS 13.0, *)) {
        self.textField.textColor = [UIColor labelColor];
    }
    [self.view addSubview:self.backgroundView];
    self.textField.inputAccessoryView = self.backgroundView;
    [self.textField becomeFirstResponder];
    
    self.imageView.image = [UIImage iconForFile:[[EDVManager documentDirectory] stringByAppendingString:@"/bruh.txt"]];
}

- (IBAction)segmentChanged:(id)sender {
    if (self.segmentedControl.selectedSegmentIndex == 0) {
        self.imageView.image = [UIImage iconForFile:[[EDVManager documentDirectory] stringByAppendingString:@"/bruh.txt"]];
        self.textField.placeholder = @"File";
    } else {
        self.imageView.image = [UIImage imageNamed:@"folder"];
        self.textField.placeholder = @"Folder";
    }
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
