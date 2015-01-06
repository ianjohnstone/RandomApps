//
//  ItemData.h
//  Arena_iPhone
//
//  Created by Christopher Martell on 10-09-04.
//  Copyright 2010 Seven Mile Software. All rights reserved.
//

#import <Foundation/Foundation.h>

#define ITEMFILELOC @"Resources/ItemList.txt";
#define ANIMATIONDIR @"/Pictures/";
#define DELIM @";";

@interface ItemData : NSObject {
	//NSInteger type;
//	NSString *viewSpriteName;
//	NSMutableArray *itemAnim;
//	NSInteger modifier;
//	NSInteger quantity;
}

-(id) init;
-(void) loadItem:(NSString*) itemName;

// getter methods
-(NSString*) getIdentifier;
-(NSInteger) getType;
-(NSString*) getViewSpriteName;
-(NSMutableArray*) getItemAnim;
-(NSInteger) getModifier;
-(NSInteger) getQuantity;

-(NSMutableArray*) getAnimArray:(NSString*) prefix;

@end
