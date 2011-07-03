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
	if ((self = [super init])) {
		[self initWithColor:ccc4(155, 155, 155, 120) width:200 height:200];
	}	
	return self;
}

-(id)initWithColor:(ccColor4B)color width:(GLfloat)w height:(GLfloat)h
{
	if (self = [super initWithColor:color width:w height:h]) {
		dir = [CCDirector sharedDirector];
		CGSize winSize = [dir winSize];
		self.position = ccp((winSize.width - w)/2, (winSize.height - h)/2);
	}
	return self;
}

@end
