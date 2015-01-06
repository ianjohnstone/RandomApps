//
//  Arena_iPhoneViewController.h
//  Arena_iPhone
//
//  Created by Ian Johnstone on 10-08-17.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TouchImage.h"
#import "PlayerSprite.h"
#import "TurnAndAttack.h"
#import "EnemySprite.h"
#import "ItemActivator.h"
#import "ItemView.h"
#import "ArenaAlert.h"
#import "Obstacle.h"

@interface Arena_iPhoneViewController : UIViewController {

	IBOutlet UIImageView *arena_logo;
	IBOutlet TouchImage *leftTab;
	IBOutlet TurnAndAttack *rightTab;
	IBOutlet PlayerSprite *player;
	IBOutlet EnemySprite *testEnemy;
	IBOutlet UITextView *scoreBoard;
	IBOutlet ItemActivator *activator;
	IBOutlet ItemView *testItem;
	//IBOutlet ArenaAlert *deathMenu;
	IBOutlet Obstacle *testBlocker;
}

@property(nonatomic, retain) IBOutlet UIImageView *arena_logo;
@property(nonatomic, retain) IBOutlet TouchImage *leftTab;
@property(nonatomic, retain) IBOutlet TurnAndAttack *rightTab;
@property(nonatomic, retain) IBOutlet PlayerSprite *player;
@property(nonatomic, retain) IBOutlet EnemySprite *testEnemy;
@property(nonatomic, retain) IBOutlet UITextView *scoreBoard;
@property(nonatomic, retain) IBOutlet ItemActivator *activator;
@property(nonatomic, retain) IBOutlet ItemView *testItem;
//@property(nonatomic, retain) IBOutlet ArenaAlert *deathMenu;
@property(nonatomic, retain) IBOutlet Obstacle *testBlocker;

-(void) start;
-(void) dump;
-(void) spawnEnemy;
-(void) placeItem;
-(void) pickUpItem:(ItemView *) item;
-(void) setSubItem:(NSString *) itemName;
-(void) setScore: (int) score;
-(void) increaseScore;
-(void) playerDeath;
-(void) restarted: (BOOL) flag;
-(BOOL) checkLevelComplete;
+(void) enemySlain: (EnemySprite *) enemy;
+(Arena_iPhoneViewController *) getTheInstance;
+(void) setTheInstance: (Arena_iPhoneViewController *)newInstance;
+(void) restart;
@end

