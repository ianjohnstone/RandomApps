//
//  EnemySprite.m
//  Arena_iPhone
//
//  Created by Ian Johnstone on 10-08-19.
//  Copyright 2010 Seven Mile Software. All rights reserved.
//

#import "EnemySprite.h"
#import "PlayerSprite.h"
#import "Obstacle.h"
#import "Arena_iPhoneViewController.h"

#define SOUTH 7
#define NORTH 3
#define WEST 4
#define EAST 5

@implementation EnemySprite

BOOL nmeTimeMade = NO;
BOOL running = NO;

-(void) calculateNextAction
{
	int action = random() % 100;
	
	if (action > 50) {
		[self randomMovement];
	} else if (action > 30 && action <= 50) {
		[self approachAndAttack];
	}
}

-(void) randomMovement
{
	if (distanceLeft <= 0)
	{
		direction = random() % 8;
		distanceLeft = random() % 30;
	}
}

-(void) approachAndAttack
{
}

-(void) drawMovement
{
	if (distanceLeft > 0 && running)
	{
		switch (direction) {
			case SOUTH:
				[self setDirectionAnimation:SOUTH];
				[self move:0:1];
				break;
			case NORTH:
				[self setDirectionAnimation:NORTH];
				[self move:0:-1];
				break;
			case WEST:
				[self setDirectionAnimation:WEST];
				[self move:-1 :0];
				break;
			case EAST:
				[self setDirectionAnimation:EAST];
				[self move:1:0];
				break;
			default:
				break;
		}
		distanceLeft--;
	}
}

