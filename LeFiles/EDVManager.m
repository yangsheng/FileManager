//
//  EDVManager.m
//  FileManager
//
//  Created by EvenDev on 02/10/2019.
//  Copyright © 2019 EvenDev. All rights reserved.
//

#import "EDVManager.h"

@implementation EDVManager

+ (id)sharedInstance {
    static EDVManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
        
    });
    
    return instance;
}

+(NSString *)startDirectory {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return [[paths objectAtIndex:0] stringByAppendingString:@"/Home"];
}

+(NSString *)documentDirectory {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return [paths objectAtIndex:0];
}

-(void)startWithPath:(NSString *)path {
    [self browse:[EDVManager startDirectory] create:YES];
    if (![[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithFormat:@"%@/bruh.txt", [EDVManager documentDirectory]]]) {
        [[NSFileManager defaultManager] createFileAtPath:[NSString stringWithFormat:@"%@/bruh.txt", [EDVManager documentDirectory]] contents:[@"this is just to get an icon for the app" dataUsingEncoding:NSUTF8StringEncoding] attributes:nil];
    }
}

-(void)browse:(NSString *)path create:(BOOL)create {
    // Replace current folder
    BOOL dir;
    if ([[NSFileManager defaultManager] fileExistsAtPath:path isDirectory:&dir]) {
        if (dir) {
            NSError *error;
            self.contents = [NSMutableArray arrayWithArray:[[[NSFileManager defaultManager] contentsOfDirectoryAtPath:path error:&error] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)]];
            if (error) [error log];
            if (!error) self.currentPath = path;
        } else {
            NSLog(@"%@ is a file", path);
        }
    } else {
        if (create) {
            NSError *error;
            [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:&error];
            if (error) [error log];
            BOOL directory;
            if ([[NSFileManager defaultManager] fileExistsAtPath:path isDirectory:&directory]) {
                NSError *error;
                self.contents = [NSMutableArray arrayWithArray:[[[NSFileManager defaultManager] contentsOfDirectoryAtPath:path error:&error] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)]];
                if (error) [error log];
                if (!error) self.currentPath = path;
            } else {
                NSLog(@"%@ doesn't exist and we couldn't create it... Maybe you don't have the permissions?", path);
            }
        } else {
            NSLog(@"%@ does not exist, perhaps create it?", path);
        }
    }
}

-(void)openFolder:(NSString *)folder {
    // Add folder to current folder
    [self browse:[NSString stringWithFormat:@"%@/%@", self.currentPath, folder] create:NO];
}

-(NSMutableArray *)contentsOfCurrentDir {
    return self.contents;
}

+(BOOL)isDir:(NSString *)dir {
    BOOL isDir;
    [[NSFileManager defaultManager] fileExistsAtPath:dir isDirectory:&isDir];
    return isDir;
}

-(void)selectFile:(NSString *)file {
    self.selectedFile = [NSString stringWithFormat:@"%@/%@", self.currentPath, file];
}

-(void)createFile:(NSString *)file {
    NSError *error;
    [@"" writeToFile:[NSString stringWithFormat:@"%@/%@", self.currentPath, file] atomically:NO encoding:NSUTF8StringEncoding error:&error];
    if (error) [error log];
    if (!error) [self browse:self.currentPath create:NO];
}

-(void)createDirectory:(NSString *)directory {
    NSError *error;
    [[NSFileManager defaultManager] createDirectoryAtPath:[NSString stringWithFormat:@"%@/%@", self.currentPath, directory] withIntermediateDirectories:NO attributes:nil error:&error];
    if (error) [error log];
    if (!error) [self browse:self.currentPath create:NO];
}

-(void)removeFolderOrFile:(NSString *)item {
    NSError *error;
    [[NSFileManager defaultManager] removeItemAtPath:[NSString stringWithFormat:@"%@/%@", self.currentPath, item] error:&error];
    if (error) [error log];
    if (!error) [self browse:self.currentPath create:NO];
}

-(void)goBack {
    NSMutableArray *pathComponents = [NSMutableArray arrayWithArray:[self.currentPath componentsSeparatedByString:@"/"]];
    [pathComponents removeLastObject];
    [self browse:[pathComponents componentsJoinedByString:@"/"] create:NO];
}

-(void)renameItem:(NSString *)old to:(NSString *)new {
    NSError *error;
    [[NSFileManager defaultManager] moveItemAtPath:[NSString stringWithFormat:@"%@/%@", self.currentPath, old] toPath:[NSString stringWithFormat:@"%@/%@", self.currentPath, new] error:&error];
    if (error) [error log];
    if (!error) [self browse:self.currentPath create:NO];
}

@end
