//
//  ViewController.h
//  FileManager
//
//  Created by EvenDev on 02/10/2019.
//  Copyright © 2019 EvenDev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSError+logError.h"
#import "EDVManager.h"
#import "UIImage+getIcon.h"
#import "EDVFileCell.h"
#import "EDVNewController.h"
#import "EDVRenameController.h"

@class EDVFileCell;

@interface EDVFolderController : UITableViewController

@property (nonatomic, strong) EDVFileCell *renameCell;

@end