-(void) setLimit:(CGRect) newLimit
{
	limit = newLimit;
	direction = SOUTH;
	[self setDirectionAnimation:direction];
	running = YES;
	if (nmeTimeMade == NO)
	{
		[NSTimer scheduledTimerWithTimeInterval:0.0075 target:self selector:@selector(calculateNextAction) userInfo:nil repeats:YES];
		[NSTimer scheduledTimerWithTimeInterval:0.0075 target:self selector:@selector(drawMovement) userInfo:nil repeats:YES];
		nmeTimeMade = YES;
	}
	

}
-(void) setDirectionAnimation:(int)newDirection
{
	direction = newDirection;
	NSMutableArray *aniArray;
	[self stopAnimating];
	aniArray = [NSMutableArray arrayWithCapacity:20];
	switch (newDirection) {
		case SOUTH:
			[aniArray addObject:[UIImage imageNamed:@"PrisonerDown1.png"]];
			[aniArray addObject:[UIImage imageNamed:@"PrisonerDown1.png"]];
			[aniArray addObject:[UIImage imageNamed:@"PrisonerDown1.png"]];
			[aniArray addObject:[UIImage imageNamed:@"PrisonerDown1.png"]];
			[aniArray addObject:[UIImage imageNamed:@"PrisonerDown1.png"]];
			[aniArray addObject:[UIImage imageNamed:@"PrisonerDown1.png"]];
			[aniArray addObject:[UIImage imageNamed:@"PrisonerDown1.png"]];
			[aniArray addObject:[UIImage imageNamed:@"PrisonerDown1.png"]];
			[aniArray addObject:[UIImage imageNamed:@"PrisonerDown1.png"]];
			[aniArray addObject:[UIImage imageNamed:@"PrisonerDown2.png"]];
			[aniArray addObject:[UIImage imageNamed:@"PrisonerDown2.png"]];
			[aniArray addObject:[UIImage imageNamed:@"PrisonerDown2.png"]];
			[aniArray addObject:[UIImage imageNamed:@"PrisonerDown2.png"]];
			[aniArray addObject:[UIImage imageNamed:@"PrisonerDown2.png"]];
			[aniArray addObject:[UIImage imageNamed:@"PrisonerDown2.png"]];
			[aniArray addObject:[UIImage imageNamed:@"PrisonerDown2.png"]];
			[aniArray addObject:[UIImage imageNamed:@"PrisonerDown2.png"]];
			[aniArray addObject:[UIImage imageNamed:@"PrisonerDown2.png"]];
			[aniArray addObject:[UIImage imageNamed:@"PrisonerDown2.png"]];
			break;
		case NORTH:
			[aniArray addObject:[UIImage imageNamed:@"PrisonerUp1.png"]];
			[aniArray addObject:[UIImage imageNamed:@"PrisonerUp1.png"]];
			[aniArray addObject:[UIImage imageNamed:@"PrisonerUp1.png"]];
			[aniArray addObject:[UIImage imageNamed:@"PrisonerUp1.png"]];
			[aniArray addObject:[UIImage imageNamed:@"PrisonerUp1.png"]];
			[aniArray addObject:[UIImage imageNamed:@"PrisonerUp1.png"]];
			[aniArray addObject:[UIImage imageNamed:@"PrisonerUp1.png"]];
			[aniArray addObject:[UIImage imageNamed:@"PrisonerUp1.png"]];
			[aniArray addObject:[UIImage imageNamed:@"PrisonerUp1.png"]];
			[aniArray addObject:[UIImage imageNamed:@"PrisonerUp2.png"]];
			[aniArray addObject:[UIImage imageNamed:@"PrisonerUp2.png"]];
			[aniArray addObject:[UIImage imageNamed:@"PrisonerUp2.png"]];
			[aniArray addObject:[UIImage imageNamed:@"PrisonerUp2.png"]];
			[aniArray addObject:[UIImage imageNamed:@"PrisonerUp2.png"]];
			[aniArray addObject:[UIImage imageNamed:@"PrisonerUp2.png"]];
			[aniArray addObject:[UIImage imageNamed:@"PrisonerUp2.png"]];
			[aniArray addObject:[UIImage imageNamed:@"PrisonerUp2.png"]];
			[aniArray addObject:[UIImage imageNamed:@"PrisonerUp2.png"]];
			[aniArray addObject:[UIImage imageNamed:@"PrisonerUp2.png"]];
			break;
		case WEST:
			[aniArray addObject:[UIImage imageNamed:@"PrisonerLeft1.png"]];
			[aniArray addObject:[UIImage imageNamed:@"PrisonerLeft1.png"]];
			[aniArray addObject:[UIImage imageNamed:@"PrisonerLeft1.png"]];
			[aniArray addObject:[UIImage imageNamed:@"PrisonerLeft1.png"]];
			[aniArray addObject:[UIImage imageNamed:@"PrisonerLeft1.png"]];
			[aniArray addObject:[UIImage imageNamed:@"PrisonerLeft1.png"]];
			[aniArray addObject:[UIImage imageNamed:@"PrisonerLeft1.png"]];
			[aniArray addObject:[UIImage imageNamed:@"PrisonerLeft1.png"]];
			[aniArray addObject:[UIImage imageNamed:@"PrisonerLeft1.png"]];
			[aniArray addObject:[UIImage imageNamed:@"PrisonerLeft2.png"]];
			[aniArray addObject:[UIImage imageNamed:@"PrisonerLeft2.png"]];
			[aniArray addObject:[UIImage imageNamed:@"PrisonerLeft2.png"]];
			[aniArray addObject:[UIImage imageNamed:@"PrisonerLeft2.png"]];
			[aniArray addObject:[UIImage imageNamed:@"PrisonerLeft2.png"]];
			[aniArray addObject:[UIImage imageNamed:@"PrisonerLeft2.png"]];
			[aniArray addObject:[UIImage imageNamed:@"PrisonerLeft2.png"]];
			[aniArray addObject:[UIImage imageNamed:@"PrisonerLeft2.png"]];
			[aniArray addObject:[UIImage imageNamed:@"PrisonerLeft2.png"]];
			[aniArray addObject:[UIImage imageNamed:@"PrisonerLeft2.png"]];		
			break;
		case EAST:
			[aniArray addObject:[UIImage imageNamed:@"PrisonerRight1.png"]];
			[aniArray addObject:[UIImage imageNamed:@"PrisonerRight1.png"]];
			[aniArray addObject:[UIImage imageNamed:@"PrisonerRight1.png"]];
			[aniArray addObject:[UIImage imageNamed:@"PrisonerRight1.png"]];
			[aniArray addObject:[UIImage imageNamed:@"PrisonerRight1.png"]];
			[aniArray addObject:[UIImage imageNamed:@"PrisonerRight1.png"]];
			[aniArray addObject:[UIImage imageNamed:@"PrisonerRight1.png"]];
			[aniArray addObject:[UIImage imageNamed:@"PrisonerRight1.png"]];
			[aniArray addObject:[UIImage imageNamed:@"PrisonerRight1.png"]];
			[aniArray addObject:[UIImage imageNamed:@"PrisonerRight2.png"]];
			[aniArray addObject:[UIImage imageNamed:@"PrisonerRight2.png"]];
			[aniArray addObject:[UIImage imageNamed:@"PrisonerRight2.png"]];
			[aniArray addObject:[UIImage imageNamed:@"PrisonerRight2.png"]];
			[aniArray addObject:[UIImage imageNamed:@"PrisonerRight2.png"]];
			[aniArray addObject:[UIImage imageNamed:@"PrisonerRight2.png"]];
			[aniArray addObject:[UIImage imageNamed:@"PrisonerRight2.png"]];
			[aniArray addObject:[UIImage imageNamed:@"PrisonerRight2.png"]];
			[aniArray addObject:[UIImage imageNamed:@"PrisonerRight2.png"]];
			[aniArray addObject:[UIImage imageNamed:@"PrisonerRight2.png"]];				
			break;
		default:
			[self startAnimating];
			return;
			break;
	}
	
	[self setAnimationImages:aniArray];
	[self startAnimating];
	
	//[aniArray release];
}

