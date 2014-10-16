//
//  KKViewController.m
//  KKGestureLockView
//
//  Created by Luke on 8/5/13.
//  Copyright (c) 2013 geeklu. All rights reserved.
//

#import "KKViewController.h"
#import "KKAppDelegate.h"
@interface KKViewController ()

@end

@implementation KKViewController

- (void)setMyScreenSize
{
    KKAppDelegate *delegate = (KKAppDelegate *)[[UIApplication sharedApplication] delegate];
    cgfScreenWidth = [[UIScreen mainScreen] bounds].size.width;
    //    cgfScreenHeight = [[UIScreen mainScreen] bounds].size.height - [[UIApplication sharedApplication] statusBarFrame].size.height - delegate.tabBarController.tabBar.frame.size.height - self.navigationController.navigationBar.frame.size.height - [UIApplication sharedApplication].statusBarFrame.size.height;
    cgfScreenHeight = [[UIScreen mainScreen] bounds].size.height - [[UIApplication sharedApplication] statusBarFrame].size.height - [UIApplication sharedApplication].statusBarFrame.size.height;
    cgfScreenHeightBase = [UIApplication sharedApplication].statusBarFrame.size.height;
    NSLog(@"status bar height:%f",[UIApplication sharedApplication].statusBarFrame.size.height);
    //    NSLog(@"width:%f, height:%f, tabbar:%f, navigationbarcontroller:%f", cgfScreenWidth, cgfScreenHeight, delegate.tabBarController.tabBar.frame.size.height, self.navigationController.navigationBar.frame.size.height);
    NSLog(@"width:%f, height:%f, base:%f", cgfScreenWidth, cgfScreenHeight, cgfScreenHeightBase);
}

- (void)setMyGestureLockView
{
    self.lockView.normalGestureNodeImage = [UIImage imageNamed:@"gesture_node_normal.png"];
    self.lockView.selectedGestureNodeImage = [UIImage imageNamed:@"gesture_node_selected.png"];
    self.lockView.lineColor = [[UIColor greenColor] colorWithAlphaComponent:0.3];
    self.lockView.lineWidth = 15;
    self.lockView.delegate = self;
//    self.lockView.contentInsets = UIEdgeInsetsMake(150, 20, 100, 20);
    self.lockView.contentInsets = UIEdgeInsetsMake(cgfScreenHeight * 50.0 / 100.0, cgfScreenWidth * 4.0 / 100.0, cgfScreenHeight * 8.0 / 100.0, cgfScreenWidth * 4.0 / 100.0);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    [self setMyScreenSize];
    [self setMyGestureLockView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)gestureLockView:(KKGestureLockView *)gestureLockView didBeginWithPasscode:(NSString *)passcode{
    NSLog(@"%@",passcode);
}

- (void)gestureLockView:(KKGestureLockView *)gestureLockView didEndWithPasscode:(NSString *)passcode{
    NSLog(@"%@",passcode);
}

@end
