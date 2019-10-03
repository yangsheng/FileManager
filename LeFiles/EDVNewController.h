//
//  EDVNewController.h
//  LeFiles
//
//  Created by EvenDev on 03/10/2019.
//  Copyright © 2019 EvenDev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImage+getIcon.h"
#import "EDVManager.h"
#import "EDVMainController.h"

NS_ASSUME_NONNULL_BEGIN

@interface EDVNewController : UIViewController

@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UITextField *textField;
@property (strong, nonatomic) IBOutlet UIView *backgroundView;
@property (strong, nonatomic) IBOutlet UISegmentedControl *segmentedControl;
@property (nonatomic) BOOL save;

@end

NS_ASSUME_NONNULL_END
