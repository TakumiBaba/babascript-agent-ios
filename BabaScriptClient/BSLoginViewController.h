//
//  BSLoginViewController.h
//  BabaScriptClient
//
//  Created by TakumiBaba on 2014/02/24.
//  Copyright (c) 2014年 TakumiBaba. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BSAppDelegate.h"

@interface BSLoginViewController : UIViewController
{
    __weak IBOutlet UITextField *idField;
    __weak IBOutlet UITextField *passwordField;
    __weak IBOutlet UIButton *loginButton;
    __weak IBOutlet UIButton *signupButton;
    
    BSAppDelegate *appDelegate;
}

- (void) login;
- (void) signup;

@end
