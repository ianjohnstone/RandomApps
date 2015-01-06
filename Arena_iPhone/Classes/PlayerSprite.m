//
//  PlayerSprite.m
//  Arena_iPhone
//
//  Created by Ian Johnstone on 10-08-18.
//  Copyright 2010 Seven Mile Software. All rights reserved.
//

#import "PlayerSprite.h"
#import "EnemySprite.h"
#import "Arena_iPhoneViewController.h"

@implementation PlayerSprite

/*
 NSMutableArray faceSouth;
 NSMutableArray faceNorth;
 NSMutableArray faceWest;
 NSMutableArray faceEast;
 */

#define SOUTH 7
#define NORTH 2
#define WEST 4
#define EAST 5

#define SPRITESIZE 24
 
NSDate *lastHit;
BOOL attacking = NO;

-(id) initWithFrame:(CGRect)frame
{
	id ret = [super initWithFrame:frame];
	[self setDirectionAnimation:SOUTH];
	maxHealth = 3;
	currentHealth = 2;
	[self drawHealth];
	NSDate * now = [[NSDate alloc] init];
	lastHit = now;
	[lastHit retain];
	[now release];
	
	// itemdata
	weapon = [[ItemData alloc] init];
	[weapon loadItem:@"[2]"];
	subItem = [[ItemData alloc] init];
	[subItem loadItem:@"[4]"];
	
	[weapon retain];
	[subItem retain];
	return ret;
}

-(ItemData*) getSubItem
{
	return subItem;
}

