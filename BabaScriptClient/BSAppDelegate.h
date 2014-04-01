//
//  BSAppDelegate.h
//  BabaScriptClient
//
//  Created by TakumiBaba on 2014/02/03.
//  Copyright (c) 2014年 TakumiBaba. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BSAppDelegate : UIResponder <UIApplicationDelegate>
{
    BOOL isLogin;
    BOOL isActive;
}

@property (strong, nonatomic) UIWindow *window;

- (BOOL) isLogin;
- (void) login:(NSString *) userid password:(NSString *) password callback:(void (^)(NSDictionary *))callback;
- (void) logout;
- (void) signup:(NSString *) userid password:(NSString *) password;

@end
