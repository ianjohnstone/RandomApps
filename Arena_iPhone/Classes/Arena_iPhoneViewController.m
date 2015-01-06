//
//  Arena_iPhoneViewController.m
//  Arena_iPhone
//
//  Created by Ian Johnstone on 10-08-17.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import "Arena_iPhoneViewController.h"
#import "TouchImage.h"
#import "PlayerSprite.h"
#import "TurnAndAttack.h"
#import "EnemySprite.h"
#import "ItemActivator.h"
#import "ArenaAlert.h"
#import "ItemData.h"
#import "Obstacle.h"
#import "Level.h"

@implementation Arena_iPhoneViewController
@synthesize arena_logo, leftTab, rightTab, scoreBoard;

static Arena_iPhoneViewController *theInstance;

/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/

#define SPRITESIZE CGRectMake(0.0f,0.0f,24.0f,24.0f)

int currentScore;
CGRect limit;
BOOL starting = YES;
CGRect screenSize;
BOOL restartFlag = NO;
Level *activeLevel;

CGPoint randomPoint() {
	return CGPointMake(random() % 396, random() % 256);
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	screenSize = [self.view frame];
	[self start];
	[NSTimer scheduledTimerWithTimeInterval:0.0075 target:self selector:@selector(gameLoop) userInfo:nil repeats:YES];

	[Arena_iPhoneViewController setTheInstance:self];
}

-(void) start
{
	currentScore = 0;
	
	player = [[PlayerSprite alloc] initWithFrame:SPRITESIZE];
	CGRect leftTabFrame = CGRectMake(0.0f, screenSize.size.width-115, 100.0f, 100.0f);
	leftTab = [[TouchImage alloc] initWithFrame:leftTabFrame];
	[leftTab setImage:[UIImage imageNamed:@"LeftPad.png"]];
	[leftTab setUserInteractionEnabled:YES];
	[leftTab setMoveTarget:player];
	
	limit.origin.x = 100; limit.origin.y = 0;
	limit.size.width = screenSize.size.height - 95; limit.size.height = screenSize.size.width - 50;
	[leftTab setLimit:limit];
	
	CGRect rightTabFrame = CGRectMake(screenSize.size.height - 75, screenSize.size.width-115, 100.0f, 100.0f);
	rightTab = [[TurnAndAttack alloc] initWithFrame:rightTabFrame];
	[rightTab setImage:[UIImage imageNamed:@"RightPad.png"]];
	[rightTab setUserInteractionEnabled:YES];
	[rightTab setMoveTarget:player];
	limit.origin.x = 100; limit.origin.y = 60;
	limit.size.width = screenSize.size.height - 175; limit.size.height = screenSize.size.width - 100;
	[rightTab setLimit:limit];
	
	CGRect scoreBoardFrame = CGRectMake(screenSize.size.height - 75, screenSize.size.width / 4, 100, 30);
	scoreBoard = [[UITextView alloc] initWithFrame:scoreBoardFrame];
	[self.view addSubview:scoreBoard];
	[self setScore:currentScore];
	
	CGRect activatorFrame = CGRectMake(scoreBoardFrame.origin.x, scoreBoardFrame.origin.y + scoreBoardFrame.size.height, 100, 100);
	activator = [[ItemActivator alloc] initWithFrame:activatorFrame];
	//[activator setImage:[UIImage imageNamed:@"Potion.png"]];
	[activator setUserInteractionEnabled:YES];
	[self.view addSubview:activator];
	
	[self.view addSubview:player];
	[self.view addSubview:leftTab];
	[self.view addSubview:rightTab];
	
	[player drawHealth];

	[self placeItem];
	
/*	testBlocker = [[Obstacle alloc] initWithFrame:CGRectMake(200, 150, 24, 24)];
	[testBlocker setImage:[UIImage imageNamed:@"Blocker.png"]];
	[self.view addSubview:testBlocker];
	
	Obstacle *blocker2 = [[Obstacle alloc] initWithFrame:CGRectMake(150, 100, 24, 24)];
	[blocker2 setImage:[UIImage imageNamed:@"Blocker.png"]];
	[self.view addSubview:blocker2];
*/	
	activeLevel = [Level makeLevel:10:limit];
	
	NSArray *enemies = [activeLevel getEnemies];
	for (EnemySprite *enemy in enemies)
		[self.view addSubview:enemy];
	
	
	//	ItemData *test = [[ItemData alloc] init];
	//	[test loadItem:@"[2]"];
	
	//alertBase.userInteractionEnabled = YES;
	
}

