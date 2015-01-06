//
//  TouchImage.h
//  Arena_iPhone
//
//  Created by Ian Johnstone on 10-08-17.
//  Copyright 2010 Seven Mile Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface TouchImage : UIImageView {
	CGPoint startLocation;
	UIView *moveTarget;
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
	BOOL moving;
	int direction;
}
-(void)setMoveTarget:(UIView *)target;
-(void)setLimit:(CGRect)newLimit;
-(void)move:(int) x:(int) y;
-(BOOL) detectCollision:(CGRect)newFrame;
@end
