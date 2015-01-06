//
//  EnemySprite.h
//  Arena_iPhone
//
//  Created by Ian Johnstone on 10-08-19.
//  Copyright 2010 Seven Mile Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PlayerSprite.h"

@interface EnemySprite : UIImageView {

	int direction;
	float speed;
	int distanceLeft;
	PlayerSprite *player;
	CGRect limit;
	int difficulty;
}

-(void) calculateNextAction;
-(void) randomMovement;
-(void) approachAndAttack;
-(void) setLimit:(CGRect) newLimit;
-(void) setDirectionAnimation:(int)newDirection;
-(void) setOrigin:(CGPoint)newOrigin;
-(void) drawMovement;
-(void)move:(int) x:(int) y;
-(BOOL)detectCollision:(CGRect)newFrame;
-(void)handleDamage;
-(void)startMoving;
-(void)pause;
-(int)getDifficulty;
-(void)setDifficulty:(int)newDiff;
+(EnemySprite *) spawnEnemy:(int) diff:(CGRect)newLimit;
@end
