//
//  EDVManager.h
//  FileManager
//
//  Created by EvenDev on 02/10/2019.
//  Copyright © 2019 EvenDev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSError+logError.h"
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface EDVManager : NSObject

+ (id)sharedInstance;

@property (nonatomic, strong) NSMutableArray *contents;
@property (nonatomic, strong) NSString *currentPath;
@property (nonatomic, strong) NSString *selectedFile;

-(void)startWithPath:(NSString *)path;
-(void)browse:(NSString *)path create:(BOOL)create;
-(void)openFolder:(NSString *)folder;
+(NSString *)startDirectory;
+(NSString *)documentDirectory;
-(NSMutableArray *)contentsOfCurrentDir;
+(BOOL)isDir:(NSString *)dir;
-(void)selectFile:(NSString *)file;
-(void)createFile:(NSString *)file;
-(void)createDirectory:(NSString *)directory;
-(void)removeFolderOrFile:(NSString *)item;
-(void)goBack;
-(void)renameItem:(NSString *)old to:(NSString *)new;

@end

NS_ASSUME_NONNULL_END
