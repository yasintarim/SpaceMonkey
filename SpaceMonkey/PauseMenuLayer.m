//
//  PauseMenuLayer.m
//  SpaceMonkey
//
//  Created by Yasin Tarim on 7/3/11.
//  Copyright 2011 YKB. All rights reserved.
//

#import "PauseMenuLayer.h"

@implementation PauseMenuLayer

-(id)init
{
	return [self initWithColor:ccc4(155, 155, 65, 125) width:200 height:200];
}

-(id)initWithColor:(ccColor4B)color width:(GLfloat)w height:(GLfloat)h
{
	if (self = [super initWithColor:color width:w height:h]) {
		dir = [CCDirector sharedDirector];
		CGSize winSize = [dir winSize];
		CCSprite *bg = [CCSprite spriteWithFile:@"menubg.png"];
		//opacity 0-255 araliginda
		[bg setOpacity:200];
		[self addChild:bg z:1];
		self.position = ccp((winSize.width - w)/2, (winSize.height - h)/2);
	}
	return self;
}

@end
