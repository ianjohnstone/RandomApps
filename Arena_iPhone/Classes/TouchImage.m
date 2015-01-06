//
//  TouchImage.m
//  Arena_iPhone
//
//  Created by Ian Johnstone on 10-08-17.
//  Copyright 2010 Seven Mile Software. All rights reserved.
//

#import "TouchImage.h"
#import "EnemySprite.h"
#import "Arena_iPhoneViewController.h"
#import "ItemView.h"
#import "Obstacle.h"

@implementation TouchImage

#define NORTHWEST 1;
#define NORTH 2;
#define NORTHEAST 3;
#define WEST 4;
#define EAST 5;
#define SOUTHWEST 6;
#define SOUTH 7;
#define SOUTHEAST 8;

#define DEADZONE 99;

BOOL timeMade = NO;


-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	CGPoint pt = [[touches anyObject] locationInView:self];
	CGRect touchRect = CGRectMake(pt.x, pt.y, 1.0f, 1.0f);
	if (CGRectIntersectsRect(touchRect, zoneA))
	{
		direction = NORTHWEST;
	}
	else if (CGRectIntersectsRect(touchRect, zoneB))
	{
		direction = NORTH;
	}
	else if (CGRectIntersectsRect(touchRect, zoneC))
	{
		direction = NORTHEAST;
	}
	else if (CGRectIntersectsRect(touchRect, zoneD))
	{
		direction = WEST;
	}
	else if (CGRectIntersectsRect(touchRect, zoneE))
	{
		direction = EAST;
	}
	else if (CGRectIntersectsRect(touchRect, zoneF))
	{
		direction = SOUTHWEST;
	}
	else if (CGRectIntersectsRect(touchRect, zoneG))
	{
		direction = SOUTH;
	}
	else if (CGRectIntersectsRect(touchRect, zoneH))
	{
		direction = SOUTHEAST;
	}
	else
	{
		direction = DEADZONE;
	}
										
							   
	moving = YES;
	startLocation = [moveTarget frame].origin;
	[[self superview] bringSubviewToFront:self];
//	stepHandler = [NSTimer alloc];
	if (timeMade == NO)
	{
		[NSTimer scheduledTimerWithTimeInterval:0.0075 target:self selector:@selector(handleMovement) userInfo:nil repeats:YES];
		timeMade = YES;
	}
}

- (void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
	CGPoint pt = [[touches anyObject] locationInView:self];
	CGRect touchRect = CGRectMake(pt.x, pt.y, 1.0f, 1.0f);
	if (CGRectIntersectsRect(touchRect, zoneA))
	{
		direction = NORTHWEST;
	}
	else if (CGRectIntersectsRect(touchRect, zoneB))
	{
		direction = NORTH;
	}
	else if (CGRectIntersectsRect(touchRect, zoneC))
	{
		direction = NORTHEAST;
	}
	else if (CGRectIntersectsRect(touchRect, zoneD))
	{
		direction = WEST;
	}
	else if (CGRectIntersectsRect(touchRect, zoneE))
	{
		direction = EAST;
	}
	else if (CGRectIntersectsRect(touchRect, zoneF))
	{
		direction = SOUTHWEST;
	}
	else if (CGRectIntersectsRect(touchRect, zoneG))
	{
		direction = SOUTH;
	}
	else if (CGRectIntersectsRect(touchRect, zoneH))
	{
		direction = SOUTHEAST;
	}
	else
	{
		direction = DEADZONE;
	}
	
}
- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
	direction = DEADZONE;
	moving = NO;
}

-(void) setMoveTarget:(UIView *)target
{
	moveTarget = target;
}

-(void) setLimit:(CGRect) newLimit
{
	limit = newLimit;
	int y =  0; //[self frame].origin.y;
	int w = [self frame].size.width;
	int h = [self frame].size.height;
	
	zoneA = CGRectMake(1.0f, 0.0f + y, w / 3, h / 3);
	zoneB = CGRectMake(w / 3, 0.0f + y, w / 3, h / 3);
	zoneC = CGRectMake(w * 2 / 3, 0.0f , w / 3, h / 3);
	zoneD = CGRectMake(1.0f, (h / 3), w / 3, h / 3);
	zoneE = CGRectMake(w * 2 / 3, (h / 3) + y, w / 3, h / 3);
	zoneF = CGRectMake(1.0f, (h * 2 / 3) + y, w / 3, h / 3);
	zoneG = CGRectMake(w / 3, (h * 2 / 3) + y, w / 3, h / 3);
	zoneH = CGRectMake(w * 2 / 3,(h * 2 / 3) + y, w / 3, h / 3);
	zoneZ = CGRectMake(w / 3, (h / 3) + y, w /  3, h / 3);
	
	moving = NO;
	timeMade = NO;
	direction = DEADZONE;
	
	CGRect moveTargetStart = CGRectMake(limit.size.width / 2, limit.size.height - moveTarget.frame.size.height * 2, moveTarget.frame.size.width, moveTarget.frame.size.height);
	[moveTarget setFrame:moveTargetStart];
}

-(void) handleMovement
{
	if (moving)
	{
		switch (direction) {
		case 1:
			[self move: -1: -1];
			break;
		case 2:
			[self move: 0: -1];
			break;
		case 3:
			[self move: 1: -1];
			break;
		case 4:
			[self move: -1: 0];
			break;
		case 5:
			[self move: 1: 0];
			break;
		case 6:
			[self move: -1: 1];
			break;
		case 7:
			[self move: 0: 1];
			break;
		case 8:
			[self move: 1: 1];
			break;
		default:
			break;
		}
	}
}
			 
-(void) move: (int) x: (int) y
{
	CGRect frame = [moveTarget frame];
	
	frame.origin.x += x;
	frame.origin.y += y;
	
	if (frame.origin.x < limit.origin.x)
		frame.origin.x = limit.origin.x;
	else if (frame.origin.x > limit.size.width)
		frame.origin.x = limit.size.width;
	
	if (frame.origin.y < limit.origin.y)
		frame.origin.y = limit.origin.y;
	else if (frame.origin.y > limit.size.height)
		frame.origin.y = limit.size.height;
	
	if (![self detectCollision:frame])
		[moveTarget setFrame:frame];
	
}

-(BOOL) detectCollision:(CGRect) newFrame
{
	UIView *parent = [self superview];
	NSArray *views = [parent subviews];
	
	CGRect selfFrame = [moveTarget frame];
	
	for (UIView *object in views)
	{
		CGRect rect = [object frame];
		
		if (CGSizeEqualToSize(newFrame.size, rect.size) && !CGRectEqualToRect(selfFrame, rect) &&
			!CGRectEqualToRect(newFrame, rect) && CGRectIntersectsRect(newFrame, rect))
		{
			if (![object isKindOfClass:[EnemySprite class]] && ![object isKindOfClass:[ItemView class]] && ![object isKindOfClass:[Obstacle class]])
			{
				[object removeFromSuperview];
				[object release];
				continue;
				//return NO;
			}
			else if ([object isKindOfClass:[ItemView class]])
			{
				[[Arena_iPhoneViewController getTheInstance] pickUpItem:(ItemView *) object];
			}
			return YES;
		}
	}
	return NO;
}



@end
