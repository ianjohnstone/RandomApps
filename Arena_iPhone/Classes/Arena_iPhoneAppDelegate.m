//
//  Arena_iPhoneAppDelegate.m
//  Arena_iPhone
//
//  Created by Ian Johnstone on 10-08-17.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import "Arena_iPhoneAppDelegate.h"
#import "Arena_iPhoneViewController.h"

@implementation Arena_iPhoneAppDelegate

@synthesize window;
@synthesize viewController;


- (void)applicationDidFinishLaunching:(UIApplication *)application {    
    
    // Override point for customization after app launch    
    [window addSubview:viewController.view];
    [window makeKeyAndVisible];
}


- (void)dealloc {
    [viewController release];
    [window release];
    [super dealloc];
}


@end
