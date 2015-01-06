//
//  ItemActivator.h
//  Arena_iPhone
//
//  Created by Ian Johnstone on 10-08-31.
//  Copyright 2010 Seven Mile Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "PlayerSprite.h"


@interface ItemActivator : UIImageView {
	
	PlayerSprite *target;
	int usages;
}
-(void) activate;
-(void) setTarget:(PlayerSprite*)aTarget;
@end
