//
//  TurnAndAttack.h
//  Arena_iPhone
//
//  Created by Ian Johnstone on 10-08-18.
//  Copyright 2010 Seven Mile Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "PlayerSprite.h"

@interface TurnAndAttack : UIImageView {
	CGPoint startLocation;
	PlayerSprite *moveTarget;
	CGRect limit;
	
	CGRect zoneA;
	CGRect zoneB;
	CGRect zoneC;
	CGRect zoneD;
	CGRect zoneE;
	CGRect zoneF;
	CGRect zoneG;
	CGRect zoneH;
	CGRect zoneZ;
	int direction;
	
}

-(void) handleInput: (int) command;
-(void) setMoveTarget: (PlayerSprite *) target;
-(void) setLimit: (CGRect) newLimit;
@end
