//
//  ItemActivator.m
//  Arena_iPhone
//
//  Created by Ian Johnstone on 10-08-31.
//  Copyright 2010 Seven Mile Software. All rights reserved.
//

#import "ItemActivator.h"
#import "Arena_iPhoneViewController.h"

@implementation ItemActivator

- (void) setTarget:(PlayerSprite *)aTarget
{
	target = aTarget;
}

- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
	ItemData *subItem = [target getSubItem];
	
	if ([subItem getType] == 1)			// item is restorative
	{
		[target handleHealing:[subItem getModifier]];
	}
	else if ([subItem getType] == 2)	// item is a weapon
	{
		[target attack];
	}
}

-(void)activate
{
	
}
@end
