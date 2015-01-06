//
//  PlayerSprite.h
//  Arena_iPhone
//
//  Created by Ian Johnstone on 10-08-18.
//  Copyright 2010 Seven Mile Sofware. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ItemData.h"


@interface PlayerSprite : UIImageView {
	int direction;
	int maxHealth;
	int currentHealth;
	ItemData *weapon;
	ItemData *subItem;
//	NSDate *lastHit;
}
-(void) setDirectionAnimation : (int) newDirection;
-(void) attack;
-(void) createAndRunAttackAnimation : (CGRect) targettedArea;
-(void) handleDamage;
-(void) handleHealing : (NSInteger) health;
-(void) drawHealth;
-(ItemData*) getSubItem;
//@property(nonatomic, retain) NSDate *lastHit;
@end
