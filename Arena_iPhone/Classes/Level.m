//
//  Level.m
//  Arena_iPhone
//
//  Created by Ian Johnstone on 10-09-22.
//  Copyright 2010 Seven Mile Software. All rights reserved.
//

#import "Level.h"
#import "EnemySprite.h"

@implementation Level

+(Level *) makeLevel: (int) difficulty: (CGRect) levelLimits
{
	Level *newLevel = [[Level alloc] init];
	[newLevel setDifficulty:difficulty];
	[newLevel setLimits:levelLimits];
	
	while (difficulty > 0) {
		EnemySprite *enemy = [EnemySprite spawnEnemy:difficulty:levelLimits];
		difficulty = difficulty - [enemy getDifficulty];
		
		[newLevel addEnemy:enemy];
	}
	
	return newLevel;
}

-(void) setDifficulty: (int) newDiff
{
	difficulty = newDiff;
}
-(void) setLimits:(CGRect)newLimits
{
	limits = newLimits;
}
-(int) getDifficulty
{
	return difficulty;
}

-(NSMutableArray *) getEnemies;
{
	return enemies;
}

-(void) addEnemy: (EnemySprite *) enemy
{
	[enemies release];
	NSMutableArray *newEnemies = [[NSMutableArray alloc] initWithCapacity:[enemies count] + 1];
	[newEnemies addObjectsFromArray:enemies];
	[newEnemies addObject:enemy];
	enemies = [[NSArray alloc] initWithArray:newEnemies];
	[enemies retain];
//	[newEnemies release];
}

-(void) dealloc
{
	[super dealloc];
	[enemies release];
	[obstacles release];
}
@end
