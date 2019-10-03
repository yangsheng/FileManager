//
//  EDVFileCell.m
//  LeFiles
//
//  Created by EvenDev on 03/10/2019.
//  Copyright © 2019 EvenDev. All rights reserved.
//

#import "EDVFileCell.h"

@implementation EDVFileCell

- (void)awakeFromNib {
    [super awakeFromNib];
    if (@available(iOS 13.0, *)) {
        self.textField.textColor = [UIColor labelColor];
    }
}

-(BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    return (action == @selector(rename:) || action == @selector(delet:));
}

-(BOOL)canBecomeFirstResponder {
    return YES;
}

-(void)rename:(id)sender {
    EDVFolderController *vc = self.folderController;
    vc.renameCell = self;
    [vc performSegueWithIdentifier:@"rename" sender:vc];
    [self.tableView selectRowAtIndexPath:[self indexPath] animated:YES scrollPosition:UITableViewScrollPositionNone];
}

-(void)delet:(id)sender {
    NSLog(@"%@", sender);
}

@end
