//
//  EDVMarkdownController.m
//  LeFiles
//
//  Created by EvenDev on 03/10/2019.
//  Copyright © 2019 EvenDev. All rights reserved.
//

#import "EDVMarkdownController.h"

@interface EDVMarkdownController ()

@end

@implementation EDVMarkdownController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSError *error;
    self.content = [NSString stringWithContentsOfFile:[[EDVManager sharedInstance] selectedFile] encoding:NSUTF8StringEncoding error:&error];
    error ? [error log] : [self openEditorWithContent:self.content];
}

- (IBAction)cancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)save:(id)sender {
    NSError *error;
    if (self.segmentedControl.selectedSegmentIndex == 0) {
        EDVMarkdownEditorController *vc = [self.childViewControllers objectAtIndex:0];
        self.content = vc.textView.text;
    }
    [self.content writeToFile:[[EDVManager sharedInstance] selectedFile] atomically:NO encoding:NSUTF8StringEncoding error:&error];
    error ? [error log] : [self cancel:self];
}

-(void)openEditorWithContent:(NSString *)content {
    [self.childViewControllers makeObjectsPerformSelector:@selector(removeFromParentViewController)];
    [self.containerView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    EDVMarkdownEditorController *editor = [self.storyboard instantiateViewControllerWithIdentifier:@"mdEditor"];
    [self addChildViewController:editor];
    editor.view.translatesAutoresizingMaskIntoConstraints = NO;
    [self.containerView addSubview:editor.view];
    editor.textView.text = content;
    
    [NSLayoutConstraint activateConstraints:[NSArray arrayWithObjects:[editor.view.leadingAnchor constraintEqualToAnchor:self.containerView.leadingAnchor], [editor.view.trailingAnchor constraintEqualToAnchor:self.containerView.trailingAnchor], [editor.view.topAnchor constraintEqualToAnchor:self.containerView.topAnchor], [editor.view.bottomAnchor constraintEqualToAnchor:self.containerView.bottomAnchor], nil]];
}

-(void)openPreview {
    EDVMarkdownEditorController *editor = [self.childViewControllers objectAtIndex:0];
    self.content = editor.textView.text;
    EDVMarkdownPreviewController *preview = [self.storyboard instantiateViewControllerWithIdentifier:@"mdPreview"];
    [self.childViewControllers makeObjectsPerformSelector:@selector(removeFromParentViewController)];
    [self.containerView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self addChildViewController:preview];
    preview.view.translatesAutoresizingMaskIntoConstraints = NO;
    preview.textView.linkTextAttributes = @{NSUnderlineColorAttributeName: [UIColor clearColor], NSForegroundColorAttributeName:self.view.tintColor};
    if (@available(iOS 13.0, *)) {
        preview.textView.attributedText = [[TSMarkdownParser standardParser] attributedStringFromMarkdown:self.content attributes:@{NSForegroundColorAttributeName:[UIColor labelColor]}];
    } else {
        preview.textView.attributedText = [[TSMarkdownParser standardParser] attributedStringFromMarkdown:self.content];
    }
    [self.containerView addSubview:preview.view];
    
    [NSLayoutConstraint activateConstraints:[NSArray arrayWithObjects:[preview.view.leadingAnchor constraintEqualToAnchor:self.containerView.leadingAnchor], [preview.view.trailingAnchor constraintEqualToAnchor:self.containerView.trailingAnchor], [preview.view.topAnchor constraintEqualToAnchor:self.containerView.topAnchor], [preview.view.bottomAnchor constraintEqualToAnchor:self.containerView.bottomAnchor], nil]];
}
- (IBAction)segmentedChange:(id)sender {
    if (self.segmentedControl.selectedSegmentIndex == 0) {
        [self openEditorWithContent:self.content];
    } else {
        [self openPreview];
    }
}

@end
