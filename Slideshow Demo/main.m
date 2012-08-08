//
//  main.m
//  Slideshow Demo
//
//  Created by Dan Ray on 8/4/12.
//  Copyright (c) 2012 Dan Ray. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "DQAppDelegate.h"
#import "DQSlideshow.h"

int main(int argc, char *argv[])
{
    [DQSlideshow _keepAtLinkTime];
    @autoreleasepool {
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([DQAppDelegate class]));
    }
}
