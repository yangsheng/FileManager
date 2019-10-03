//
//  EDVFileController.m
//  LeFiles
//
//  Created by EvenDev on 03/10/2019.
//  Copyright © 2019 EvenDev. All rights reserved.
//

#import "EDVFileController.h"

@interface EDVFileController ()

@end

@implementation EDVFileController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSError *error;
    self.contents = [NSString stringWithContentsOfFile:[[EDVManager sharedInstance] selectedFile] encoding:NSUTF8StringEncoding error:&error];
    if (error) [error log];
    if (!error) self.textView.text = self.contents;
    self.title = [[[[EDVManager sharedInstance] selectedFile] componentsSeparatedByString:@"/"] lastObject];
}

- (IBAction)save:(id)sender {
    NSError *error;
    [self.textView.text writeToFile:[[EDVManager sharedInstance] selectedFile] atomically:NO encoding:NSUTF8StringEncoding error:&error];
    if (error) [error log];
    if (!error) [self cancel:self];
}

- (IBAction)cancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
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
