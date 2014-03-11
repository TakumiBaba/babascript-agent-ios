//
//  BSViewController.m
//  BabaScriptClient
//
//  Created by TakumiBaba on 2014/02/03.
//  Copyright (c) 2014年 TakumiBaba. All rights reserved.
//

#import "BSViewController.h"
#import "BSLoginViewController.h"
#import "BSAppDelegate.h"
#import "BSBooleanViewController.h"

#import <LUKeychainAccess/LUKeychainAccess.h>

@interface BSViewController ()

@end

@implementation BSViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    	// Do any additional setup after loading the view, typically from a nib.
}

- (void) viewDidAppear:(BOOL)animated
{
    if(!appDelegate) appDelegate = [[UIApplication sharedApplication] delegate];
    if(![appDelegate isLogin]){
        LUKeychainAccess *keychain = [LUKeychainAccess standardKeychainAccess];
        NSString *userid = [keychain objectForKey:@"userid"];
        NSString *password = [keychain objectForKey:@"password"];
        if(!(userid == nil || [userid isEqualToString:@""]) || !(password == nil || [password isEqualToString:@""])){
            [appDelegate login:userid password:password callback:^(NSDictionary *data) {
                NSLog(@"%@", data);
                [self dismissViewControllerAnimated:YES completion:nil];
            }];
        }else{
            [self performSegueWithIdentifier:@"loginModal" sender:self];
        }
    }
//    BSBooleanViewController *boolean = [[BSBooleanViewController alloc] init];
//    
//    [self addChildViewController:boolean];
//    [self transitionFromViewController:self toViewController:boolean duration:0.25 options:UIViewAnimationOptionCurveEaseIn animations:^{
//        
//    } completion:^(BOOL finished) {
//        
//    }];
//    [returnValueView addSubview:booleanViewController.view];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
}

@end
