//
//  EDVFileCell.h
//  LeFiles
//
//  Created by EvenDev on 03/10/2019.
//  Copyright © 2019 EvenDev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EDVFolderController.h"

NS_ASSUME_NONNULL_BEGIN

@interface EDVFileCell : UITableViewCell

@property (nonatomic, strong) IBOutlet UILabel *textField;
@property (nonatomic, strong) IBOutlet UIImageView *imageField;
@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) __kindof UITableViewController *folderController;

-(void)rename:(id)sender;
-(void)delet:(id)sender;

@end

NS_ASSUME_NONNULL_END
