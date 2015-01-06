//
//  ArenaAlert.m
//  Arena_iPhone
//
//  Created by Ian Johnstone on 10-09-02.
//  Copyright 2010 Seven Mile Software. All rights reserved.
//

#import "ArenaAlert.h"
#import "Arena_iPhoneViewController.h"

@implementation ArenaAlert

-(id)initWithFrame:(CGRect)frame
{
	id ret = [super initWithFrame:frame];
	[self setBackgroundColor:[UIColor whiteColor]];
	return ret;
}
-(void) addRestartButton
{
	restartButton = [[UILabel alloc] initWithFrame:CGRectMake(40, 40, 120, 40)];
	[restartButton setText:@"Restart?"];
	[restartButton setBackgroundColor:[UIColor greenColor]];
	[self addSubview:restartButton];
}

-(void) addQuitButton
{
	quitButton = [[UILabel alloc] initWithFrame:CGRectMake(40, 80, 120, 40)];
	[quitButton setText:@"Quit?"];
	[quitButton setBackgroundColor:[UIColor redColor]];
	[self addSubview:quitButton];
}

-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
}

- (void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
}

- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
	CGPoint pt = [[touches anyObject] locationInView:self];
	CGRect touchRect = CGRectMake(pt.x, pt.y, 1.0f, 1.0f);
	if (CGRectIntersectsRect(touchRect, [restartButton frame]))
	{
		[restartButton setBackgroundColor:[UIColor grayColor]];
		[Arena_iPhoneViewController restart];
		[[Arena_iPhoneViewController getTheInstance] restarted:YES];
		[self removeFromSuperview];
		[self release];
	}
	else if (CGRectIntersectsRect(touchRect, [quitButton frame]))
	{
		[quitButton setBackgroundColor:[UIColor grayColor]];
	}
}	


-(void) dealloc
{
	[super dealloc];
	[restartButton release];
	[quitButton release];
}
@end
