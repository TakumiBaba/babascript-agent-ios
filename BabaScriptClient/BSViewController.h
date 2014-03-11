//
//  BSViewController.h
//  BabaScriptClient
//
//  Created by TakumiBaba on 2014/02/03.
//  Copyright (c) 2014年 TakumiBaba. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BSAppDelegate.h"

@interface BSViewController : UIViewController
{
    BSAppDelegate *appDelegate;
    __weak IBOutlet UIView *containerView;
    
    __weak IBOutlet UIViewController *booleanViewController;
    __weak IBOutlet UIViewController *stringViewController;
    __weak IBOutlet UIViewController *intViewController;
    __weak IBOutlet UIViewController *listViewController;
}

@end
