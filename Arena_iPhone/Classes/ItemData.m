//
//  ItemData.m
//  Arena_iPhone
//
//  Created by Christopher Martell on 10-09-04.
//  Copyright 2010 Seven Mile Software. All rights reserved.
//

#import "ItemData.h"


@implementation ItemData

NSString *identifier;
NSInteger type;
NSString *viewSpriteName;
NSMutableArray *itemAnim;
NSInteger modifier;
NSInteger quantity;

- (id) init
{
	self = [super init];
	identifier = [[NSString alloc] init];
	identifier = @"";
	type = 0;
	viewSpriteName = [[NSString alloc] init];
	viewSpriteName = @"";
	itemAnim = [[NSMutableArray alloc] init];
	modifier = 0;
	quantity = 0;
	
	return self;
}

- (void) loadItem:(NSString *)itemName
{
	NSString *path = [[NSBundle mainBundle] pathForResource:@"ItemList" ofType:@"txt"];//ITEMFILELOC;
	NSError *error;
	NSString *stringFromFileAtPath = [[NSString alloc]
                                      initWithContentsOfFile:path
                                      encoding:NSUTF8StringEncoding
                                      error:&error];
	NSString *itemInfo = [NSString alloc];
	NSString *animFilePrefix = [NSString alloc];
	
	NSScanner *itemScanner = [[NSScanner alloc] initWithString:stringFromFileAtPath];
	[itemScanner scanUpToString:itemName intoString:&itemInfo]; 
	[itemScanner scanUpToString:@";" intoString:&itemInfo];
	
	NSArray *lines = [itemInfo componentsSeparatedByString:@"\r"];
	identifier = [lines objectAtIndex:0];
	type = [[lines objectAtIndex:1] integerValue];
	viewSpriteName = [lines objectAtIndex:2];
	animFilePrefix = [lines objectAtIndex:3];
	itemAnim = [self getAnimArray:animFilePrefix];
	modifier = [[lines objectAtIndex:4] integerValue];
	quantity = [[lines objectAtIndex:5] integerValue];
	
	//[path release];
	//	[error release];
	[stringFromFileAtPath release];
//	[itemInfo release];
	[animFilePrefix release];
	//[itemScanner release];
	//	[lines release];
	
}

- (NSMutableArray*) getAnimArray:(NSString *)prefix
{
	NSString *test = [[NSBundle mainBundle] resourcePath];
	NSString *path = [NSString alloc];
	path = ITEMFILELOC;
	NSError *error;
	NSArray *dir = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:test error:&error];
	NSArray *animArr = [dir filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:
														 [NSString stringWithFormat:@"SELF MATCHES '%@.*\\.png'", prefix]]];	
	
	NSMutableArray *anim = [[NSMutableArray alloc] initWithCapacity:[animArr count] * 2];
	
	// adjust repeatAnim to increase/decrease animation
	for (int repeatAnim = 0; repeatAnim < 2; repeatAnim++) {
		for (int animIndex = 0; animIndex < [animArr count]; animIndex++) {
			[anim addObject:[UIImage imageNamed:[animArr objectAtIndex:animIndex]]];
		}
	}
	
	//[path release];
//	[error release];
	//[dir release];
	//[animArr release];
	return anim;
}

- (NSString*) getIdentifier
{
	return identifier;
}

- (NSInteger) getType
{
	return type;
}

- (NSString*) getViewSpriteName
{
	return viewSpriteName;
}

- (NSMutableArray*) getItemAnim
{
	return itemAnim;
}

- (NSInteger) getModifier
{
	return modifier;
}

- (NSInteger) getQuantity
{
	return quantity;
}

- (void) dealloc
{
	[super dealloc];
	[identifier release];
	[viewSpriteName release];
	[itemAnim release];
}

@end



// set item data values
//[identifier retain];
//[itemScanner initWithString:itemInfo];
//	[itemScanner scanString:itemName intoString:&identifier];
//	[itemScanner scanInteger:&type];
//	[aScanner scanUpToCharactersInSet:[NSCharacterSet letterCharacterSet] intoString:NULL]
//	[itemScanner scanString:@"*.png" intoString:&viewSpriteName];
//	[itemScanner scanString:@"*.png" intoString:&animFilePrefix];
//	[itemScanner scanInteger:&modifier];
//	[itemScanner scanInteger:&quantity];