-(void) setOrigin:(CGPoint)newOrigin
{
	CGRect frame = [self frame];
	frame.origin = newOrigin;
	[self setFrame:frame];
}
				 
-(void) move: (int) x: (int) y
{
	CGRect frame = [self frame];
			
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
	{
		[self setFrame:frame];
	}
	else {
		distanceLeft = 0;
	}

}
				 
-(BOOL) detectCollision:(CGRect)newFrame
{
	UIView *parent = [self superview];
	NSArray *views = [parent subviews];
	
	for (UIView *object in views)
	{
		CGRect rect = [object frame];
		
		if (CGSizeEqualToSize(newFrame.size, rect.size) && !CGRectEqualToRect(newFrame, rect) &&
			!CGRectEqualToRect([self frame], rect)&& CGRectIntersectsRect(newFrame, rect))
		{
			if ([object isKindOfClass:[PlayerSprite class]])
			{
				[object handleDamage];
				return YES;
			}
			else if ([object isKindOfClass:[EnemySprite class]] || [object isKindOfClass:[Obstacle class]])
			{
				return YES;
			}
		}
	}
	return NO;
}

-(void)handleDamage
{
	[Arena_iPhoneViewController enemySlain:self];
	return;
}

-(void)startMoving
{
	nmeTimeMade = NO;
}

-(void) pause
{
	running = NO;
}
+(EnemySprite *) spawnEnemy:(int)diff:(CGRect)newLimit
{
	int x = (random()%200) + newLimit.origin.x;
	int y = (random()%240) + newLimit.origin.y;
	
	CGRect potLoc = CGRectMake(x, y, 24, 24);
	
	NSArray *views = [[[Arena_iPhoneViewController getTheInstance] view] subviews];
	BOOL conflict = NO;
	do
	{
		for (UIView* view in views)
		{
			CGRect viewRect = [view frame];
			if (CGRectIntersectsRect(potLoc, viewRect))
			{
				if ([view isKindOfClass:[EnemySprite class]] || [view isKindOfClass:[PlayerSprite class]] || [view isKindOfClass:[Obstacle class]])
				{
					conflict = YES;
					x = (random()%200) + newLimit.origin.x;
					y = (random()%240) + newLimit.origin.y;
					potLoc = CGRectMake(x, y, 24, 24);
					break;
				}
																											 
			}
			/*else
				conflict = NO;
		*/}
	} while (conflict == YES);
	
	EnemySprite *spawn = [[EnemySprite alloc] initWithFrame:potLoc];
	[spawn setDifficulty:5];
	[spawn setLimit:newLimit];
	[spawn startMoving];
	return spawn;
}
-(int)getDifficulty
{
	return difficulty;
}
-(void) setDifficulty: (int) newDiff
{
	difficulty = newDiff;
}

-(void) dealloc
{
	[super dealloc];
}
@end
