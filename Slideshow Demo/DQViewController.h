//
//  DQViewController.h
//  Slideshow Demo
//
//  Created by Dan Ray on 8/4/12.
//  Copyright (c) 2012 Dan Ray. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DQSlideshow.h"

@interface DQViewController : UIViewController <DQSlideshowDataSource>
{
    NSMutableArray *images;
    CGSize sliderContentSize;
}

// IBOutlets for Storyboard wiring
@property (nonatomic, strong) IBOutlet DQSlideshow *slideshow;
@property (nonatomic, strong) IBOutlet UILabel *label;
@property (nonatomic, strong) IBOutlet UIButton *pause;


-(IBAction)togglePause:(id)sender;

@end
