//
//  BSWebViewController.h
//  BabaScriptClient
//
//  Created by TakumiBaba on 2014/03/11.
//  Copyright (c) 2014年 TakumiBaba. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BSAppDelegate.h"

@interface BSWebViewController : UIViewController{
    IBOutlet __weak UIWebView *webView;
    BSAppDelegate *appDelegate;
    
}

@end
