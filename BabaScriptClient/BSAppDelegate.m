//
//  BSAppDelegate.m
//  BabaScriptClient
//
//  Created by TakumiBaba on 2014/02/03.
//  Copyright (c) 2014年 TakumiBaba. All rights reserved.
//

#import "BSAppDelegate.h"
#import <Parse/Parse.h>

@implementation BSAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    [Parse setApplicationId:@"pyvshzjKW4PjrGsnyzFigtWk9AQYtSO1FpQ1U2jX" clientKey:@"IcnTGAjaeK40bRQfGVDO6YtoQxywfoDRfxyD6RWK"];
    
    [application registerForRemoteNotificationTypes:UIRemoteNotificationTypeBadge];
    
//    既にオブジェクトが存在してないか確認後、登録
    PFInstallation *installation = [PFInstallation currentInstallation];
    [installation saveInBackground];
    NSString *installationId = [installation installationId];
    PFQuery *q = [PFQuery queryWithClassName:@"masuilab"];
    [q whereKey:@"installationId" equalTo:installationId];
    [q findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if(!error){
            if([objects count] == 0){
                PFObject *object = [PFObject objectWithClassName:@"masuilab"];
                object[@"deviceType"] = @"ios";
                object[@"installationId"] = installationId;
                [object saveInBackground];
            }
        }
    }];
    
    
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    // Store the deviceToken in the current installation and save it to Parse.
    PFInstallation *currentInstallation = [PFInstallation currentInstallation];
    [currentInstallation setDeviceTokenFromData:deviceToken];
    [currentInstallation saveInBackground];
}

- (void)application:(UIApplication *)application
didReceiveRemoteNotification:(NSDictionary *)userInfo {
    [PFPush handlePush:userInfo];
}

@end
