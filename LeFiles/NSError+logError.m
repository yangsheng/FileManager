//
//  NSError+logError.m
//  FileManager
//
//  Created by EvenDev on 02/10/2019.
//  Copyright © 2019 EvenDev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSError+logError.h"

@implementation NSError (logError)

-(void)log {
    NSLog(@"%@", self);
}

@end
