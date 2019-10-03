//
//  EDVWebController.h
//  LeFiles
//
//  Created by EvenDev on 03/10/2019.
//  Copyright © 2019 EvenDev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EDVWebEditorController.h"
#import "EDVWebPreviewController.h"
#import "EDVManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface EDVWebController : UIViewController

@property (strong, nonatomic) IBOutlet UIView *containerView;
@property (strong, nonatomic) IBOutlet UISegmentedControl *segmentedControl;
@property (strong, nonatomic) NSString *content;

@end

NS_ASSUME_NONNULL_END
