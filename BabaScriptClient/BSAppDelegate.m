//
//  BSAppDelegate.m
//  BabaScriptClient
//
//  Created by TakumiBaba on 2014/02/03.
//  Copyright (c) 2014年 TakumiBaba. All rights reserved.
//

#import "BSAppDelegate.h"
#import <AFNetworking/AFNetworking.h>
#import <LUKeychainAccess/LUKeychainAccess.h>

@implementation BSAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:UIRemoteNotificationTypeAlert];
    
//    LUKeychainAccess *access = [LUKeychainAccess standardKeychainAccess];
//    NSString *userid = [access stringForKey:@"id"];
//    NSString *password = [access stringForKey:@"password"];
//    if(![userid isEqualToString:@""] || ![password isEqualToString:@""]){
//        isLogin = NO;
//        return YES;
//    }else{
//        [self login:userid password:password callback:^(NSDictionary *data) {
//        }];
//    }
    isActive = true;
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
    
    isActive = false;
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

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    NSString *devicetoken = [NSString stringWithFormat:@"%@", deviceToken];
    NSLog(@"device token is %@", devicetoken);
    NSUUID *uuid = [UIDevice currentDevice].identifierForVendor;
    LUKeychainAccess *keychain = [LUKeychainAccess standardKeychainAccess];
    [keychain setObject:devicetoken forKey:@"token"];
    [keychain setObject:uuid.UUIDString forKey:@"uuid"];
    
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {

}

-(void) application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler
{
    
//    NSDictionary *aps = [userInfo objectForKey:@"aps"];
//    NSLog(@"aps ? %@", aps);
//    NSString *message = [aps objectForKey:@"alert"];
//    NSData *data = [message dataUsingEncoding:NSUTF8StringEncoding];
//    NSError *error = nil;
//    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
//    if(error != nil){
//        NSLog(@"error ? %@", error);
//    }
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"task" object:self userInfo: message];
//    NSLog(@"%@", json);
//    NSLog(@"%@", [[NSString alloc] initWithData:userInfo encoding:NSUTF8StringEncoding]);
    
}

- (void) login:(NSString *) userid password:(NSString *) password callback:(void (^)(NSDictionary *))callback
{
    NSLog(@"id is %@, pass is %@", userid, password);
    if(!isLogin){
        LUKeychainAccess *keychain = [LUKeychainAccess standardKeychainAccess];
        NSLog(@"%@", [keychain objectForKey:@"token"]);
        NSDictionary *param = @{
                                @"id": userid,
                                @"pass": password,
                                @"deviceId": [UIDevice currentDevice].identifierForVendor.UUIDString,
                                @"deviceType": @"APNS_SANDBOX",
                                @"token": [keychain objectForKey:@"token"]
                                };
        NSURL *apiURL = [[NSURL alloc] initWithString:kAPI];
        AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:apiURL];
        [manager POST:@"device/login" parameters:param success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSDictionary *data = responseObject;
            isLogin = YES;
            LUKeychainAccess *keychain = [LUKeychainAccess standardKeychainAccess];
            [keychain setObject:userid forKey:@"userid"];
            [keychain setObject:password forKey:@"password"];
            callback(data);
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            isLogin = NO;
            callback(@{@"error": error});
        }];
    }else{
        isLogin = YES;
        callback(@{@"status": @true});
    }
}
- (BOOL) isLogin
{
    return isLogin;
}

- (void)signup:(NSString *) userid password:(NSString *) password
{
    
}


- (void) logout
{
    
}

@end
