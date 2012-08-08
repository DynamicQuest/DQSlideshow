//
//  DQSlideshow.h
//  DQSlideshow
//
//  Created by Daniel Ray on 8/5/10.
//  Copyright 2010 Dynamic  Quest. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol DQSlideshowDataSource;


@interface DQSlideshow : UIView {
	NSMutableArray *imageList;
	NSMutableArray *views;
	NSURL *sourceURL;
	float bigwidth;
	float bigheight;
	float widthdiff;
	float heightdiff;
	int currentIndex;
	float slideDuration;
	
	UIImageView *one;
	UIImageView *two;
	
	BOOL paused;
	UIImageView *pausedViewOne;
	UIImageView *pausedViewTwo;
}

// Duration of each picture's slide, in seconds
@property (nonatomic) float slideDuration;

// Object to call for the array of images, and to notify about the
// size of images we want, and every time we turn a page
@property (nonatomic, weak) IBOutlet id<DQSlideshowDataSource> dataSource;

// Read-only property to indicate paused state
@property (nonatomic, readonly) BOOL paused;



-(void)start;
-(void)reset;
-(void)pause;
-(void)resume;


// If you have trouble with the linker recognizing this class
// in iOS 5.1, call the following empty method
// in main.m (see the one in this sample project).
 +(void)_keepAtLinkTime;

@end



@protocol DQSlideshowDataSource <NSObject>

@required
-(NSMutableArray *)imagesForSlideshow:(DQSlideshow *)slideshow;

@optional
-(void)setImageSize:(CGSize)bound;
-(void)indexChangedTo:(NSInteger)index;

@end









