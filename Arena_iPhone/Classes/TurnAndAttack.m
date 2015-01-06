//
//  TurnAndAttack.m
//  Arena_iPhone
//
//  Created by Ian Johnstone on 10-08-18.
//  Copyright 2010 Seven Mile Software. All rights reserved.
//

#import "TurnAndAttack.h"


@implementation TurnAndAttack
#define NORTHWEST 1
#define NORTH 2
#define NORTHEAST 3
#define WEST 4
#define EAST 5
#define SOUTHWEST 6
#define SOUTH 7
#define SOUTHEAST 8

#define DEADZONE 99

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
	
	[[self superview] bringSubviewToFront:self];
	[self handleInput:direction];
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
	
	[[self superview] bringSubviewToFront:self];
	[self handleInput:direction];
}
- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
	direction = DEADZONE;
}

-(void) setMoveTarget:(PlayerSprite *)target
{
	moveTarget = target;
}

-(void) setLimit:(CGRect) newLimit
{
	limit = newLimit;
	int w = [self frame].size.width;
	int h = [self frame].size.height;
	
	zoneA = CGRectMake(1.0f, 0.0f , w / 3, h / 3);
	zoneB = CGRectMake(w / 3, 0.0f , w / 3, h / 3);
	zoneC = CGRectMake(w * 2 / 3, 0.0f , w / 3, h / 3);
	zoneD = CGRectMake(1.0f, (h / 3), w / 3, h / 3);
	zoneE = CGRectMake(w * 2 / 3, (h / 3), w / 3, h / 3);
	zoneF = CGRectMake(1.0f, (h * 2 / 3) , w / 3, h / 3);
	zoneG = CGRectMake(w / 3, (h * 2 / 3), w / 3, h / 3);
	zoneH = CGRectMake(w * 2 / 3,(h * 2 / 3), w / 3, h / 3);
	zoneZ = CGRectMake(w / 3, (h / 3), w /  3, h / 3);
	
	direction = DEADZONE;
}

-(void) handleInput:(int)command
{
	if (command == DEADZONE)
		[moveTarget attack];
	else {
		[moveTarget setDirectionAnimation:command];
	}

}

@end
