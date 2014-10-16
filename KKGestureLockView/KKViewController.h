//
//  KKViewController.h
//  KKGestureLockView
//
//  Created by Luke on 8/5/13.
//  Copyright (c) 2013 geeklu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KKGestureLockView.h"
#import "KKAppDelegate.h"

@interface KKViewController : UIViewController<KKGestureLockViewDelegate>
{
    UIImageView *uiivGesture[9];
    UIImageView *uiivLine[8];
    
    CGFloat cgfScreenWidth;
    CGFloat cgfScreenHeight;
    CGFloat cgfScreenHeightBase;
    
    KKAppDelegate *delegate;
}

@property (nonatomic, strong) KKGestureLockView *lockView;
@end
