//
//  DQSlideshow.m
//  DQSlideshow
//
//  Created by Daniel Ray on 8/5/10.
//  Copyright 2010 Dynamic  Quest. All rights reserved.
//

#import "DQSlideshow.h"

@implementation DQSlideshow

@synthesize dataSource;
@synthesize slideDuration;
@synthesize paused;



-(void)setFrames
{
	float ypos = -(bigheight - self.frame.size.height) / 2;
	CGRect oneFrame = CGRectMake(0, ypos, bigwidth, bigheight);
	one.frame = oneFrame;
	
	
	CGRect twoFrame = CGRectMake(0 - widthdiff, ypos, bigwidth, bigheight);
	two.frame = twoFrame;
	
}


-(void)beginRender
{
	
	if (!slideDuration) {
		slideDuration = 8.0;
	}
	self.clipsToBounds = YES;
	
	CGRect myFrame = self.frame;

	widthdiff = bigwidth - myFrame.size.width;
	heightdiff = bigheight - myFrame.size.height;
	
	one = [[UIImageView alloc] init];
	one.contentMode = UIViewContentModeScaleAspectFill;
	one.alpha = 0.0;
	
	two = [[UIImageView alloc] init];
	two.alpha = 0.0;
	two.contentMode = UIViewContentModeScaleAspectFill;
	
	[self setFrames];
	
	views = [NSMutableArray arrayWithObjects:one, two, nil];

	currentIndex = 0;
    if ([dataSource respondsToSelector:@selector(indexChangedTo:)]) {
        [dataSource indexChangedTo:currentIndex];
    }
	
	[self addSubview:one];
	[one setImage:[imageList objectAtIndex:currentIndex]];
	[self fadeIn:one toDirection:@"left"];

	
}
	


	
-(void)fadeIn:(UIImageView *)imageview toDirection:(NSString *)direction
{
	
	[UIView animateWithDuration:0.1
					 animations:^{ imageview.alpha = 1.0; }
					 completion:^(BOOL finished){
						 if ([direction isEqualToString:@"right"]) {
							 [self slideRight:imageview];
						 }
						 else {
							 [self slideLeft:imageview];
						 }

					 }];
	
}

-(void)fadeOut:(UIImageView *)imageview toView:(UIImageView *)nextView;
{
	[UIView animateWithDuration:0.5
                     animations:^{
                         
                         imageview.alpha = 0.0;
                     }
                     completion:^(BOOL finished){
                         [imageview removeFromSuperview];
                         [self setFrames];
                         
                         
                         
                         if (currentIndex % 2) {
                             [self slideRight:nextView];
                         }
                         else {
                             [self slideLeft:nextView];
                         }
                         
                     }];
	
}

-(void)slideRight:(UIImageView *)imageview
{
	[UIView animateWithDuration:slideDuration
						  delay:0
						options:UIViewAnimationCurveEaseOut
					 animations:^{
						 float newY;
						 float sizeMult = 1;
						 if (imageview.image.size.height > imageview.image.size.width) {
							 newY = imageview.frame.origin.y - heightdiff;
						 }
						 else {
							 newY = imageview.frame.origin.y - heightdiff ;
							 sizeMult = 1.4;
                         }
												 
						 CGRect newFrame = CGRectMake(imageview.frame.origin.x + widthdiff, newY, imageview.frame.size.width , imageview.frame.size.height * sizeMult);
						 imageview.frame = newFrame;
					 }
					 completion:^(BOOL finished){ [self swapViews:imageview]; }];
}
-(void)slideLeft:(UIImageView *)imageview
{
	[UIView animateWithDuration:slideDuration
						  delay:0
						options:UIViewAnimationCurveEaseOut
					 animations:^{
						 float newY;
						 float sizeMult = 1;
						 if (imageview.image.size.height > imageview.image.size.width) {
							 newY = imageview.frame.origin.y - heightdiff;
						 }
						 else {
							 newY = imageview.frame.origin.y + (heightdiff / 2);
                             if (arc4random() % 3 == 0) {
                                 sizeMult = 1.4;
                             }
						 }
						 
						 

						 
						 CGRect newFrame = CGRectMake(imageview.frame.origin.x - widthdiff, newY, imageview.frame.size.width , imageview.frame.size.height * sizeMult);
						 imageview.frame = newFrame;
					 }
					 completion:^(BOOL finished){ [self swapViews:imageview]; }];
}



-(void)swapViews:(UIImageView *)currentView
{
	currentIndex++;
	if (currentIndex == [imageList count]) {
		currentIndex = 0;
		[self beginRender];
		return;
	}
	
	UIImageView *nextView;
	if (currentIndex % 2) {
		nextView = two;
	}
	else {
		nextView = one;
	}
	nextView.alpha = 1.0;
	[nextView setImage:[imageList objectAtIndex:currentIndex]];
	[self insertSubview:nextView belowSubview:currentView];
	
	if (! paused) {
        if ([self.dataSource respondsToSelector:@selector(indexChangedTo:)]) {
            [dataSource indexChangedTo:currentIndex];
        }
		[self fadeOut:currentView toView:nextView];	
	} 
	else {
		pausedViewOne = currentView;
		pausedViewTwo = nextView;
	}

}

-(void)pause
{
	paused = YES;
}

-(void)resume
{

    
	paused = NO;
    if ([self.dataSource respondsToSelector:@selector(indexChangedTo:)]) {
        [dataSource indexChangedTo:currentIndex];
    }
	[self fadeOut:pausedViewOne toView:pausedViewTwo];

}
-(void)reset
{
	currentIndex = -1;
}


- (id)initWithFrame:(CGRect)frame {
    (self = [super initWithFrame:frame]);
    return self;
}


-(void)start
{
	CGRect myFrame = self.frame;
	bigwidth = myFrame.size.width * 1.6;
	bigheight = myFrame.size.height * 1.2;
    
    if ([dataSource respondsToSelector:@selector(setImageSize:)]) {
        [dataSource setImageSize:CGSizeMake(bigwidth, bigheight)];
    }
	
	imageList = [dataSource imagesForSlideshow:self];
	[self beginRender];
}



+ (void)_keepAtLinkTime
{}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code

}
*/




@end
