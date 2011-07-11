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
	return [self initWithColor:ccc4(155, 155, 65, 125) width:-1 height:-1];
}

-(id)initWithColor:(ccColor4B)color width:(GLfloat)w height:(GLfloat)h
{
	CCSprite *bg = [CCSprite spriteWithFile:@"menubg.png"];
	[bg setOpacity:210];
	dir = [CCDirector sharedDirector];
	CGSize winSize = [dir winSize];
	
	if (w == -1) {
		w = bg.contentSize.width;
	}
	
	if (h == -1) {
		w = bg.contentSize.height;
	}

	if (self = [super initWithColor:color width:w height:h]) {
		
		CCMenuItemFont *cem= [CCMenuItemFont itemFromString:@"Ayarlar"];
		CCMenuItemFont *ajda= [CCMenuItemFont itemFromString:@"Yardım"];
		CCMenuItemFont *a = [CCMenuItemFont itemFromString:@"Hakkında"];
		CCMenu *menu = [CCMenu menuWithItems:cem,ajda,a, nil];
		[menu setColor:ccc3(255, 0, 0)];

		[menu alignItemsVertically];
		
		//opacity 0-255 araliginda
		
		menu.position = ccp(0, 0);
		
		[self addChild:bg z:1];
		[self addChild:menu z:2];
		self.position = ccp(winSize.width/2, winSize.height/2);
	}
	return self;
}

@end
