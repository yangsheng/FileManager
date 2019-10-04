//
//  ViewController.m
//  FileManager
//
//  Created by EvenDev on 02/10/2019.
//  Copyright © 2019 EvenDev. All rights reserved.
//

#import "EDVFolderController.h"

@interface EDVFolderController ()

@end

@implementation EDVFolderController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = [[[[EDVManager sharedInstance] currentPath] componentsSeparatedByString:@"/"] lastObject];
    UIMenuItem *renameMenuItem = [[UIMenuItem alloc] initWithTitle:@"Rename" action:@selector(rename:)];
    UIMenuItem *deleteMenuItem = [[UIMenuItem alloc] initWithTitle:@"Delete" action:@selector(delet:)];
    [[UIMenuController sharedMenuController] setMenuItems: @[renameMenuItem, deleteMenuItem]];
    [[UIMenuController sharedMenuController] update];
}

-(void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    if ([[[[[EDVManager sharedInstance] currentPath] componentsSeparatedByString:@"/"] lastObject] isEqualToString:self.title]) {
        [[EDVManager sharedInstance] goBack];
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[[EDVManager sharedInstance] contentsOfCurrentDir] count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    EDVFileCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.textField.text = [[[EDVManager sharedInstance] contentsOfCurrentDir] objectAtIndex:indexPath.row];
    UIImage *icon;
    if ([EDVManager isDir:[NSString stringWithFormat:@"%@/%@", [[EDVManager sharedInstance] currentPath], cell.textField.text]]) {
        icon = [UIImage imageNamed:@"folder"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    } else {
        icon = [UIImage iconForFile:[NSString stringWithFormat:@"%@/%@", [[EDVManager sharedInstance] currentPath], cell.textField.text]];
    }
    cell.imageField.image = icon;
    cell.tableView = tableView;
    cell.indexPath = indexPath;
    cell.folderController = self;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    EDVFileCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (![EDVManager isDir:[NSString stringWithFormat:@"%@/%@", [[EDVManager sharedInstance] currentPath], cell.textField.text]]) {
        [[EDVManager sharedInstance] selectFile:cell.textField.text];
        NSString *filetype = [[NSMutableArray arrayWithArray:[cell.textField.text componentsSeparatedByString:@"."]] lastObject];
        if ([filetype isEqualToString:@"html"]) {
            [self performSegueWithIdentifier:@"html" sender:self];
        } else if ([filetype isEqualToString:@"md"]) {
            [self performSegueWithIdentifier:@"markdown" sender:self];
        } else {
            [self performSegueWithIdentifier:@"file" sender:self];
        }
    } else {
        [[EDVManager sharedInstance] openFolder:cell.textField.text];
        EDVFolderController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"folder"];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

-(void)dismissViewControllerAnimated:(BOOL)flag completion:(void (^)(void))completion {
    [super dismissViewControllerAnimated:flag completion:completion];
    if ([[self.presentedViewController class] isEqual:[EDVNewController class]]) {
        EDVNewController *vc = (EDVNewController *)self.presentedViewController;
        if (vc.save) {
            if (vc.segmentedControl.selectedSegmentIndex == 0) {
                [[EDVManager sharedInstance] createFile:vc.textField.text];
                [self.tableView reloadData];
            } else {
                [[EDVManager sharedInstance] createDirectory:vc.textField.text];
                [self.tableView reloadData];
                
            }
        }
    } else if ([[self.presentedViewController class] isEqual:[EDVRenameController class]]) {
        EDVRenameController *vc = (EDVRenameController *)self.presentedViewController;
        if (vc.save) {
            [[EDVManager sharedInstance] renameItem:vc.oldName to:vc.textField.text];
            [self.tableView reloadData];
        }
    }
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        EDVFileCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        [[EDVManager sharedInstance] removeFolderOrFile:cell.textField.text];
        [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationLeft];
    }
}

-(BOOL)tableView:(UITableView *)tableView shouldShowMenuForRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

-(BOOL)tableView:(UITableView *)tableView canPerformAction:(nonnull SEL)action forRowAtIndexPath:(nonnull NSIndexPath *)indexPath withSender:(nullable id)sender {
    return (action == @selector(rename:) || action == @selector(delet:));
}

-(void)tableView:(UITableView *)tableView performAction:(SEL)action forRowAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"rename"]) {
        NSLog(@"rename");
        EDVRenameController *vc = segue.destinationViewController;
        vc.textField.text = self.renameCell.textField.text;
        vc.imageView.image = self.renameCell.imageField.image;
    }
}

-(void)tableView:(UITableView *)tableView renameCellAtIndexPath:(nonnull NSIndexPath *)indexPath {
    EDVFileCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.textField.text = @"Bruh";
}

@end
