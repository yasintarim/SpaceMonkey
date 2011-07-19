//
//  PauseMenuButtonLayer.m
//  SpaceMonkey
//
//  Created by Yasin Tarim on 7/4/11.
//  Copyright 2011 YKB. All rights reserved.
//

#import "PauseMenuButtonLayer.h"
#define PAUSEMENUTAG	999
@implementation PauseMenuButtonLayer

- (id)init
{
    self = [super init];
    if (self) {
		
		CCMenuItem *resume = [CCMenuItemImage itemFromNormalImage:@"ButtonPlus.png" selectedImage:@"ButtonPlusSel.png"];
		CCMenuItem *pause = [CCMenuItemImage itemFromNormalImage:@"ButtonMinus.png" selectedImage:@"ButtonMinusSel.png"];
		CGSize winSize = [[CCDirector sharedDirector] winSize];
	__block BOOL m_menuVisible = NO;
		m_pauseMenu = [[PauseMenuLayer alloc] initWithColor:ccc4(155, 155, 65, 125) width:-1 height:-1];
		m_pauseMenu.tag = PAUSEMENUTAG;
		
		CCMenuItemToggle *itemToggle = [CCMenuItemToggle itemWithBlock:^(id arg) {
			
			if ((m_menuVisible = !m_menuVisible)) {
				[[self parent] addChild:m_pauseMenu z:PAUSEMENUTAG];
				[[CCDirector sharedDirector] pause];
			}
			else
			{
				[[self parent] removeChildByTag:PAUSEMENUTAG cleanup:YES];
				[[CCDirector sharedDirector] resume];
			}			
		} items:resume,pause, nil];
		
		CCMenu *menu = [CCMenu menuWithItems:itemToggle, nil];
		CGSize menuSize= [resume contentSize];
		menu.position = ccp(winSize.width - menuSize.width /2, winSize.height  - menuSize.height/2);
		[self addChild:menu z:1];

    }
    
    return self;
}
-(void)dealloc
{
	[m_pauseMenu release];
	[super dealloc];
}

@end
