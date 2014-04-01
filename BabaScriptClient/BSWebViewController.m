//
//  BSWebViewController.m
//  BabaScriptClient
//
//  Created by TakumiBaba on 2014/03/11.
//  Copyright (c) 2014年 TakumiBaba. All rights reserved.
//

#import "BSWebViewController.h"
#import <LUKeychainAccess/LUKeychainAccess.h>

@interface BSWebViewController ()
{
    NSNotificationCenter *nc;
}

@end

@implementation BSWebViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void) viewWillDisappear:(BOOL)animated
{
    [nc removeObserver:self];
    [super viewWillDisappear:animated];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if(!appDelegate) appDelegate = [[UIApplication sharedApplication] delegate];
    LUKeychainAccess *keychain = [LUKeychainAccess standardKeychainAccess];
    NSString *userid = [keychain objectForKey:@"userid"];
    NSString *password = [keychain objectForKey:@"password"];
//    userid = @"akiyama";
//    password = @"hiroki";
    if(![appDelegate isLogin]){
        if(!(userid == nil || [userid isEqualToString:@""]) || !(password == nil || [password isEqualToString:@""])){
            [appDelegate login:userid password:password callback:^(NSDictionary *data) {
                NSLog(@"%@", data);
                [self dismissViewControllerAnimated:YES completion:nil];
                [self startWebView: userid];
            }];
        }else{
            [self performSegueWithIdentifier:@"loginModal" sender:self];
        }
    }else{
        [self startWebView:userid];
    }
    
}

- (void) startWebView:(NSString *)name
{
    NSString *address = [NSString stringWithFormat:@"%@/%@/index", kServerAddress, name];
    NSLog(@"address is %@", address);
    NSURL *url = [[NSURL alloc] initWithString:address];
    NSURLRequest *req = [NSURLRequest requestWithURL:url];
    [webView loadRequest:req];
    
    nc = [NSNotificationCenter defaultCenter];
    [nc addObserver:self selector:@selector(addTask) name:@"task" object:nil];
}

- (void) addTask:(NSNotification *)n
{
    NSDictionary *info = [n userInfo];
    NSLog(@"%@", info);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
