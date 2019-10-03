//
//  UIImage+getIcon.m
//  LeFiles
//
//  Created by EvenDev on 02/10/2019.
//  Copyright © 2019 EvenDev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIImage+getIcon.h"

@implementation UIImage (getIcon)

+(UIImage *)iconForFile:(NSString *)path {
    UIDocumentInteractionController *controller = [[UIDocumentInteractionController alloc] init];
    controller.URL = [NSURL fileURLWithPath:path];
    UIImage *icon = [controller.icons lastObject];
    return icon;
}

@end
