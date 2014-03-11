//
//  BSLoginViewController.m
//  BabaScriptClient
//
//  Created by TakumiBaba on 2014/02/24.
//  Copyright (c) 2014年 TakumiBaba. All rights reserved.
//

#import "BSLoginViewController.h"
#import "BSAppDelegate.h"

@interface BSLoginViewController ()

@end

@implementation BSLoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [loginButton addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchDown];
    appDelegate = [[UIApplication sharedApplication] delegate];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) login
{
    NSString *userid = idField.text;
    NSString *password = passwordField.text;
    [appDelegate login:userid password:password callback:^(NSDictionary *data) {
        [self dismissViewControllerAnimated:YES completion:nil];
        NSLog(@"%@", data);
    }];
}

- (void) signup
{
    
}

@end
