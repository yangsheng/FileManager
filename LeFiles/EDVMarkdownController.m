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
    NSLog(@"Start parsing");
    NSMutableArray *lines = [NSMutableArray arrayWithArray:[self.content componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]]];
    [lines enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *line = obj;
        NSError *error;
        line = [MMMarkdown HTMLStringWithMarkdown:line extensions:MMMarkdownExtensionsGitHubFlavored error:&error];
        error ? [error log] : [lines replaceObjectAtIndex:idx withObject:line];
    }];
    preview.htmlString = [NSString stringWithFormat:@"<html><head><meta charset=\"UTF-8\"><meta name=\"viewport\" content=\"width=device-width, initial-scale=1\"><style>body {font-family: -apple-system, BlinkMacSystemFont, 'Helvetica Neue', sans-serif}h1 {font-size: 18pt;font-weight: 700;}a {font-size: 11pt;}hr {height: 1px;border: none; background-color: #CDCED3;}h2 {font-size: 13pt;font-weight: 700;}a:link {text-decoration: none;color: #007AFF}</style></head><body>%@</body></html>", [lines componentsJoinedByString:@""]];
    [self.childViewControllers makeObjectsPerformSelector:@selector(removeFromParentViewController)];
    [self.containerView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self addChildViewController:preview];
    preview.view.translatesAutoresizingMaskIntoConstraints = NO;
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