-(void) setDirectionAnimation:(int)newDirection
{
	direction = newDirection;
	NSMutableArray *aniArray;
	[self stopAnimating];
	aniArray = [NSMutableArray arrayWithCapacity:20];
	switch (newDirection) {
		case SOUTH:
			[aniArray addObject:[UIImage imageNamed:@"ScotsmanDown1.png"]];
			[aniArray addObject:[UIImage imageNamed:@"ScotsmanDown1.png"]];
			[aniArray addObject:[UIImage imageNamed:@"ScotsmanDown1.png"]];
			[aniArray addObject:[UIImage imageNamed:@"ScotsmanDown1.png"]];
			[aniArray addObject:[UIImage imageNamed:@"ScotsmanDown1.png"]];
			[aniArray addObject:[UIImage imageNamed:@"ScotsmanDown1.png"]];
			[aniArray addObject:[UIImage imageNamed:@"ScotsmanDown1.png"]];
			[aniArray addObject:[UIImage imageNamed:@"ScotsmanDown1.png"]];
			[aniArray addObject:[UIImage imageNamed:@"ScotsmanDown1.png"]];
			[aniArray addObject:[UIImage imageNamed:@"ScotsmanDown2.png"]];
			[aniArray addObject:[UIImage imageNamed:@"ScotsmanDown2.png"]];
			[aniArray addObject:[UIImage imageNamed:@"ScotsmanDown2.png"]];
			[aniArray addObject:[UIImage imageNamed:@"ScotsmanDown2.png"]];
			[aniArray addObject:[UIImage imageNamed:@"ScotsmanDown2.png"]];
			[aniArray addObject:[UIImage imageNamed:@"ScotsmanDown2.png"]];
			[aniArray addObject:[UIImage imageNamed:@"ScotsmanDown2.png"]];
			[aniArray addObject:[UIImage imageNamed:@"ScotsmanDown2.png"]];
			[aniArray addObject:[UIImage imageNamed:@"ScotsmanDown2.png"]];
			[aniArray addObject:[UIImage imageNamed:@"ScotsmanDown2.png"]];
			break;
		case NORTH:
			[aniArray addObject:[UIImage imageNamed:@"ScotsmanUp1.png"]];
			[aniArray addObject:[UIImage imageNamed:@"ScotsmanUp1.png"]];
			[aniArray addObject:[UIImage imageNamed:@"ScotsmanUp1.png"]];
			[aniArray addObject:[UIImage imageNamed:@"ScotsmanUp1.png"]];
			[aniArray addObject:[UIImage imageNamed:@"ScotsmanUp1.png"]];
			[aniArray addObject:[UIImage imageNamed:@"ScotsmanUp1.png"]];
			[aniArray addObject:[UIImage imageNamed:@"ScotsmanUp1.png"]];
			[aniArray addObject:[UIImage imageNamed:@"ScotsmanUp1.png"]];
			[aniArray addObject:[UIImage imageNamed:@"ScotsmanUp1.png"]];
			[aniArray addObject:[UIImage imageNamed:@"ScotsmanUp2.png"]];
			[aniArray addObject:[UIImage imageNamed:@"ScotsmanUp2.png"]];
			[aniArray addObject:[UIImage imageNamed:@"ScotsmanUp2.png"]];
			[aniArray addObject:[UIImage imageNamed:@"ScotsmanUp2.png"]];
			[aniArray addObject:[UIImage imageNamed:@"ScotsmanUp2.png"]];
			[aniArray addObject:[UIImage imageNamed:@"ScotsmanUp2.png"]];
			[aniArray addObject:[UIImage imageNamed:@"ScotsmanUp2.png"]];
			[aniArray addObject:[UIImage imageNamed:@"ScotsmanUp2.png"]];
			[aniArray addObject:[UIImage imageNamed:@"ScotsmanUp2.png"]];
			[aniArray addObject:[UIImage imageNamed:@"ScotsmanUp2.png"]];
			break;
		case WEST:
			[aniArray addObject:[UIImage imageNamed:@"ScotsmanLeft1.png"]];
			[aniArray addObject:[UIImage imageNamed:@"ScotsmanLeft1.png"]];
			[aniArray addObject:[UIImage imageNamed:@"ScotsmanLeft1.png"]];
			[aniArray addObject:[UIImage imageNamed:@"ScotsmanLeft1.png"]];
			[aniArray addObject:[UIImage imageNamed:@"ScotsmanLeft1.png"]];
			[aniArray addObject:[UIImage imageNamed:@"ScotsmanLeft1.png"]];
			[aniArray addObject:[UIImage imageNamed:@"ScotsmanLeft1.png"]];
			[aniArray addObject:[UIImage imageNamed:@"ScotsmanLeft1.png"]];
			[aniArray addObject:[UIImage imageNamed:@"ScotsmanLeft1.png"]];
			[aniArray addObject:[UIImage imageNamed:@"ScotsmanLeft2.png"]];
			[aniArray addObject:[UIImage imageNamed:@"ScotsmanLeft2.png"]];
			[aniArray addObject:[UIImage imageNamed:@"ScotsmanLeft2.png"]];
			[aniArray addObject:[UIImage imageNamed:@"ScotsmanLeft2.png"]];
			[aniArray addObject:[UIImage imageNamed:@"ScotsmanLeft2.png"]];
			[aniArray addObject:[UIImage imageNamed:@"ScotsmanLeft2.png"]];
			[aniArray addObject:[UIImage imageNamed:@"ScotsmanLeft2.png"]];
			[aniArray addObject:[UIImage imageNamed:@"ScotsmanLeft2.png"]];
			[aniArray addObject:[UIImage imageNamed:@"ScotsmanLeft2.png"]];
			[aniArray addObject:[UIImage imageNamed:@"ScotsmanLeft2.png"]];		
			break;
		case EAST:
			[aniArray addObject:[UIImage imageNamed:@"ScotsmanRight1.png"]];
			[aniArray addObject:[UIImage imageNamed:@"ScotsmanRight1.png"]];
			[aniArray addObject:[UIImage imageNamed:@"ScotsmanRight1.png"]];
			[aniArray addObject:[UIImage imageNamed:@"ScotsmanRight1.png"]];
			[aniArray addObject:[UIImage imageNamed:@"ScotsmanRight1.png"]];
			[aniArray addObject:[UIImage imageNamed:@"ScotsmanRight1.png"]];
			[aniArray addObject:[UIImage imageNamed:@"ScotsmanRight1.png"]];
			[aniArray addObject:[UIImage imageNamed:@"ScotsmanRight1.png"]];
			[aniArray addObject:[UIImage imageNamed:@"ScotsmanRight1.png"]];
			[aniArray addObject:[UIImage imageNamed:@"ScotsmanRight2.png"]];
			[aniArray addObject:[UIImage imageNamed:@"ScotsmanRight2.png"]];
			[aniArray addObject:[UIImage imageNamed:@"ScotsmanRight2.png"]];
			[aniArray addObject:[UIImage imageNamed:@"ScotsmanRight2.png"]];
			[aniArray addObject:[UIImage imageNamed:@"ScotsmanRight2.png"]];
			[aniArray addObject:[UIImage imageNamed:@"ScotsmanRight2.png"]];
			[aniArray addObject:[UIImage imageNamed:@"ScotsmanRight2.png"]];
			[aniArray addObject:[UIImage imageNamed:@"ScotsmanRight2.png"]];
			[aniArray addObject:[UIImage imageNamed:@"ScotsmanRight2.png"]];
			[aniArray addObject:[UIImage imageNamed:@"ScotsmanRight2.png"]];				
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

-(void) attack
{
	
	CGRect attackTarget = CGRectMake(0,0, 0, 0);
	CGRect selfFrame = [self frame];
	
	switch (direction) {
		case NORTH:
			attackTarget = CGRectMake(selfFrame.origin.x, selfFrame.origin.y - selfFrame.size.height, selfFrame.size.width, selfFrame.size.height);
			break;
		case SOUTH:
			attackTarget = CGRectMake(selfFrame.origin.x, (selfFrame.origin.y + (selfFrame.size.height + SPRITESIZE)), selfFrame.size.width, selfFrame.size.height);
			break;
		case WEST:
			attackTarget = CGRectMake(selfFrame.origin.x - selfFrame.size.width, selfFrame.origin.y, selfFrame.size.width, selfFrame.size.height);
			break;
		case EAST:
			attackTarget = CGRectMake(selfFrame.origin.x + selfFrame.size.width, selfFrame.origin.y, selfFrame.size.width, selfFrame.size.height);
			break;
		default:
			break;
	}
	
	if (!attacking) 
	{
		attacking = YES;
		[self createAndRunAttackAnimation:attackTarget];
	
		UIView *parent = [self superview];
		NSArray *views = [parent subviews];
		EnemySprite *hitEnemy;
	
		for (UIView *object in views)
		{
			CGRect rect = [object frame];
		
			if (CGSizeEqualToSize(attackTarget.size, rect.size) && !CGRectEqualToRect(selfFrame, rect) &&
				CGRectIntersectsRect(attackTarget, rect))
			{
				if ([object isKindOfClass:[EnemySprite class]])
				{
					hitEnemy = (EnemySprite *)object;
					[hitEnemy handleDamage];
					break;
				}
			}
		}
	
	}
	return;
}

-(void)createAndRunAttackAnimation:(CGRect) targettedArea
{
	UIImageView *animation = [[UIImageView alloc] initWithFrame:targettedArea];
	
	NSMutableArray *aniArray;
	aniArray = [weapon getItemAnim];//[NSMutableArray arrayWithCapacity:20];

	//[aniArray addObject:[UIImage imageNamed:@"Attack1.png"]];
//	[aniArray addObject:[UIImage imageNamed:@"Attack2.png"]];
//	[aniArray addObject:[UIImage imageNamed:@"Attack3.png"]];
//	[aniArray addObject:[UIImage imageNamed:@"Attack4.png"]];
//	[aniArray addObject:[UIImage imageNamed:@"Attack5.png"]];
//	[aniArray addObject:[UIImage imageNamed:@"Attack6.png"]];
//	[aniArray addObject:[UIImage imageNamed:@"Attack7.png"]];
//	[aniArray addObject:[UIImage imageNamed:@"Attack1.png"]];
//	[aniArray addObject:[UIImage imageNamed:@"Attack2.png"]];
//	[aniArray addObject:[UIImage imageNamed:@"Attack3.png"]];
//	[aniArray addObject:[UIImage imageNamed:@"Attack4.png"]];
//	[aniArray addObject:[UIImage imageNamed:@"Attack5.png"]];
//	[aniArray addObject:[UIImage imageNamed:@"Attack6.png"]];
//	[aniArray addObject:[UIImage imageNamed:@"Attack7.png"]];
	
	[animation setAnimationImages:aniArray];
	[animation setAnimationRepeatCount:2];
	[animation startAnimating];
	
	[[self superview] addSubview:animation];
	attacking = NO;
	
}

-(void) handleDamage
{
	NSDate *now = [[NSDate alloc] init];
	
	double diff = fabs([now timeIntervalSinceDate:lastHit]);
	
	if (diff > 5)
	{
		currentHealth = currentHealth - 1;
		if (currentHealth < 0)
			currentHealth = 0;
		[self drawHealth];
		lastHit = now;
		[lastHit retain];
		if (currentHealth == 0)
			[[Arena_iPhoneViewController getTheInstance] playerDeath];
	}
	[now release];

}

-(void) handleHealing: (NSInteger) health
{
	currentHealth = currentHealth + health;
	if (currentHealth > maxHealth)
	{
		currentHealth = maxHealth;
	}
	[self drawHealth];
}

-(void) drawHealth
{
	int i = 0;
	CGRect frame = [self frame];
	for (i = 0; i < maxHealth; i++) 
	{
		UIImageView *healthMarker = [[UIImageView alloc] initWithFrame:CGRectMake(0, 25 + i * frame.size.height, frame.size.width, frame.size.height)];
		if ( i + 1 > currentHealth)
			[healthMarker setImage:[UIImage imageNamed:@"HealthEmpty.png"]];
		else
			[healthMarker setImage:[UIImage imageNamed:@"HealthFull.png"]];
		[[self superview] addSubview:healthMarker];
	}
}

- (void)dealloc {
    [super dealloc];
	[lastHit release];
	[weapon release];
	//[subItem release];
}

@end
