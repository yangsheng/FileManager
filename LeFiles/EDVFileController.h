//
//  EDVFileController.h
//  LeFiles
//
//  Created by EvenDev on 03/10/2019.
//  Copyright © 2019 EvenDev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EDVManager.h"
#import "NSError+logError.h"

NS_ASSUME_NONNULL_BEGIN

@interface EDVFileController : UIViewController

@property (nonatomic, retain) NSString *contents;
@property (strong, nonatomic) IBOutlet UITextView *textView;

@end

NS_ASSUME_NONNULL_END
