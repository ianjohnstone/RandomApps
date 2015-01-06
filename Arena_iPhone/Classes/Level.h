//
//  Level.h
//  Arena_iPhone
//
//  Created by Ian Johnstone on 10-09-22.
//  Copyright 2010 Seven Mile Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EnemySprite.h"

@interface Level : NSObject {
	NSMutableArray *enemies;
	NSMutableArray *obstacles;
	
	int enemyCount;
	int obstacleCount;
	int difficulty;
	
	CGRect limits;
}
+(Level *) makeLevel: (int) difficulty: (CGRect) levelLimits;
-(void) setDifficulty: (int) newDiff;
-(void) setLimits: (CGRect) newLimits;
-(int)getDifficulty;
-(void) addEnemy:(EnemySprite *)enemy;
-(NSMutableArray*) getEnemies;
@end
