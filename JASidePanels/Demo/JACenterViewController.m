/*
 Copyright (c) 2012 Jesse Andersen. All rights reserved.
 
 Permission is hereby granted, free of charge, to any person obtaining a copy of
 this software and associated documentation files (the "Software"), to deal in
 the Software without restriction, including without limitation the rights to
 use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
 of the Software, and to permit persons to whom the Software is furnished to do
 so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all
 copies or substantial portions of the Software.
 
 If you happen to meet one of the copyright holders in a bar you are obligated
 to buy them one pint of beer.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 SOFTWARE.
 */

#import "JACenterViewController.h"
#import "JASidePanelController.h"

#import "UIViewController+JASidePanel.h"

@interface JACenterViewController ()

@property (strong, nonatomic) UIButton *showLeftPanelWithCompletionButton;
@property (strong, nonatomic) UILabel  *animationDoneLabel;

@end

@implementation JACenterViewController

- (id)init {
    if (self = [super init]) {
        self.title = @"Center Panel";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGFloat red = (CGFloat)arc4random() / 0x100000000;
    CGFloat green = (CGFloat)arc4random() / 0x100000000;
    CGFloat blue = (CGFloat)arc4random() / 0x100000000;
    self.view.backgroundColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0f];
    
    self.showLeftPanelWithCompletionButton = [[UIButton alloc] initWithFrame:CGRectZero];
    [self.showLeftPanelWithCompletionButton setTitle:@"Show Left Panel (Completion)" forState:UIControlStateNormal];
    [self.showLeftPanelWithCompletionButton sizeToFit];
    self.showLeftPanelWithCompletionButton.autoresizingMask = UIViewAutoresizingFlexibleRightMargin
                                                            | UIViewAutoresizingFlexibleLeftMargin
                                                            | UIViewAutoresizingFlexibleBottomMargin;

    CGRect frame = CGRectMake(20.0, 70.0,
                              CGRectGetWidth(self.view.frame) - 40.0,
                              self.showLeftPanelWithCompletionButton.frame.size.height);
    self.showLeftPanelWithCompletionButton.frame = frame;
    
    [self.showLeftPanelWithCompletionButton addTarget:self
                                               action:@selector(_showLeftTapped:)
                                     forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.showLeftPanelWithCompletionButton];
    
    self.animationDoneLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.animationDoneLabel.text = @"Done!";
    self.animationDoneLabel.autoresizingMask = UIViewAutoresizingFlexibleRightMargin
                                             | UIViewAutoresizingFlexibleLeftMargin
                                             | UIViewAutoresizingFlexibleTopMargin;
    self.animationDoneLabel.alpha = 0.0;
    [self.animationDoneLabel sizeToFit];
    self.animationDoneLabel.frame = CGRectMake(20.0,
                                               CGRectGetHeight(self.view.bounds) - CGRectGetHeight(self.animationDoneLabel.frame) - 40.0,
                                               CGRectGetWidth(self.view.frame) - 40.0,
                                               self.animationDoneLabel.frame.size.height);
    [self.view addSubview:self.animationDoneLabel];
}

- (void)_showLeftTapped:(UIButton *)button {
    [self.sidePanelController showLeftPanelAnimated:YES completion:^(BOOL finished) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Show Left Panel"
                                                                       message:@"Animation completed!"
                                                                preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
        [self presentViewController:alert animated:YES completion:nil];
    }];
}

@end