-(void) dump
{
	[player removeFromSuperview];
	[leftTab removeFromSuperview];
	[rightTab removeFromSuperview];
	[testItem removeFromSuperview];
	[activator removeFromSuperview];
	[scoreBoard removeFromSuperview];
	//	[deathMenu removeFromSuperview]; 
	[player release];
	[leftTab release];
	[rightTab release];
	[testItem release];
	[testEnemy release];
	[activator release];
	[scoreBoard release];
	[activeLevel release];
//	[enemies release];
//	[deathMenu release];
}

-(void) spawnEnemy
{
	testEnemy =[[EnemySprite alloc] initWithFrame:SPRITESIZE];
	[testEnemy setLimit:limit];
	[testEnemy setOrigin:limit.origin];
	[testEnemy startMoving];
	[self.view addSubview:testEnemy];
}

-(void) placeItem
{
	ItemView *testItem2 = [[ItemView alloc] initWithFrame:SPRITESIZE];
	[testItem2 setImage:[UIImage imageNamed:@"Shield.png"]];
	[testItem2 setPosition:/*limit.origin.x + */limit.size.width - 24: limit.origin.y + 24];
	[self.view addSubview:testItem2];
	
	//testItem = [[ItemView alloc] initWithFrame:SPRITESIZE];
//	[testItem setImage:[UIImage imageNamed:@"Potion.png"]];
//	[testItem setPosition:/*limit.origin.x + */limit.size.width - 24: limit.origin.y];
//	[self.view addSubview:testItem];
}

-(void) pickUpItem:(ItemView *)item
{
	[activator setImage:[item image]];
	[item removeFromSuperview];
	[activator setTarget:player];
}

-(void) setSubItem:(NSString *)itemName
{
	ItemView *item = [[ItemView alloc] initWithFrame:SPRITESIZE];
	[item setImage:[UIImage imageNamed:itemName]];
	[item setPosition:/*limit.origin.x + */limit.size.width - 24: limit.origin.y];
	[self pickUpItem:item];
}

-(void) setScore:(int)score
{
	currentScore = score;
	scoreBoard.text = [NSString stringWithFormat:@"Kills: %d", score];
}

-(void) increaseScore
{
	[self setScore:currentScore + 1];
}

-(void)playerDeath
{
	ArenaAlert *deathMenu = [[ArenaAlert alloc] initWithFrame:limit];
	[deathMenu setUserInteractionEnabled:YES];
	[deathMenu addRestartButton];
	[self.view addSubview:deathMenu];
}

-(void)restarted:(BOOL)flag
{
	restartFlag = flag;
}

-(BOOL) checkLevelComplete
{
	if ([[activeLevel getEnemies] count] <= 0)
	{
		return YES;
	}
	return NO;
}
-(void) removeEnemy:(EnemySprite *)enemy
{
	[[activeLevel getEnemies] removeObject:enemy];
}

-(void) levelComplete
{
	int newDifficulty = [activeLevel getDifficulty] + 5;
	activeLevel = [Level makeLevel:newDifficulty :limit];
	NSArray *enemies = [activeLevel getEnemies];
	for (EnemySprite *enemy in enemies)
		[self.view addSubview:enemy];
}

+(void) enemySlain:(EnemySprite *)enemy
{
	//[[Arena_iPhoneViewController getTheInstance] removeEnemy:enemy];
	//[enemy pause];
	[enemy removeFromSuperview];
	[enemy release];
	[[Arena_iPhoneViewController getTheInstance] increaseScore];
	if ([[Arena_iPhoneViewController getTheInstance] checkLevelComplete])
	{
		[[Arena_iPhoneViewController getTheInstance] levelComplete];
	}
}

+(Arena_iPhoneViewController *)getTheInstance
{
	return theInstance;
}

+(void) setTheInstance:(Arena_iPhoneViewController *)newInstance
{
	theInstance = newInstance;
}

+(void) restart
{
	[theInstance dump];
	[theInstance start];
}

// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationLandscapeLeft || interfaceOrientation == UIInterfaceOrientationLandscapeRight);
}


- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
	[player release];
	[arena_logo release];
	[rightTab release];
	[leftTab release];
	[player release];
	[testEnemy release];
}

-(void)gameLoop {
	if (restartFlag)
	{
	}
}

@end
