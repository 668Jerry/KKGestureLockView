//
//  KKViewController.m
//  KKGestureLockView
//
//  Created by Luke on 8/5/13.
//  Copyright (c) 2013 geeklu. All rights reserved.
//

#import "KKViewController.h"
@interface KKViewController ()

@end

@implementation KKViewController

- (void)setMyScreenSize
{
    delegate = (KKAppDelegate *)[[UIApplication sharedApplication] delegate];
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
    self.lockView.contentInsets = UIEdgeInsetsMake(cgfScreenHeight * 40.0 / 100.0, cgfScreenWidth * 4.0 / 100.0, cgfScreenHeight * 8.0 / 100.0, cgfScreenWidth * 4.0 / 100.0);
}

- (CGFloat)gestureNodeX:(NSUInteger)nsiNodeNumber
{
    switch (nsiNodeNumber)
    {
        case 0: case 3: case 6:
            return 122.0;
        case 1: case 4: case 7:
            return 150.0;
        case 2: case 5: case 8:
            return 178.0;
    }
    return 0.0;
}

- (CGFloat)gestureNodeY:(NSUInteger)nsiNodeNumber
{
    switch (nsiNodeNumber)
    {
        case 0: case 1: case 2:
            return 30.0 + cgfScreenHeightBase;
        case 3: case 4: case 5:
            return 58.0 + cgfScreenHeightBase;
        case 6: case 7: case 8:
            return 86.0 + cgfScreenHeightBase;
    }
    return 0.0;
}

- (void)setMyInitImage
{
    for (NSUInteger i = 0; i < 9; i++) {
        uiivGesture[i] = [[UIImageView alloc] initWithFrame:CGRectMake([self gestureNodeX:(i)], [self gestureNodeY:(i)], 20.0, 20.0)];
        uiivGesture[i].image = [UIImage imageNamed:@"O"];
        [self.view addSubview:uiivGesture[i]];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    [self setMyScreenSize];
    [self setMyInitImage];
    [self setMyGestureLockView];
}

- (UIImage *)gestureImage:(int)iNowPathNumber
                   length:(int)iPathLength
{
    if (iNowPathNumber == 0) {
        return [UIImage imageNamed:@"S"];
    }else if (iNowPathNumber != iPathLength - 1) {
        return [UIImage imageNamed:@"N"];
    }else {
        return [UIImage imageNamed:@"E"];
    }
}

- (void)addLine:(NSUInteger)nsuiUIImageID
 fromNodeNumber:(NSUInteger)nsuiFromNodeNumber
   toNodeNumber:(NSUInteger)nsuiToNodeNumber

{
    NSUInteger nsuiSmallNumber;
    NSUInteger nsuiBigNumber;
    if (nsuiFromNodeNumber < nsuiToNodeNumber) {
        nsuiSmallNumber = nsuiFromNodeNumber;
        nsuiBigNumber = nsuiToNodeNumber;
    }else {
        nsuiSmallNumber = nsuiToNodeNumber;
        nsuiBigNumber = nsuiFromNodeNumber;
    }
    
    if (nsuiBigNumber - nsuiSmallNumber == 1) {
        uiivLine[nsuiUIImageID] = [[UIImageView alloc] initWithFrame:CGRectMake([self gestureNodeX:nsuiSmallNumber], [self gestureNodeY:nsuiSmallNumber], 48, 20)];
        uiivLine[nsuiUIImageID].image = [UIImage imageNamed:@"hl"];
        [self.view addSubview:uiivLine[nsuiUIImageID]];
    } else if (nsuiBigNumber - nsuiSmallNumber == 3) {
        uiivLine[nsuiUIImageID] = [[UIImageView alloc] initWithFrame:CGRectMake([self gestureNodeX:nsuiSmallNumber], [self gestureNodeY:nsuiSmallNumber], 20, 48)];
        uiivLine[nsuiUIImageID].image = [UIImage imageNamed:@"vl"];
        [self.view addSubview:uiivLine[nsuiUIImageID]];
    }if (nsuiBigNumber - nsuiSmallNumber == 4) {
        uiivLine[nsuiUIImageID] = [[UIImageView alloc] initWithFrame:CGRectMake([self gestureNodeX:nsuiSmallNumber], [self gestureNodeY:nsuiSmallNumber], 48, 48)];
        uiivLine[nsuiUIImageID].image = [UIImage imageNamed:@"bl"];
        [self.view addSubview:uiivLine[nsuiUIImageID]];
    }if (nsuiBigNumber - nsuiSmallNumber == 2) {
        uiivLine[nsuiUIImageID] = [[UIImageView alloc] initWithFrame:CGRectMake([self gestureNodeX:nsuiSmallNumber - 1], [self gestureNodeY:nsuiSmallNumber - 1], 48, 48)];
        uiivLine[nsuiUIImageID].image = [UIImage imageNamed:@"sl"];
        [self.view addSubview:uiivLine[nsuiUIImageID]];
    }
    NSLog(@"add %lu-%lu finished", (unsigned long)nsuiSmallNumber, (unsigned long)nsuiBigNumber);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)gestureLockView:(KKGestureLockView *)gestureLockView didBeginWithPasscode:(NSString *)passcode{
    NSLog(@"%@",passcode);
}

- (void)removeMyPoint:(NSInteger)nsiIndex
                point:(NSInteger)nsiPoint
{
    NSLog(@"remove point %lu: %lu", (unsigned long)nsiIndex, (unsigned long)nsiPoint);
    [uiivGesture[nsiPoint] removeFromSuperview];
    uiivGesture[nsiPoint] = nil;
}

- (void)addMyPoint:(NSInteger)nsiIndex
                point:(NSInteger)nsiPoint
{
    NSLog(@"add point %lu: %ld", (unsigned long)nsiIndex, (long)nsiPoint);
    uiivGesture[nsiPoint] = [[UIImageView alloc] initWithFrame:CGRectMake([self gestureNodeX:nsiPoint], [self gestureNodeY:nsiPoint], 20, 20)];
    uiivGesture[nsiPoint].image = [self gestureImage:nsiIndex - 1 length:[delegate.nssPasswordValue length]];
    [self.view addSubview:uiivGesture[nsiPoint]];
}

- (void)gestureLockView:(KKGestureLockView *)gestureLockView didEndWithPasscode:(NSString *)passcode{
    delegate.nssPasswordValue = [NSString stringWithString:[passcode stringByReplacingOccurrencesOfString:@"," withString:@""]];

    [self removeMyPoint:1 point:[[delegate.nssPasswordValue substringWithRange:NSMakeRange(0, 1)] integerValue]];

    for (NSUInteger i = 1; i < [delegate.nssPasswordValue length]; i ++)
    {
        NSUInteger nsiI = [[delegate.nssPasswordValue substringWithRange:NSMakeRange(i - 1, 1)] integerValue];
        NSUInteger nsiJ = [[delegate.nssPasswordValue substringWithRange:NSMakeRange(i, 1)] integerValue];
        
        [self removeMyPoint:i + 1 point:nsiJ];
        
        NSLog(@"add line %lu-%lu: %ld-%ld", (unsigned long)i, (unsigned long)i + 1, (long)nsiI, (long)nsiJ);
        [self addLine:i - 1 fromNodeNumber:nsiI toNodeNumber:nsiJ];
        
        [self addMyPoint:i point:nsiI];
    }
    [self addMyPoint:[delegate.nssPasswordValue length] point:[[delegate.nssPasswordValue substringWithRange:NSMakeRange([delegate.nssPasswordValue length] - 1, 1)] integerValue]];
    NSLog(@"%@",delegate.nssPasswordValue);
}

@end
