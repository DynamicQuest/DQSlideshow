//
//  DQViewController.m
//  Slideshow Demo
//
//  Created by Dan Ray on 8/4/12.
//  Copyright (c) 2012 Dan Ray. All rights reserved.
//

#import "DQViewController.h"
#import "DQSlideshow.h"


@implementation DQViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    
    // Instantiate our array of images
    images = [NSMutableArray array];
    
    // DQSlideshow *slideshow is instantiated in the nib,
    // though it could be constructed programattically right here.
    [self.slideshow setSlideDuration:4.5];
    [self.slideshow start];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    //portrait only 
    return interfaceOrientation == UIInterfaceOrientationPortrait;
}


-(NSMutableArray *)imagesForSlideshow:(DQSlideshow *)slideshow
{
    // Our demo has images named 1.jpg through 13.jpg, so we'll just load
    // those. You could also get these images from a web request, the photo
    // library using Assets, etc.
    
    for (int i = 1; i <= 13; i++) {
        NSString *filename = [NSString stringWithFormat:@"%d.jpg", i];
        UIImage *anImage = [UIImage imageNamed:filename];
        
        
        // If you were going to resize these to the size set in sliderContentSize
        // (and for memory reasons, you should), here's where you'd do that.
        // I like Matt Gemmel's MGImageUtilities for such things:
        // http://mattgemmell.com/2010/07/05/mgimageutilities/
        
        [images addObject:anImage];
    }
    
    return images;
}

-(void)setImageSize:(CGSize )size
{
    // CGSize passed in from slideshow component, for the size of
    // images it wants to receive.
    sliderContentSize = size;
}

-(void)indexChangedTo:(NSInteger)index
{
    // receive a notification of where we are in the images array. If you had
    // an array of captions to keep in sync, here's where you'd do that.
    [self.label setText:[NSString stringWithFormat:@"Image %d.jpg", index +1]];
}

-(void)togglePause:(id)sender
{
    // Our pause button was hit. Pass that along to the slideshow, and
    // do whatever UI updates are appropriate.
    
    if ([self.slideshow paused]) {
        [self.slideshow resume];
        [self.pause setTitle:@"Pause" forState:UIControlStateNormal];
    } else {
        [self.slideshow pause];
        [self.pause setTitle:@"Resume" forState:UIControlStateNormal];
    }
    
}



@end
